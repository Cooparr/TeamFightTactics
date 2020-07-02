//
//  BSCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 16/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class BSCell: BaseCell, ReusableCell {
    
    //MARK:- Properties
    typealias DataType = [Item]
    static var reuseId: String = "baseSectionId"
    
    var allItems = [Item]() {
        didSet {
            populateBaseItemSelector()
        }
    }
    
    var filteredItems = [Item]() {
        didSet {
            guard oldValue != filteredItems else { return }
            filteredItems.sort(by: { $0.tier.rawValue < $1.tier.rawValue })
            baseSectionItemsColView.reloadSections(IndexSet(integer: 0))
        }
    }
    
    lazy var baseItemSelectorVC: BSItemSelectorController = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let selector = BSItemSelectorController(collectionViewLayout: layout)
        selector.baseSection = self
        return selector
    }()
    
    lazy var baseSectionItemsColView: UICollectionView = {
        let colView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        colView.translatesAutoresizingMaskIntoConstraints = false
        colView.backgroundColor = ThemeColor.richBlack
        colView.showsVerticalScrollIndicator = false
        colView.register(BSItemCell.self, forCellWithReuseIdentifier: BSItemCell.reuseId)
        colView.dataSource = self
        return colView
    }()
    
    
    //MARK:- Configure Cell
    func configureCell(with items: [Item]) {
        self.allItems = items
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
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(110))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: layoutSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    
    //MARK:- Populate Base Item Selector Array
    fileprivate func populateBaseItemSelector() {
        var baseItems = [Item]()
        for item in allItems.sorted(by: { $0.tier.rawValue < $1.tier.rawValue }) {
            if item.into != nil {
                baseItems.append(item)
            }
        }
        baseItemSelectorVC.allBaseItems = baseItems
    }
}


//MARK:- UICollectionView Data Source
extension BSCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BSItemCell = collectionView.dequeueReusableCell(BSItemCell.self, for: indexPath)
        cell.configureCell(with: filteredItems[indexPath.item])
        return cell
    }
}
