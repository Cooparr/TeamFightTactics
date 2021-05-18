//
//  BSCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 16/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class BSCell: BaseColViewCell, ReusableCell {
    
    //MARK:- Properties
    typealias DataType = [Item]
    static var reuseId: String = "baseSectionId"
    
    private(set) var allItems = [Item]()
    private(set) var filteredItems = [Item]()
    
    lazy var baseItemSelectorVC: BSItemSelectorVC = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let selector = BSItemSelectorVC(collectionViewLayout: layout)
        selector.baseSelectorDelegate = self
        return selector
    }()
    
    lazy var baseSectionItemsColView: UICollectionView = {
        let colView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        colView.translatesAutoresizingMaskIntoConstraints = false
        colView.backgroundColor = ThemeColor.richBlack
        colView.showsVerticalScrollIndicator = false
        colView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.reuseId)
        colView.dataSource = self
        return colView
    }()
    
    
    //MARK:- Configure Cell
    func configureCell(with items: [Item]) {
        guard !items.isEmpty else { return }
        
        self.allItems = items
        let arrayOfBaseItems = items.filter { $0.into != nil }
        baseItemSelectorVC.configureBaseSelectorVC(baseItems: arrayOfBaseItems)
    }
    
    
    //MARK:- Setup Cell Views
    override func setupCellViews() {
        addSubview(baseItemSelectorVC.view)
        NSLayoutConstraint.activate([
            baseItemSelectorVC.view.heightAnchor.constraint(equalToConstant: 70),
            baseItemSelectorVC.view.topAnchor.constraint(equalTo: topAnchor),
            baseItemSelectorVC.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            baseItemSelectorVC.view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        addSubview(baseSectionItemsColView)
        NSLayoutConstraint.activate([
            baseSectionItemsColView.topAnchor.constraint(equalTo: baseItemSelectorVC.view.bottomAnchor),
            baseSectionItemsColView.leadingAnchor.constraint(equalTo: leadingAnchor),
            baseSectionItemsColView.trailingAnchor.constraint(equalTo: trailingAnchor),
            baseSectionItemsColView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    //MARK:- Create Compositional Layout
    fileprivate func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(130))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: layoutSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        return UICollectionViewCompositionalLayout(section: section)
    }
}


//MARK:- BaseSelectorDelegate
extension BSCell: BaseSelectorDelegate {
    func baseSelectorRetrieveItemsBuiltFrom(didSelect baseItem: Item) {
        let itemsCreatedFromBaseItem = allItems.filter {
            guard let from = $0.from else { return false }
            return from.contains(baseItem.name)
        }.sorted { $0.tier.rawValue < $1.tier.rawValue }
        
        guard itemsCreatedFromBaseItem != filteredItems else { return }
        filteredItems = itemsCreatedFromBaseItem
        baseSectionItemsColView.reloadDataOnMainThread()
    }
}


//MARK:- UICollectionView Data Source
extension BSCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ItemCell.self, for: indexPath)
        cell.configureCell(with: filteredItems[indexPath.item])
        return cell
    }
}
