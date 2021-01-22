//
//  DisplayTeamCompsCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 25/11/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class DisplayTeamCompsCell: BaseTableViewCell, ReusableCell {
    
    //MARK:- Properties
    typealias DataType = CustomTeamComposition
    static var reuseId: String = "displayTeamCompsCellId"
    var champStackUpdater: StackViewContentUpdater<CustomChampion, ChampionImageView>!

    let titleLabel = BaseLabel(fontSize: 18, fontWeight: .medium)
    let champImagesStackView = BaseStack(axis: .horizontal, distribution: .fillEqually, alignment: .center, spacing: 4)
    
    
    //MARK: Configure Cell
    func configureCell(with teamComp: CustomTeamComposition) {
        titleLabel.text = teamComp.title
        champStackUpdater.setItems(teamComp.champions)
    }
    
    
    //MARK: Setup Cell
    override func setupCell() {
        accessoryType = .disclosureIndicator
        backgroundColor = ThemeColor.richBlack
        separatorInset.left = 0
    }
    
    
    //MARK: Setup Cell Views
    override func setupCellViews() {
        setupCellContent()
        setupStackUpdater()
    }
    
    
    //MARK: Setup Stack View Updater
    fileprivate func setupStackUpdater() {
        self.champStackUpdater = StackViewContentUpdater(stackView: champImagesStackView, makeView: {
            return ChampionImageView(imageSize: 33)
        }, updateForItem: { (champion, champImage) in
            champImage.useStandardOrSetSkin(champion.imgURL, champion.key)
            champImage.setChampCostBorderColor(champCost: champion.cost)
        })
    }
    
    
    
    //MARK:- Setup Cell Content
    fileprivate func setupCellContent() {
        contentView.addSubviews(titleLabel, champImagesStackView)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: 25),
            
            champImagesStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            champImagesStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            champImagesStackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8),
            champImagesStackView.heightAnchor.constraint(equalToConstant: 33)
        ])
    }
}
