//
//  DropRatesView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 15/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class DropRatesView: UIView {
    
    
    //MARK:- Properties
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(DropRateCell.self, forCellWithReuseIdentifier: ReuseId.dropRateCell)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = ThemeColor.charcoal
        return collectionView
    }()
    
    
    //MARK:- Override Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = ThemeColor.independence
        setupCollectionViewConstraints()
    }
    
    
    //MARK:- Constraint Functions
    fileprivate func setupCollectionViewConstraints() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: centerYAnchor),
            collectionView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 3/4),
            collectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/2)
        ])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
