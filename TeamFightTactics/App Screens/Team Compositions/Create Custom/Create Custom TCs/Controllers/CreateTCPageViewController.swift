//
//  CreateTCPageViewController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 30/05/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class CreateTCPageViewController: UIPageViewController {
    
    //MARK: Current Page Enum
    enum CurrentPage: Int {
        case champItemSelection
        case informationSave
    }
    
    
    //MARK: Properties
    static let maxTeamCompSize = 9
    static let champOccurencesPerTeamComp = 2
    static let minimumChampionsPerTeamComp = 3
    
    let pages: [UIViewController]
    private(set) var currentPage: CurrentPage = .champItemSelection
    private var currentPageIndex = 0 {
        willSet {
            pageControl.currentPage = newValue
            updateNavBarButtons(with: newValue)
        }
    }
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = ThemeColor.platinum
        pageControl.pageIndicatorTintColor = ThemeColor.charcoal
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = currentPageIndex
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        return pageControl
    }()
    
    
    #warning("This is ugly, should think of a better way to do this without so muhc duplication")
    //MARK:- Create New Init
    required init() {
        let champItemSelectionPage = CreateTCSelectionPageVC()
        let teamCompNameDescriptionPage = CreateTCSavePageVC()
        teamCompNameDescriptionPage.saveDelegate = champItemSelectionPage
        pages = [champItemSelectionPage, teamCompNameDescriptionPage]

        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        dataSource = self
        delegate = self
        setViewControllers([pages[currentPageIndex]], direction: .forward, animated: true, completion: nil)

        navigationItem.title = TabTitle.createTeamComp.rawValue
    }

    
    //MARK: Update Init
    required init(teamCompToUpdate: CustomTeamComposition) {
        let champItemSelectionPage = CreateTCSelectionPageVC()
        let teamCompNameDescriptionPage = UpdateTCSavePageVC(teamCompToUpdate: teamCompToUpdate)
        teamCompNameDescriptionPage.saveDelegate = champItemSelectionPage

        champItemSelectionPage.selectedTeamCompVC.selectedChampsForTeamComp = teamCompToUpdate.champions
        teamCompNameDescriptionPage.savePageView.nameTextField.text = teamCompToUpdate.title
        teamCompNameDescriptionPage.savePageView.descTextView.text = teamCompToUpdate.description

        pages = [champItemSelectionPage, teamCompNameDescriptionPage]

        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        dataSource = self
        delegate = self
        setViewControllers([pages[currentPageIndex]], direction: .forward, animated: true, completion: nil)

        navigationItem.title = teamCompToUpdate.title
    }
    
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        updateNavBarButtons(with: currentPageIndex)
    }
    
    
    //MARK: Constrain Page Control
    private func setupView() {
        view.backgroundColor = ThemeColor.richBlack
        view.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: pageControl.bottomAnchor, multiplier: 1),
        ])
    }
    
    
    //MARK:- Page Control Action
    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
    }
    
    
    //MARK:- Update Nav Bar Buttons
    private func updateNavBarButtons(with pageIndex: Int) {
        guard let newPage = CurrentPage(rawValue: pageIndex) else { return }
        currentPage = newPage
        
        switch currentPage {
        case .champItemSelection:
            let nextButton = UIBarButtonItem(title: NavBarBtnTitle.next.rawValue, style: .plain, target: self, action: #selector(nextPageTapped))
            navigationItem.rightBarButtonItem = nextButton
            navigationItem.setHidesBackButton(false, animated: true)
            navigationItem.leftBarButtonItem = nil
            
        case .informationSave:
            let backButton = UIBarButtonItem(title: NavBarBtnTitle.previous.rawValue, style: .plain, target: self, action: #selector(previousPageTapped))
            navigationItem.leftBarButtonItem = backButton
            navigationItem.setHidesBackButton(true, animated: true)
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    
    //MARK: Next Page Action
    @objc func previousPageTapped() {
        guard let currentPage = viewControllers?.first else { return }
        guard let previousPage = dataSource?.pageViewController(self, viewControllerBefore: currentPage) else { return }

        setViewControllers([previousPage], direction: .reverse, animated: true, completion: nil)
        currentPageIndex -= 1
    }
    
    
    //MARK: Next Page Action
    @objc func nextPageTapped() {
        guard let currentPage = viewControllers?.first else { return }
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
        
        setViewControllers([nextPage], direction: .forward, animated: true, completion: nil)
        currentPageIndex += 1
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK:- UIPageController Data Source
extension CreateTCPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard var currentIndex = pages.firstIndex(of: viewController) else { return nil }
        let firstPage = 0
        currentIndex -= 1
        guard currentIndex >= firstPage else { return nil }
        return pages[currentIndex]
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard var currentIndex = pages.firstIndex(of: viewController) else { return nil }
        let lastPage = pages.count
        currentIndex += 1
        guard currentIndex < lastPage else { return nil }
        return pages[currentIndex]
    }
}


//MARK:- UIPageController Delegates
extension CreateTCPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let pageVC = pageViewController.viewControllers?.first else { return }
        guard let currentIndex = pages.firstIndex(of: pageVC) else { return }
        currentPageIndex = currentIndex
    }
}
