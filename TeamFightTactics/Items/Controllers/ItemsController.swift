//
//  ItemsController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 22/07/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class ItemsController: UIViewController {

    //MARK: Properties
    private let itemsView = ItemsView()
    var allItems = [Item]() {
        didSet {
            itemsView.activityIndicator.stopAnimating()
            itemsView.itemsCollectionView.reloadData()
        }
    }
    
    //MARK: Load View
    override func loadView() {
        super.loadView()
        self.view = itemsView
    }
    
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetup()
        assignDelegates()
    }
    
    
    //MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if allItems.isEmpty {
            itemsView.activityIndicator.startAnimating()
        }
    }

    //MARK: Navigation Bar Code
    fileprivate func navigationBarSetup() {
        navigationItem.title = "Items"
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        rightNavBarSettingsButton()
    }


    //MARK:- Assign Collection View Delegates
    fileprivate func assignDelegates() {
        itemsView.itemsCollectionView.delegate = self
        itemsView.itemsCollectionView.dataSource = self
    }
    
    
    //MARK:- Reload Sections
    fileprivate func reloadSectionsIfItemsChanged() {
        itemsView.activityIndicator.stopAnimating()
        itemsView.itemsCollectionView.reloadData()
    }
}


//MARK:- CollectionView Datasource
extension ItemsController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell: BSCell = collectionView.dequeueReusableCell(BSCell.self, for: indexPath)
            cell.configureCell(with: allItems)
            return cell
        } else {
            let cell: CSCell = collectionView.dequeueReusableCell(CSCell.self, for: indexPath)
            cell.configureCell(with: allItems.filter({ $0.from != nil }))
            return cell
        }
    }
}


//MARK:- CollectionView Delegate Flow Layout
extension ItemsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        itemsView.menuBar.menuView.menuIndicatorLeadingConstraint?.constant = scrollView.contentOffset.x / CGFloat(itemsView.menuBar.menuTitles.count)
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x / itemsView.frame.width)
        let indexPath = IndexPath(item: 0, section: index)
        itemsView.menuBar.menuView.menuCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
}
