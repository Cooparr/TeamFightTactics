//
//  TraitsCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 27/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class TraitsCell: BaseCell {
    
    //MARK: Properties
    var traits = [Trait]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let colViewInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    lazy var collectionView: UICollectionView = {
        let inset = colViewInsets.left + colViewInsets.right
        
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: self.bounds.width - inset, height: 10)
        
        let colView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colView.translatesAutoresizingMaskIntoConstraints = false
        colView.backgroundColor = ThemeColor.richBlack
        colView.showsVerticalScrollIndicator = false
        colView.dataSource = self
        colView.delegate = self
        colView.register(TraitInfoCell.self, forCellWithReuseIdentifier: ReuseId.infoCell)
        return colView
    }()
    
    
    //MARK: Override Setup Cell Views
    override func setupCellViews() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}


// MARK:- CollectionView Delegates
extension TraitsCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return colViewInsets
    }
}


// MARK:- CollectionView Data Source
extension TraitsCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return traits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseId.infoCell, for: indexPath) as! TraitInfoCell
        cell.trait = traits[indexPath.item]
        return cell
    }
    
}
