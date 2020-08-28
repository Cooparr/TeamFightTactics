//
//  TraitsPageCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 27/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class TraitsPageCell: BaseColViewCell {
    
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
        colView.register(TraitCell.self, forCellWithReuseIdentifier: ReuseId.traitCell)
        return colView
    }()
    
    
    //MARK: Override Setup Cell Views
    override func setupCellViews() {
        addSubview(collectionView)
        collectionView.pinSubview(to: self)
    }
}


// MARK:- CollectionView Delegates
extension TraitsPageCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return colViewInsets
    }
}


// MARK:- CollectionView Data Source
extension TraitsPageCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return traits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseId.traitCell, for: indexPath) as! TraitCell
        cell.trait = traits[indexPath.item]
        return cell
    }
    
}
