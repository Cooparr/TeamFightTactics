//
//  BSItemSelectorController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 23/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class BSItemSelectorController: UICollectionViewController {
    
    //MARK:- Properties
    weak var baseSection: BSCell?
    var allBaseItems = [Item]() {
        didSet {
            collectionView.reloadData()
        }
    }

    
    //MARK:- Load View
    override func loadView() {
        super.loadView()
        self.view = collectionView
    }
    
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    
    //MARK:- View Did Appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initalLoadSetup()
    }
    
    
    //MARK:- Setup Collection View
    fileprivate func setupCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(BSSelectorCell.self, forCellWithReuseIdentifier: BSSelectorCell.reuseId)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = ThemeColor.richBlack
        collectionView.allowsSelection = true
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    
    //MARK:- Initial View Load Setup
    fileprivate func initalLoadSetup() {
        collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: [])
        filterAllItemsByBaseItemId(baseItemIndex: 0)
    }
    
    
    //MARK:- Filter Items By Base Item Id
    fileprivate func filterAllItemsByBaseItemId(baseItemIndex: Int) {
        guard let baseSection = baseSection else { return }
        baseSection.filteredItems = baseSection.allItems.filter({
            guard let from = $0.from else { return false }
            return from.contains(allBaseItems[baseItemIndex].id)
        })
    }
}


//MARK:- CollectionView Datasource
extension BSItemSelectorController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allBaseItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(BSSelectorCell.self, for: indexPath)
        cell.configureCell(with: allBaseItems[indexPath.item])
        return cell
    }
}


//MARK:- CollectionView Delegate Flow Layout
extension BSItemSelectorController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = 40
        return CGSize(width: cellSize, height: cellSize)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        filterAllItemsByBaseItemId(baseItemIndex: indexPath.item)
    }
}
