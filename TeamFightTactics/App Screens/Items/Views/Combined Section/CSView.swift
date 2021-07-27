//
//  CSView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 30/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class CSView: BaseView {
    
    //MARK:- Properties
    private(set) var showShadowItemsView = ShowVariantItemsSwitchView()
    private(set) var placeholderView = MainCSItemsPlaceholderView()
    
    lazy var collectionView: UICollectionView = {
        let colView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        colView.translatesAutoresizingMaskIntoConstraints = false
        colView.backgroundColor = ThemeColor.richBlack
        colView.showsVerticalScrollIndicator = false
        colView.register(ItemSelectorCell.self, forCellWithReuseIdentifier: ItemSelectorCell.reuseId)
        colView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.reuseId)
        colView.alwaysBounceVertical = false
        return colView
    }()
    
    
    //MARK:- Setup View
    override func setupView() {
        addSubviews(showShadowItemsView, collectionView, placeholderView)
        constrainShowShadowItemsView()
        constrainCollectionView()
        constrainPlaceholderView()
    }
    
    
    //MARK:- Create Compositional Layout
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            guard let section = CSItemController.CSSection(rawValue: sectionIndex) else { fatalError("Unknown section") }
            switch section {
            case .selector:
                return self.createSelectorSection()
            case .main:
                return self.createMainSection()
            }
        }
        return layout
    }
    
    
    //MARK: Create Selector Section
    fileprivate func createSelectorSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(50), heightDimension: .absolute(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(50), heightDimension: .absolute(170))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 15, trailing: 10)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        return section
    }
    
    
    //MARK: Create Main Section
    fileprivate func createMainSection() -> NSCollectionLayoutSection {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(110))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: layoutSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        return section
    }
    
    
    //MARK:- Constrain Show Shadow Item View
    private func constrainShowShadowItemsView() {
        NSLayoutConstraint.activate([
            showShadowItemsView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            showShadowItemsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            showShadowItemsView.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -15)
        ])
    }
    
    
    //MARK: Constrain Collection View
    private func constrainCollectionView() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: showShadowItemsView.bottomAnchor, constant: 15),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    //MARK: Constrain Placeholder View
    private func constrainPlaceholderView() {
        NSLayoutConstraint.activate([
            placeholderView.heightAnchor.constraint(equalToConstant: 70),
            placeholderView.centerXAnchor.constraint(equalTo: centerXAnchor),
            placeholderView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 50),
            placeholderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            placeholderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}
