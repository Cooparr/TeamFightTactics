//
//  GalaxiesView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 09/09/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class GalaxiesView: BaseView {
    
    //MARK: Properties
    lazy var collectionView: UICollectionView = {
        var colView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        colView.translatesAutoresizingMaskIntoConstraints = false
        colView.backgroundColor = ThemeColor.richBlack
        colView.showsVerticalScrollIndicator = false
        colView.register(GalaxyCell.self, forCellWithReuseIdentifier: GalaxyCell.reuseId)
        return colView
    }()
    
    //MARK:- Create Layout
    func createLayout() -> UICollectionViewLayout {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(75))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: layoutSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    override func setupView() {
        addSubview(collectionView)
        collectionView.pinSubview(to: self)
    }
}
