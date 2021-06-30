//
//  TraitsController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 11/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit
import FirebaseFirestore

class TraitsController: UIViewController {
    
    //MARK:- Properties
    private let traitsView = TraitsView()
    private(set) var classes = [Trait]()
    private(set) var origins = [Trait]()
    
    
    //MARK: Firebase Listeners
    private var classesListener: ListenerRegistration?
    private var originsListener: ListenerRegistration?
    
    
    //MARK:- Load View
    override func loadView() {
        super.loadView()
        self.view = traitsView
    }
    
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetup()
        assignDelegates()
    }
    
    
    //MARK:- View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchTraits()
    }
    
    
    //MARK:- View Will Disappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        originsListener?.remove()
        classesListener?.remove()
    }
    
    
    //MARK:- Fetch Traits
    private func fetchTraits() {
        let firestore = SetDataManager()
        self.originsListener = firestore.fetchData(from: .origins) { (originsResult: Result<[Trait], Error>) in
            self.classesListener = firestore.fetchData(from: .classes) { (classesResult: Result<[Trait], Error>) in
                do {
                    self.origins = try originsResult.get().sorted { $0.name < $1.name }
                    self.classes = try classesResult.get().sorted { $0.name < $1.name }
                    self.traitsView.traitCollectionView.reloadDataOnMainThread()
                } catch let error {
                    self.presentErrorAlertOnMainThread(title: "Error Fetching Traits", message: error.localizedDescription)
                }
            }
        }
    }
    
    
    //MARK:- Navigation Bar Code
    private func navigationBarSetup() {
        setupNavBar(navTitle: TabTitle.traits)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    }
    
    
    //MARK:- Assign Collection View Delegates
    private func assignDelegates() {
        traitsView.traitCollectionView.delegate = self
        traitsView.traitCollectionView.dataSource = self
    }
}

extension TraitsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        traitsView.menuBar.menuView.menuIndicatorLeadingConstraint?.constant = scrollView.contentOffset.x / CGFloat(traitsView.menuBar.menuTitles.count)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x / traitsView.frame.width)
        let indexPath = IndexPath(item: 0, section: index)
        traitsView.menuBar.menuView.menuCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
}


extension TraitsController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return traitsView.menuBar.menuTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return traitsView.menuBar.menuTitles.count / traitsView.menuBar.menuTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TraitsPageCell.reuseId, for: indexPath) as! TraitsPageCell
        cell.traits = indexPath.section == 0 ? self.classes : self.origins
        return cell
    }
}
