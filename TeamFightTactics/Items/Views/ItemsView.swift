//
//  ItemsView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 04/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class ItemsView: UICollectionView {
    
    //MARK:- Properties
    
    
    //MARK:- Override Init
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        setupCollectionView()
    }
    
    
    //MARK: Setup Collection View
    fileprivate func setupCollectionView() {
        register(ItemCell.self, forCellWithReuseIdentifier: ReuseId.itemCell)
        contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        backgroundColor = ThemeColor.charcoal
        showsVerticalScrollIndicator = false
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
