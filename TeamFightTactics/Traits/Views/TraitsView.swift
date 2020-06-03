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
        let menu = MenuBarController()
        menu.traitView = self
        return menu
    }()
    
    let traitCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let colView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colView.translatesAutoresizingMaskIntoConstraints = false
        colView.register(TraitsCell.self, forCellWithReuseIdentifier: ReuseId.traitCell)
        colView.showsHorizontalScrollIndicator = false
        colView.backgroundColor = ThemeColor.richBlack
        colView.isPagingEnabled = true
        return colView
    }()
    
    
    //MARK:- Setup View
    override func setupView() {
        addSubview(menuBar.view)
        NSLayoutConstraint.activate([
            menuBar.menuView.heightAnchor.constraint(equalToConstant: 50),
            menuBar.menuView.topAnchor.constraint(equalTo: topAnchor),
            menuBar.menuView.leadingAnchor.constraint(equalTo: leadingAnchor),
            menuBar.menuView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    
    //MARK:- Setup Subviews
    override func setupSubviews() {
        addSubview(traitCollectionView)
        NSLayoutConstraint.activate([
            traitCollectionView.topAnchor.constraint(equalTo: menuBar.menuView.bottomAnchor),
            traitCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            traitCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            traitCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    //MARK: Scroll To Menu Bar Index
    func scrollToMenuBarIndex(itemIndex: Int, sectionIndex: Int) {
        let indexPath = IndexPath(item: itemIndex, section: sectionIndex)
        traitCollectionView.scrollToItem(at: indexPath, at: [], animated: true)
    }
}
