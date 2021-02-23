//
//  CreateSelectedChampionCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 14/12/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class SelectedChampionCell: BaseTableViewCell, ReusableCell {
    
    //MARK:- Properties
    typealias DataType = CustomChampion
    static var reuseId: String = "selectedChampionCellId"
    let numOfItemsEachChampionCanHold = 3
    let championNameLabel = BaseLabel(fontSize: 18, fontWeight: .regular, fontColor: ThemeColor.platinum)
    let championImageView = ChampionImageView(frame: .zero)
    private(set) var itemsStackView: BaseStack!
        
    
    //MARK: Override Set Selected
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = selected ? ThemeColor.Highlighted.charcoal : ThemeColor.charcoal
    }
    
    
    //MARK:- Configure Cell
    func configureCell(with champion: CustomChampion) {
        championImageView.useStandardOrSetSkin(champion.imgURL, champion.key)
        championImageView.setChampCostBorderColor(champCost: champion.cost)
        championNameLabel.text = champion.name
    }
    
    
    //MARK:- Setup Cell
    override func setupCell() {
        backgroundColor = ThemeColor.charcoal
        
        setupChampionImageView()
        setupChampionNameLabel()
        setupItemsStackView()
    }
    
    
    //MARK: Setup Champion Image View
    fileprivate func setupChampionImageView() {
        contentView.addSubview(championImageView)
        NSLayoutConstraint.activate([
            championImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            championImageView.heightAnchor.constraint(equalToConstant: 50),
            championImageView.widthAnchor.constraint(equalTo: championImageView.heightAnchor),
            championImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    
    //MARK: Setup Champion Name Label
    fileprivate func setupChampionNameLabel() {
        contentView.addSubview(championNameLabel)
        NSLayoutConstraint.activate([
            championNameLabel.topAnchor.constraint(equalTo: championImageView.topAnchor),
            championNameLabel.leadingAnchor.constraint(equalTo: championImageView.trailingAnchor, constant: 10),
            championNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            championNameLabel.bottomAnchor.constraint(equalTo: championImageView.bottomAnchor)
        ])
    }
    
    
    //MARK: Setup Items Stack View
    fileprivate func setupItemsStackView() {
        let stackViewSpacing: CGFloat = 5
        let stackHeight: CGFloat = 35
        
        itemsStackView = BaseStack(axis: .horizontal, distribution: .fillEqually, spacing: stackViewSpacing)
        (0..<numOfItemsEachChampionCanHold).forEach { _ in itemsStackView.addArrangedSubview(TappableItemView()) }
        
        contentView.addSubview(itemsStackView)
        NSLayoutConstraint.activate([
            itemsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            itemsStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            itemsStackView.heightAnchor.constraint(equalToConstant: stackHeight),
            itemsStackView.widthAnchor.constraint(equalToConstant: (stackHeight * CGFloat(numOfItemsEachChampionCanHold)) + (CGFloat(numOfItemsEachChampionCanHold) * stackViewSpacing))
        ])
    }
}
