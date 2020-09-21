//
//  TraitsView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 22/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class TraitsView: BaseView {
    
    //MARK:- Properties
    lazy var menuBar: MenuBarController = {
        let menu = MenuBarController(menuTitles: ["Classes", "Origins"])
        menu.selectedView = traitCollectionView.self
        return menu
    }()
    
    let traitCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let colView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colView.translatesAutoresizingMaskIntoConstraints = false
        colView.register(TraitsPageCell.self, forCellWithReuseIdentifier: TraitsPageCell.reuseId)
        colView.showsHorizontalScrollIndicator = false
        colView.backgroundColor = ThemeColor.richBlack
        colView.isPagingEnabled = true
        return colView
    }()
    
    
    //MARK:- Setup Subviews
    override func setupSubviews() {
        addSubviews(menuBar.view, traitCollectionView)
        NSLayoutConstraint.activate([
            menuBar.menuView.heightAnchor.constraint(equalToConstant: 50),
            menuBar.menuView.topAnchor.constraint(equalTo: topAnchor),
            menuBar.menuView.leadingAnchor.constraint(equalTo: leadingAnchor),
            menuBar.menuView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            traitCollectionView.topAnchor.constraint(equalTo: menuBar.menuView.bottomAnchor),
            traitCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            traitCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            traitCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
