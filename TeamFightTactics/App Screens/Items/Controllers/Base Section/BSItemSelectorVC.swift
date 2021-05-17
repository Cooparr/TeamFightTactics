//
//  BSItemSelectorVC.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 23/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

//MARK: Base Selector Delegate
protocol BaseSelectorDelegate: AnyObject {
    func baseSelectorRetrieveItemsBuiltFrom(didSelect baseItem: Item)
}


//MARK: Base Section Item Selector VC
class BSItemSelectorVC: UICollectionViewController {
    
    //MARK:- Properties
    private(set) var allBaseItems = [Item]()
    weak var baseSelectorDelegate: BaseSelectorDelegate?

    
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
        
        guard let firstBaseItem = allBaseItems.first else { return }
        baseSelectorDelegate?.baseSelectorRetrieveItemsBuiltFrom(didSelect: firstBaseItem)
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
        let selectedBaseItem = allBaseItems[indexPath.item]
        baseSelectorDelegate?.baseSelectorRetrieveItemsBuiltFrom(didSelect: selectedBaseItem)
    }
}
