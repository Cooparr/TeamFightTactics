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
        register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ItemsCell")
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ThemeColor.charcoal
        showsVerticalScrollIndicator = false
        dataSource = self
        delegate = self
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK:- CollectionView Datasource
extension ItemsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemsCell", for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
}


//MARK:- CollectionView Delegate Flow Layout
extension ItemsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 150)
    }
}
