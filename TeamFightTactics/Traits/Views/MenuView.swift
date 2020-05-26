//
//  MenuView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 26/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class MenuView: UIView {
    
    //MARK:- Properties
    let menuCollectionView: UICollectionView = {
        let colView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        colView.register(MenuCell.self, forCellWithReuseIdentifier: ReuseId.menuCell)
        colView.translatesAutoresizingMaskIntoConstraints = false
        colView.backgroundColor = ThemeColor.charcoal
        return colView
    }()

    var menuIndicatorLeadingConstraint: NSLayoutConstraint?
    let menuIndicator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ThemeColor.platinum
        return view
    }()
    
    //MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupMenuBar()
        setupCollectionView()
        setupMenuIndicator()
    }
    
    //MARK:- Setup Menu Bar
    fileprivate func setupMenuBar() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ThemeColor.charcoal
    }
    
    
    //MARK:- Setup Collection View
    fileprivate func setupCollectionView() {
        addSubview(menuCollectionView)
        NSLayoutConstraint.activate([
            menuCollectionView.topAnchor.constraint(equalTo: topAnchor),
            menuCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            menuCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            menuCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
