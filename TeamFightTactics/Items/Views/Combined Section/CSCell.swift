//
//  CSCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 16/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class CSCell: BaseCell, ReusableCell{
    
    //MARK:- Properties
    typealias DataType = [Item]
    static var reuseId: String = "combinedSectionId"
    
    var combinedItems = [Item]() {
        didSet {
            combinedItems.removeAll { (item) -> Bool in
                item.from == nil
            }
            combinedItemsSelectorVC.allCombinedItems = self.combinedItems
        }
    }
    
    var testArray = [Item]() {
        didSet {
//            combinedSectionItemsColView.reloadData()
//            print("----------")
//            for item in testArray {
//                print(item.name)
//            }
        }
    }
    
    lazy var combinedItemsSelectorVC: CSItemSelectorController = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        let selector = CSItemSelectorController(collectionViewLayout: layout)
        selector.combinedSection = self
        return selector
    }()
    
    
    lazy var combinedSectionItemsColView: UICollectionView = {
        let colView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        colView.translatesAutoresizingMaskIntoConstraints = false
        colView.backgroundColor = ThemeColor.richBlack
        colView.showsVerticalScrollIndicator = false
        colView.register(CSItemCell.self, forCellWithReuseIdentifier: CSItemCell.reuseId)
        colView.dataSource = self
        return colView
    }()
    
    
    //MARK:- Create Compositional Layout
    fileprivate func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(80))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(80))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    
    //MARK:- Setup Cell
    override func setupCellViews() {
        
        addSubview(combinedItemsSelectorVC.view)
        NSLayoutConstraint.activate([
            combinedItemsSelectorVC.view.heightAnchor.constraint(equalToConstant: 210),
            combinedItemsSelectorVC.view.topAnchor.constraint(equalTo: topAnchor),
            combinedItemsSelectorVC.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            combinedItemsSelectorVC.view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        addSubview(combinedSectionItemsColView)
        NSLayoutConstraint.activate([
            combinedSectionItemsColView.topAnchor.constraint(equalTo: combinedItemsSelectorVC.view.bottomAnchor),
            combinedSectionItemsColView.leadingAnchor.constraint(equalTo: leadingAnchor),
            combinedSectionItemsColView.trailingAnchor.constraint(equalTo: trailingAnchor),
            combinedSectionItemsColView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    //MARK:- Configure Cell
    func configureCell(with items: [Item]) {
        self.combinedItems = items
    }
}

extension CSCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CSItemCell.self, for: indexPath)
        cell.configureCell(with: testArray[indexPath.item])
        return cell
    }
}
