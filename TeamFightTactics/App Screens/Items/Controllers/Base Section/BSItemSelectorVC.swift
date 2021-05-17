//
//  BSItemSelectorVC.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 23/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class BSItemSelectorVC: UICollectionViewController {
    
    //MARK:- Properties
    weak var baseSection: BSCell?
    private(set) var allBaseItems = [Item]()

    
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
    
    
    //MARK:- Setup Collection View
    fileprivate func setupCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ItemSelectorCell.self, forCellWithReuseIdentifier: ItemSelectorCell.reuseId)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = ThemeColor.richBlack
        collectionView.allowsSelection = true
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    //MARK: Configure Base Selector VC
    func configureBaseSelectorVC(allItems: [Item]) {
        self.allBaseItems = allItems.filter { $0.into != nil }
        collectionView.reloadData()
        collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: [])
        filterAllItemsByBaseItemId(baseItemIndex: 0)
    }
    
    
    //MARK:- Filter Items By Base Item Id
    fileprivate func filterAllItemsByBaseItemId(baseItemIndex: Int) {
        guard let baseSection = baseSection else { return }
        baseSection.filteredItems = baseSection.allItems.filter({
            guard let from = $0.from else { return false }
            return from.contains(allBaseItems[baseItemIndex].name)
        })
    }
}


//MARK:- CollectionView Datasource
extension BSItemSelectorVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allBaseItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ItemSelectorCell.self, for: indexPath)
        cell.configureCell(with: allBaseItems[indexPath.item])
        if !cell.isSelected { cell.contentView.alpha = cell.fadedAlphaValue }
        return cell
    }
}


//MARK:- CollectionView Delegate Flow Layout
extension BSItemSelectorVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = 40
        return CGSize(width: cellSize, height: cellSize)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        filterAllItemsByBaseItemId(baseItemIndex: indexPath.item)
    }
}
