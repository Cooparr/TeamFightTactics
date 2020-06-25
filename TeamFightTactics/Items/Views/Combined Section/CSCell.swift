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
        }
    }
    
    let combinedItemsColView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 40, left: 10, bottom: 40, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        let colView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colView.translatesAutoresizingMaskIntoConstraints = false
        colView.backgroundColor = ThemeColor.richBlack
        colView.showsVerticalScrollIndicator = false
        colView.showsHorizontalScrollIndicator = false
        colView.register(CStemCell.self, forCellWithReuseIdentifier: CStemCell.reuseId)
        return colView
    }()
    
    
    //MARK:- Setup Cell
    override func setupCell() {
        combinedItemsColView.dataSource = self
        combinedItemsColView.delegate = self
        
        addSubview(combinedItemsColView)
        NSLayoutConstraint.activate([
            combinedItemsColView.heightAnchor.constraint(equalToConstant: 250),
            combinedItemsColView.topAnchor.constraint(equalTo: topAnchor),
            combinedItemsColView.leadingAnchor.constraint(equalTo: leadingAnchor),
            combinedItemsColView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    
    //MARK:- Configure Cell
    func configureCell(with items: [Item]) {
        self.combinedItems = items
    }
}


//MARK:- UICollectionView Delegate & Data Source
extension CSCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return combinedItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CStemCell = collectionView.dequeueReusableCell(CStemCell.self, for: indexPath)
        cell.configureCell(with: combinedItems[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
}
