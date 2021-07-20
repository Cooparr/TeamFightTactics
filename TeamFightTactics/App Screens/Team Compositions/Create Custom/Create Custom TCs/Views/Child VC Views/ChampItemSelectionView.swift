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
        case showItems = "Items"
        case showChamps = "Champions"
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
    
    let toggleColViewBtn: BaseButton = {
        let btn = BaseButton(textStyle: .callout, cornerRadius: 6)
        btn.setTitle(BtnTitles.showItems.rawValue, for: .normal)
        btn.addTarget(self, action: #selector(ChampItemSelectionVC.toggleColViewAction), for: .touchUpInside)
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
    
    
    //MARK:- Update Selected State Of Sort Buttons
    func updateSelectedStateOfSortButton(tappedButton: UIButton) {
        for btn in buttonsStackView.arrangedSubviews {
            guard let btn = btn as? CreateTCSortButton else { continue }
            switch tappedButton.tag {
            case btn.tag:
                btn.isSelected = true
            default:
                btn.isSelected = false
            }
        }
    }
    
    
    //MARK:- Update Buttons Depending On
    func updateButtonsDependingOn(isShowingItems: Bool) {
        switch isShowingItems {
        case false:
            toggleColViewBtn.setTitle(BtnTitles.showItems.rawValue, for: .normal)
            sortByCostBtn.isHidden = false
        case true:
            toggleColViewBtn.setTitle(BtnTitles.showChamps.rawValue, for: .normal)
            sortByCostBtn.isHidden = true
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
