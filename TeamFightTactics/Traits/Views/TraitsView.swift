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
    let menuBar = MenuBarController()
    let traitCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let colView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colView.translatesAutoresizingMaskIntoConstraints = false
        colView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ReuseId.traitCell)
        colView.isPagingEnabled = true
        return colView
    }()
    
    
    //MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        constrainMenuBar()
        assignDelegates()
        constrainCollectionView()
    }
    
    
    //MARK: Scroll To Menu Bar Index
    func scrollToMenuBarIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        traitCollectionView.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
    
    //MARK:- Assign Collection View Delegates
    fileprivate func assignDelegates() {
        menuBar.traitView = self
        traitCollectionView.delegate = self
        traitCollectionView.dataSource = self
    }
    
    
    //MARK:- Constrain Menu Bar
    fileprivate func constrainMenuBar() {
        addSubview(menuBar.view)
        NSLayoutConstraint.activate([
            menuBar.view.heightAnchor.constraint(equalToConstant: 50),
            menuBar.view.topAnchor.constraint(equalTo: topAnchor),
            menuBar.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            menuBar.view.trailingAnchor.constraint(equalTo: trailingAnchor)
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


extension TraitsView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.menuView.menuIndicatorLeadingConstraint?.constant = scrollView.contentOffset.x / CGFloat(menuBar.menuTitles.count)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x / frame.width)
        let indexPath = IndexPath(item: index, section: 0)
        menuBar.menuView.menuCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
}


extension TraitsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuBar.menuTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseId.traitCell, for: indexPath)
        
        if indexPath.item == 0 {
            cell.backgroundColor = .green
        } else {
            cell.backgroundColor = .blue
        }
        
        return cell
    }
}
