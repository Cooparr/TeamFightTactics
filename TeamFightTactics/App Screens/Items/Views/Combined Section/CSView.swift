//
//  CSView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 30/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class CSView: BaseView {
    
    //MARK:- Properties
    let placeholderView = BaseView(backgroundColor: ThemeColor.charcoal, cornerRadius: 6)
    let placholderLabel: BaseLabel = {
        let lbl = BaseLabel(fontSize: 16, fontWeight: .medium, lblText: "Tap Item to view more info.")
        lbl.textAlignment = .center
        return lbl
    }()
    
    lazy var collectionView: UICollectionView = {
        var colView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        colView.translatesAutoresizingMaskIntoConstraints = false
        colView.backgroundColor = ThemeColor.richBlack
        colView.showsVerticalScrollIndicator = false
        colView.register(ItemSelectorCell.self, forCellWithReuseIdentifier: ItemSelectorCell.reuseId)
        colView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.reuseId)
        colView.alwaysBounceVertical = false
        return colView
    }()
    
    
    //MARK:- Setup View
    override func setupView() {
        addSubview(collectionView)
        collectionView.pinSubview(to: self)
    }
    
    
    //MARK:- Setup Subview
    override func setupSubviews() {
        addSubview(placeholderView)
        placeholderView.alpha = 0
        NSLayoutConstraint.activate([
            placeholderView.heightAnchor.constraint(equalToConstant: 70),
            placeholderView.centerXAnchor.constraint(equalTo: centerXAnchor),
            placeholderView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 50),
            placeholderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            placeholderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
        
        placeholderView.addSubview(placholderLabel)
        placholderLabel.pinSubview(to: placeholderView)
    }
    
    
    //MARK:- Handle Placeholder View
    func handlePlaceholderView(showPlaceholder: Bool) {
        switch showPlaceholder {
        case true:
            self.placeholderView.isHidden = false
            UIView.animate(withDuration: 1) {
                self.placeholderView.alpha = 1
            }

        case false:
            UIView.animate(withDuration: 0.4) {
                self.placeholderView.alpha = 0
            } completion: { _ in
                self.placeholderView.isHidden = true
            }
        }
    }
    
    
    //MARK:- Create Compositional Layout
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            guard let section = CSSection(rawValue: sectionIndex) else { fatalError("Unknown section") }
            switch section {
            case .selector:
                return self.createSelectorSection()
            case .main:
                return self.createMainSection()
            }
        }
        return layout
    }
    
    
    //MARK:- Create Selector Section
    fileprivate func createSelectorSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(50), heightDimension: .absolute(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(50), heightDimension: .absolute(170))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 50, leading: 10, bottom: 50, trailing: 10)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        return section
    }
    
    
    //MARK:- Create Main Section
    fileprivate func createMainSection() -> NSCollectionLayoutSection {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(110))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: layoutSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        return section
    }
}
