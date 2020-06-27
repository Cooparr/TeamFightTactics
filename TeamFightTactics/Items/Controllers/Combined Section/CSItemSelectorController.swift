//
//  CSItemSelectorController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 26/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class CSItemSelectorController: UICollectionViewController {
    
    weak var combinedSection: CSCell?
    var allCombinedItems = [Item]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    
    //MARK:- Load View
    override func loadView() {
        super.loadView()
        self.view = collectionView
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.selectItem(at: IndexPath(item: 22, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CSSelectorCell.self, forCellWithReuseIdentifier: CSSelectorCell.reuseId)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = ThemeColor.richBlack
        collectionView.dataSource = self
        collectionView.delegate = self
    } 
}


//MARK:- UICollectionView Delegate & Data Source
extension CSItemSelectorController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allCombinedItems.count
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CSSelectorCell = collectionView.dequeueReusableCell(CSSelectorCell.self, for: indexPath)
        cell.configureCell(with: allCombinedItems[indexPath.item])
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        guard let combinedSection = combinedSection else { return }
        let selectedItem = allCombinedItems[indexPath.item]
        guard !combinedSection.testArray.contains(selectedItem) else { return }
        
        if combinedSection.testArray.count >= 5 {
            combinedSection.testArray.removeLast()
        }
        
        combinedSection.testArray.insert(selectedItem, at: 0)
        combinedSection.combinedSectionItemsColView.reloadData()
    }
}
