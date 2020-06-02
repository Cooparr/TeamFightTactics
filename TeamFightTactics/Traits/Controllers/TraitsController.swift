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
    
    
    //MARK:- Navigation Bar Code
    fileprivate func navigationBarSetup() {
        navigationItem.title = "Traits"
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        rightNavBarSettingsButton()
    }
    
    
    //MARK:- Assign Collection View Delegates
    fileprivate func assignDelegates() {
        traitsView.traitCollectionView.delegate = self
        traitsView.traitCollectionView.dataSource = self
    }
}

extension TraitsController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseId.traitCell, for: indexPath) as! TraitsCell
        
        switch indexPath.section {
        case 0:
            cell.traits = self.classes
        default:
            cell.traits = self.origins
        }
        
        return cell
    }
}
