//
//  TCCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 17/10/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit
import SDWebImage

class TCCell: BaseTableViewCell {
    
    //MARK:- Properties
    static var reuseId: String = "metaTeamCompCellId"
    var champStackUpdater: StackViewContentUpdater<Champion, ChampionImageView>!
    var synergyStackUpdater: StackViewContentUpdater<TCSynergy, TCSynergyBadge>!

    var currentChamps: [Champion] {
        return champStackUpdater.items
    }
    
    //MARK:- Team Comp Title & Tier
    let titleLabel = BaseLabel(fontSize: 18, fontWeight: .medium)
    let tierFlair = CellFlair()
    let champImagesStackView = BaseStack(axis: .horizontal, distribution: .fillProportionally, alignment: .center, spacing: 2)
    let synergiesStackView = BaseStack(axis: .horizontal, distribution: .fillProportionally, alignment: .center, spacing: 2)
    
    
    //MARK:- Configure Cell
    func configureCell(teamComp: TeamComposition) {
        titleLabel.text = teamComp.title
        tierFlair.updateFlair(with: teamComp.tier)
        champStackUpdater.setItems(teamComp.endGameChampObjs)
        synergyStackUpdater.setItems(teamComp.synergies)
    }
    
    
    //MARK:- Setup Cell
    override func setupCell() {
        accessoryType = .disclosureIndicator
        separatorInset.left = 0
        backgroundColor = ThemeColor.richBlack
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = ThemeColor.Highlighted.richBlack
    }
    
    
    //MARK:- Setup Cell Views
    override func setupCellViews() {
        setupCellContent()
        setupStackUpdaters()
    }
    
    
    //MARK:- Setup Stack Updaters
    fileprivate func setupStackUpdaters() {
        self.champStackUpdater = StackViewContentUpdater(stackView: champImagesStackView, makeView: {
            return ChampionImageView(imageSize: 35)
        }, updateForItem: { (champion, champImage) in
            champImage.useStandardOrSetSkin(champion.imageURL, champion.name.formattedName())
            champImage.setChampCostBorderColor(champCost: champion.cost)
        })
        
        self.synergyStackUpdater = StackViewContentUpdater(stackView: synergiesStackView, makeView: {
            return TCSynergyBadge(gradientDirection: .topLeftToBottomRight)
        }, updateForItem: { (synergy, synergyBadge) in
            synergyBadge.updateSynergyBadge(with: synergy)
        })
    }
    
    
    //MARK:- Setup Cell Content
    fileprivate func setupCellContent() {
        contentView.addSubviews(titleLabel, tierFlair, champImagesStackView, synergiesStackView)
        tierFlair.constrainCellFlair(to: self)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        ])

        NSLayoutConstraint.activate([
            champImagesStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            champImagesStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
        ])
        
        NSLayoutConstraint.activate([
            synergiesStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            synergiesStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14),
            synergiesStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}
