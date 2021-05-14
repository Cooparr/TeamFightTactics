//
//  TraitsController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 11/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class TraitsController: UIViewController {
    
    //MARK:- Properties
    private let traitsView = TraitsView()
    var displayedSet: Double?
    var classes = [Trait]() {
        didSet {
            traitsView.traitCollectionView.reloadData()
        }
    }
    
    var origins = [Trait]() {
        didSet {
            traitsView.traitCollectionView.reloadData()
        }
    }
    
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
    
    
    //MARK:- Fetch Traits
    fileprivate func fetchTraits() {
        let fetchedSet = UserDefaults.standard.double(forKey: UDKey.setKey)
        if displayedSet != fetchedSet {
            let firestore = FirestoreManager()
            firestore.fetchSetData(from: .classes, updateKey: .classes) { classes in
                self.classes = classes.sorted(by: { $0.name < $1.name })
            }
            
            firestore.fetchSetData(from: .origins, updateKey: .origins) { origins in
                self.origins = origins.sorted(by: { $0.name < $1.name })
            }
        }
    }
    
    
    //MARK:- Navigation Bar Code
    fileprivate func navigationBarSetup() {
        setupNavBar(navTitle: TabTitle.traits)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    }
    
    
    //MARK:- Assign Collection View Delegates
    fileprivate func assignDelegates() {
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
