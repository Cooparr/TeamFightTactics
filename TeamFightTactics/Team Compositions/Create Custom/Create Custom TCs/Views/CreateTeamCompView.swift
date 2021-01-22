//
//  CreateTeamCompView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 04/12/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class CreateTeamCompView: BaseView {
    
    //MARK: Sort By Enum
    enum SortBy: Int {
        case name = 1
        case cost = 2
        case tier = 3
    }
    
    
    //MARK:- Properties
    let buttonsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 5
        return stack
    }()
    
    let toggleCollectionViewButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(CreateTeamCompVC.toggleColViewAction), for: .touchUpInside)
        btn.setTitle("Show Items", for: .normal)
        btn.setTitleColor(ThemeColor.platinum, for: .normal)
        btn.titleLabel?.font = UIFont.preferredFont(forTextStyle: .callout)
        btn.layer.cornerRadius = 6
        btn.backgroundColor = ThemeColor.romanSilver
        return btn
    }()

    let sortByNameButton: CreateTCSortButton = {
        let btn = CreateTCSortButton(title: "Name", tag: SortBy.name.rawValue)
        btn.addTarget(self, action: #selector(CreateTeamCompVC.sortByButtonAction), for: .touchUpInside)
        return btn
    }()
    
    let sortByCostButton: CreateTCSortButton = {
        let btn = CreateTCSortButton(title: "Cost", tag: SortBy.cost.rawValue)
        btn.addTarget(self, action: #selector(CreateTeamCompVC.sortByButtonAction), for: .touchUpInside)
        btn.backgroundColor = ThemeColor.romanSilver
        btn.isSelected = true
        return btn
    }()
    
    let sortByTierButton: CreateTCSortButton = {
        let btn = CreateTCSortButton(title: "Tier", tag: SortBy.tier.rawValue)
        btn.addTarget(self, action: #selector(CreateTeamCompVC.sortByButtonAction), for: .touchUpInside)
        return btn
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.textColor = ThemeColor.platinum
        textField.placeholder = "Name this Team Comp"
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize = 12
        
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.tintColor = ThemeColor.platinum

        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = ThemeColor.romanSilver.cgColor
        textField.backgroundColor = ThemeColor.charcoal
        return textField
    }()
    
    let champItemCollectionView: UICollectionView = {
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
        colView.backgroundColor = ThemeColor.richBlack
        colView.showsHorizontalScrollIndicator = false
        colView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return colView
    }()
    
    
    let traitsColViewHeight: CGFloat = 25
    let traitsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5

        let colView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colView.translatesAutoresizingMaskIntoConstraints = false
        colView.register(CreateTeamCompTraitCell.self, forCellWithReuseIdentifier: CreateTeamCompTraitCell.reuseId)
        colView.showsHorizontalScrollIndicator = false
        colView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        colView.backgroundColor = ThemeColor.richBlack
        return colView
    }()
    
    
    //MARK:- Update Toggle Button Title
    func updateToggleButtonTitle(showItems: Bool) {
        switch showItems {
        case false:
            toggleCollectionViewButton.setTitle("Show Items", for: .normal)
        case true:
            toggleCollectionViewButton.setTitle("Show Champions", for: .normal)
        }
    }
    
    
    //MARK:- Setup View
    override func setupView() {
        backgroundColor = ThemeColor.richBlack
    }
    
    
    //MARK:- Setup Subviews
    override func setupSubviews() {
        constrainTraitsCollectionView()
        constrainButtonsStackView()
        constrainNameTextField()
        constrainChampItemSelectionCollectionView()
    }
    
    
    //MARK: Constrain Traits Collection View
    fileprivate func constrainTraitsCollectionView() {
        addSubview(traitsCollectionView)
        NSLayoutConstraint.activate([
            traitsCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            traitsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            traitsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            traitsCollectionView.heightAnchor.constraint(equalToConstant: traitsColViewHeight)
        ])
    }
    
    
    //MARK: Constrain Buttons Stack View
    fileprivate func constrainButtonsStackView() {
        addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(toggleCollectionViewButton)
        buttonsStackView.addArrangedSubview(sortByNameButton)
        buttonsStackView.addArrangedSubview(sortByCostButton)
        buttonsStackView.addArrangedSubview(sortByTierButton)
        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(equalTo: traitsCollectionView.bottomAnchor, constant: 10),
            buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    
    //MARK: Constrain Name Text Field
    fileprivate func constrainNameTextField() {
        addSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: toggleCollectionViewButton.bottomAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    
    //MARK: Constrain Champ/Item Collection View
    fileprivate func constrainChampItemSelectionCollectionView() {
        addSubview(champItemCollectionView)
        NSLayoutConstraint.activate([
            champItemCollectionView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            champItemCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            champItemCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            champItemCollectionView.heightAnchor.constraint(equalToConstant: 225)
        ])
    }
}
