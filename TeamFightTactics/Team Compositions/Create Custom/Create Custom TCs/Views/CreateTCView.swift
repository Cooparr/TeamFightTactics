//
//  CreateTeamCompView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 04/12/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class CreateTCView: BaseView {
    
    //MARK: Sort By Enum
    enum SortBy: Int {
        case name = 1
        case cost = 2
        case tier = 3
    }
    
    //MARK: Button Title Enum
    enum BtnTitles: String {
        case showItems = "Show Items"
        case showChamps = "Show Champs"
        case name = "Name"
        case cost = "Cost"
        case tier = "Tier"
    }
    
    
    //MARK:- Properties
    let mainStackView = BaseStack(axis: .vertical, spacing: 10)
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
        btn.addTarget(self, action: #selector(CreateTeamCompVC.toggleColViewAction), for: .touchUpInside)
        btn.setTitle(BtnTitles.showItems.rawValue, for: .normal)
        btn.setTitleColor(ThemeColor.platinum, for: .normal)
        btn.titleLabel?.font = UIFont.preferredFont(forTextStyle: .callout)
        btn.layer.cornerRadius = 6
        btn.backgroundColor = ThemeColor.romanSilver
        return btn
    }()

    let sortByNameBtn: CreateTCSortButton = {
        let btn = CreateTCSortButton(title: BtnTitles.name.rawValue, tag: SortBy.name.rawValue)
        btn.addTarget(self, action: #selector(CreateTeamCompVC.sortByButtonAction), for: .touchUpInside)
        return btn
    }()
    
    let sortByCostBtn: CreateTCSortButton = {
        let btn = CreateTCSortButton(title: BtnTitles.cost.rawValue, tag: SortBy.cost.rawValue)
        btn.addTarget(self, action: #selector(CreateTeamCompVC.sortByButtonAction), for: .touchUpInside)
        btn.backgroundColor = ThemeColor.romanSilver
        btn.isSelected = true
        return btn
    }()
    
    let sortByTierBtn: CreateTCSortButton = {
        let btn = CreateTCSortButton(title: BtnTitles.tier.rawValue, tag: SortBy.tier.rawValue)
        btn.addTarget(self, action: #selector(CreateTeamCompVC.sortByButtonAction), for: .touchUpInside)
        return btn
    }()
    
    
    //MARK:- Update Toggle Button Title
    func updateToggleButtonTitle(showItems: Bool) {
        switch showItems {
        case false:
            toggleColViewBtn.setTitle(BtnTitles.showItems.rawValue, for: .normal)
        case true:
            toggleColViewBtn.setTitle(BtnTitles.showChamps.rawValue, for: .normal)
        }
    }
    
    
    //MARK:- Setup View
    override func setupView() {
        backgroundColor = ThemeColor.richBlack
        
        addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    
    //MARK:- Setup Subviews
    override func setupSubviews() {
        mainStackView.addArrangedSubview(buttonsStackView)
        buttonsStackView.addArrangedSubviews(toggleColViewBtn, sortByNameBtn, sortByCostBtn, sortByTierBtn)
    }
}


//MARK:- ScrollView Delegate
extension CreateTCView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        }
    }
}
