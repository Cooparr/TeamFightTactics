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
    let activityIndicator = CustomActivityIndicator()
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
        colView.register(BSCell.self, forCellWithReuseIdentifier: BSCell.reuseId)
        colView.register(CSCell.self, forCellWithReuseIdentifier: CSCell.reuseId)
        colView.backgroundColor = ThemeColor.richBlack
        colView.showsHorizontalScrollIndicator = false
        colView.isPagingEnabled = true
        colView.isScrollEnabled = false
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
        
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
