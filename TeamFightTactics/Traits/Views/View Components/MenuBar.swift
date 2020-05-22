//
//  MenuBar.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 22/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class MenuBar: UIView {
    
    //MARK: Properties
    let menuTitles = ["Classes", "Origins"]
    
    lazy var collectionView: UICollectionView = {
        let colView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        colView.register(MenuCell.self, forCellWithReuseIdentifier: "MenuId")
        colView.translatesAutoresizingMaskIntoConstraints = false
        colView.dataSource = self
        colView.delegate = self
        colView.backgroundColor = ThemeColor.charcoal
        colView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: [])
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
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
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
    
    
    //MARK:- Handle Menu Indicator Position
    fileprivate func handleMenuIndicatorPosition(_ indexPath: IndexPath) {
        let x = CGFloat(indexPath.item) * frame.width / 2
        menuIndicatorLeadingConstraint?.constant = x
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuBar: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / CGFloat(menuTitles.count), height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleMenuIndicatorPosition(indexPath)
    }
}

extension MenuBar: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuId", for: indexPath) as! MenuCell
        cell.menuLabel.text = menuTitles[indexPath.item]
        return cell
    }
}
