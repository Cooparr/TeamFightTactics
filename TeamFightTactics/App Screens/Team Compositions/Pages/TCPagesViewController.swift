//
//  TCPagesViewController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 17/11/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCPagesViewController: UIViewController {
    
    //MARK:- Properties
    private let tcTwoRootView = TCPagesView()
    private let teamCompPages = [MetaTCViewController(), DisplayTeamCompsVC()]
    
    
    //MARK:- Load View
    override func loadView() {
        super.loadView()
        self.view = tcTwoRootView
    }
    
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        setupNavBar(navTitle: TabTitle.teamComps)
        tcTwoRootView.horizontalScrollView.delegate = self
        addTeamCompChildVCPages(viewControllers: teamCompPages)
    }
    
    
    //MARK:- Add Team Comp Child VC Pages
    fileprivate func addTeamCompChildVCPages(viewControllers: [UIViewController]) {
        viewControllers.forEach {
            add(childVC: $0, toStack: tcTwoRootView.pagesStackView)
            tcTwoRootView.constrainPageInStackView(pageView: $0.view)
        }
    }
    
    
    //MARK: Update Right Nav Bar Button
    fileprivate func updateRightNavBarButton(_ scrollView: UIScrollView) -> UIBarButtonItem? {
        switch scrollView.contentOffset.x {
        case 0:
            return UIBarButtonItem(image: SFSymbol.NavIcon.settings, style: .plain, target: self, action: #selector(UIViewController.goToSettings))
        case tcTwoRootView.frame.size.width:
            return UIBarButtonItem(image: SFSymbol.NavIcon.addTeamComp, style: .plain, target: self, action: #selector(self.presentCreateCustomTCVC))
        default:
            return nil
        }
    }
    
    
    //MARK: Present Create Custom Team Comp
    @objc fileprivate func presentCreateCustomTCVC() {
        self.navigationController?.pushViewController(CreateTCPageViewController(), animated: true)
    }
}


//MARK:- CollectionView Delegate Flow Layout
extension TCPagesViewController: UICollectionViewDelegateFlowLayout {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tcTwoRootView.menuBar.menuView.menuIndicatorLeadingConstraint?.constant = scrollView.contentOffset.x / CGFloat(tcTwoRootView.menuBar.menuTitles.count)
        navigationItem.setRightBarButton(updateRightNavBarButton(scrollView), animated: true)
    }
}


