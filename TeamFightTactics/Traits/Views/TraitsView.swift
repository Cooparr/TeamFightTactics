//
//  TraitsView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 22/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class TraitsView: UIView {
    
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
    
    
    //MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        constrainMenuBar()
        constrainCollectionView()
    }
    
    
    //MARK: Scroll To Menu Bar Index
    func scrollToMenuBarIndex(itemIndex: Int, sectionIndex: Int) {
        let indexPath = IndexPath(item: itemIndex, section: sectionIndex)
        traitCollectionView.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
    
    //MARK:- Constrain Menu Bar
    fileprivate func constrainMenuBar() {
        addSubview(menuBar.view)
        NSLayoutConstraint.activate([
            menuBar.menuView.heightAnchor.constraint(equalToConstant: 50),
            menuBar.menuView.topAnchor.constraint(equalTo: topAnchor),
            menuBar.menuView.leadingAnchor.constraint(equalTo: leadingAnchor),
            menuBar.menuView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    
    //MARK:- Constrain Collection View
    fileprivate func constrainCollectionView() {
        addSubview(traitCollectionView)
        NSLayoutConstraint.activate([
            traitCollectionView.topAnchor.constraint(equalTo: menuBar.menuView.bottomAnchor),
            traitCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            traitCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            traitCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
