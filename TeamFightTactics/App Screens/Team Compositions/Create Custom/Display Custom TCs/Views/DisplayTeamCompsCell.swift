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
    private var champStackUpdater: StackViewContentUpdater<Champion, ChampionImageView>!
    private let titleLabel = BaseLabel(fontSize: 18, fontWeight: .medium)
    private let champImagesStackView = BaseStack(axis: .horizontal, distribution: .fillEqually, alignment: .center, spacing: 4)
    
    
    //MARK: Configure Cell
    func configureCell(with teamComp: CustomTeamComposition) {
        titleLabel.text = teamComp.title
        champStackUpdater.setItems(teamComp.champions)
    }
    
    
    //MARK: Setup Cell
    override func setupCell() {
        accessoryType = .disclosureIndicator
        separatorInset.left = 0
        backgroundColor = ThemeColor.richBlack
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = ThemeColor.Highlighted.richBlack
    }
    
    
    //MARK: Setup Cell Views
    override func setupCellViews() {
        setupCellContent()
        setupStackUpdater()
    }
    
    
    //MARK: Setup Stack View Updater
    private func setupStackUpdater() {
        self.champStackUpdater = StackViewContentUpdater(stackView: champImagesStackView, makeView: {
            return ChampionImageView(imageSize: 33)
        }, updateForItem: { (champion, champImage) in
            champImage.useStandardOrSetSkin(champion.imageURL, champion.name.formattedName())
            champImage.setChampCostBorderColor(champCost: champion.cost)
        })
    }
    
    
    //MARK:- Setup Cell Content
    private func setupCellContent() {
        let padding: CGFloat = 10
        contentView.addSubviews(titleLabel, champImagesStackView)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            titleLabel.bottomAnchor.constraint(equalTo: champImagesStackView.topAnchor, constant: -padding),
            
            champImagesStackView.heightAnchor.constraint(equalToConstant: 33),
            champImagesStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            champImagesStackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            champImagesStackView.trailingAnchor.constraint(lessThanOrEqualTo: titleLabel.trailingAnchor),
            champImagesStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
}
