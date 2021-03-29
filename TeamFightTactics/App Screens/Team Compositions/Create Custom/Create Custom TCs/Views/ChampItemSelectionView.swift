//
//  ChampItemSelectionView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 29/03/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class ChampItemSelectionView: BaseView {
    
    //MARK: Button Title Enum
    enum BtnTitles: String {
        case showItems = "Show Items"
        case showChamps = "Show Champs"
        case name = "Name"
        case cost = "Cost"
        case tier = "Tier"
    }
    
    //MARK: Properties
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 40)
        
        let colView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colView.translatesAutoresizingMaskIntoConstraints = false
        colView.register(SelectionColViewSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SelectionColViewSectionHeader.reuseId)
        colView.register(ChampionSelectionCell.self, forCellWithReuseIdentifier: ChampionSelectionCell.reuseId)
        colView.register(ItemSelectionCell.self, forCellWithReuseIdentifier: ItemSelectionCell.reuseId)
        colView.showsHorizontalScrollIndicator = false
        colView.backgroundColor = ThemeColor.richBlack
        return colView
    }()
    
    let buttonsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 5
        return stack
    }()
    
    let toggleColViewBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(ChampItemSelectionVC.toggleColViewAction), for: .touchUpInside)
        btn.setTitle(BtnTitles.showItems.rawValue, for: .normal)
        btn.setTitleColor(ThemeColor.platinum, for: .normal)
        btn.titleLabel?.font = UIFont.preferredFont(forTextStyle: .callout)
        btn.layer.cornerRadius = 6
        btn.backgroundColor = ThemeColor.romanSilver
        return btn
    }()

    let sortByNameBtn: CreateTCSortButton = {
        let btn = CreateTCSortButton(title: BtnTitles.name.rawValue, tag: ChampItemSelectionVC.SortBy.name.rawValue)
        btn.addTarget(self, action: #selector(ChampItemSelectionVC.sortByButtonAction), for: .touchUpInside)
        return btn
    }()
    
    let sortByCostBtn: CreateTCSortButton = {
        let btn = CreateTCSortButton(title: BtnTitles.cost.rawValue, tag: ChampItemSelectionVC.SortBy.cost.rawValue)
        btn.addTarget(self, action: #selector(ChampItemSelectionVC.sortByButtonAction), for: .touchUpInside)
        btn.backgroundColor = ThemeColor.romanSilver
        btn.isSelected = true
        return btn
    }()
    
    let sortByTierBtn: CreateTCSortButton = {
        let btn = CreateTCSortButton(title: BtnTitles.tier.rawValue, tag: ChampItemSelectionVC.SortBy.tier.rawValue)
        btn.addTarget(self, action: #selector(ChampItemSelectionVC.sortByButtonAction), for: .touchUpInside)
        return btn
    }()
    
    
    //MARK:- Update Toggle Button Title
    func updateToggleButtonTitle(displayingItems: Bool) {
        switch displayingItems {
        case false:
            toggleColViewBtn.setTitle(BtnTitles.showItems.rawValue, for: .normal)
        case true:
            toggleColViewBtn.setTitle(BtnTitles.showChamps.rawValue, for: .normal)
        }
    }
    
    
    //MARK: Setup View
    override func setupSubviews() {
        addSubviews(buttonsStackView, collectionView)
        buttonsStackView.addArrangedSubviews(toggleColViewBtn, sortByNameBtn, sortByCostBtn, sortByTierBtn)
        
        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(equalTo: topAnchor),
            buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 30),
            buttonsStackView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 225)
        ])
    }
}
