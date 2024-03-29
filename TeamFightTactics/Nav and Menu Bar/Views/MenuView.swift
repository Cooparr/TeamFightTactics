//
//  MenuView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 26/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class MenuView: BaseView {
    
    //MARK:- Properties
    var menuIndicatorLeadingConstraint: NSLayoutConstraint?
    let menuIndicator = BaseView(backgroundColor: ThemeColor.platinum)
    let menuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        
        let colView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colView.register(MenuCell.self, forCellWithReuseIdentifier: MenuCell.reuseId)
        colView.translatesAutoresizingMaskIntoConstraints = false
        colView.backgroundColor = ThemeColor.charcoal
        return colView
    }()
    
    
    //MARK:- Setup Subviews
    override func setupSubviews() {
        setupCollectionView()
        setupMenuIndicator()
    }
    
    
    //MARK:- Setup Collection View
    fileprivate func setupCollectionView() {
        addSubview(menuCollectionView)
        menuCollectionView.pinSubview(to: self)
    }


    //MARK:- Setup Menu Indicator
    fileprivate func setupMenuIndicator() {
        addSubview(menuIndicator)
        menuIndicatorLeadingConstraint = menuIndicator.leadingAnchor.constraint(equalTo: leadingAnchor)
        menuIndicatorLeadingConstraint?.isActive = true
        NSLayoutConstraint.activate([
            menuIndicator.bottomAnchor.constraint(equalTo: bottomAnchor),
            menuIndicator.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2),
            menuIndicator.heightAnchor.constraint(equalToConstant: 4)
        ])
    }
}
