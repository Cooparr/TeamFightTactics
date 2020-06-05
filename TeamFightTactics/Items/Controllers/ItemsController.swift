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
            itemsView.reloadData()
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
    
    
    //MARK: Navigation Bar Code
    fileprivate func navigationBarSetup() {
        navigationItem.title = "Items"
        rightNavBarSettingsButton()
    }
    
    
    //MARK:- Assign Collection View Delegates
    fileprivate func assignDelegates() {
        itemsView.delegate = self
        itemsView.dataSource = self
    }
}


//MARK:- CollectionView Datasource
extension ItemsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseId.itemCell, for: indexPath) as! ItemCell
        let item = allItems[indexPath.item]
        cell.setItem(item)
        
        return cell
    }
}


//MARK:- CollectionView Delegate Flow Layout
extension ItemsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemsView.frame.width - 20, height: 150)
    }
}
