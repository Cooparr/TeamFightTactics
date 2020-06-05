//
//  ItemsView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 04/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class ItemsView: BaseView {
    
    //MARK:- Properties
    lazy var menuBar: MenuBarController = {
        let menu = MenuBarController(menuTitles: ["Base", "Combined"])
        menu.selectedView = itemsCollectionView.self
        return menu
    }()
    
    let itemsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let colView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colView.translatesAutoresizingMaskIntoConstraints = false
        colView.register(ItemPageCell.self, forCellWithReuseIdentifier: ReuseId.itemPageCell)
        colView.backgroundColor = ThemeColor.charcoal
        colView.showsHorizontalScrollIndicator = false
        colView.isPagingEnabled = true
        return colView
    }()
    
    
    //MARK:- Override Init
    override func setupSubviews() {
        addSubview(menuBar.view)
        NSLayoutConstraint.activate([
            menuBar.menuView.heightAnchor.constraint(equalToConstant: 50),
            menuBar.menuView.topAnchor.constraint(equalTo: topAnchor),
            menuBar.menuView.leadingAnchor.constraint(equalTo: leadingAnchor),
            menuBar.menuView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        addSubview(itemsCollectionView)
        NSLayoutConstraint.activate([
            itemsCollectionView.topAnchor.constraint(equalTo: menuBar.menuView.bottomAnchor),
            itemsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
