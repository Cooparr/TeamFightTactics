//
//  ChampionSelectionCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 04/12/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class ChampionSelectionCell: BaseColViewCell, ReusableCell {
    
    //MARK:- Properties
    typealias DataType = Champion
    static var reuseId: String = "createCustomTeamCompChampSelectionCell"
    
    let championImageView = ChampionImageView(frame: .zero)
    let championNameLabel: BaseLabel = {
        let lbl = BaseLabel()
        lbl.textAlignment = .center
        lbl.numberOfLines = 1
        lbl.textColor = ThemeColor.platinum
        lbl.font = UIFont.preferredFont(forTextStyle: .caption2)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.adjustsFontForContentSizeCategory = true
        lbl.minimumScaleFactor = 0.50
        return lbl
    }()
    
    
    //MARK:- Configure Cell
    func configureCell(with champion: Champion) {
        championNameLabel.text = champion.name
        championImageView.useStandardOrSetSkin(champion.imageURL, champion.name.formattedName())
        championImageView.setChampCostBorderColor(champCost: champion.cost)
        
    }
    
    
    //MARK:- Setup Cell
    override func setupCell() {
        backgroundColor = ThemeColor.charcoal
        layer.cornerRadius = 3
        clipsToBounds = true
        
        setupChampionImageView()
        setupChampionNameLabel()
    }
    
    
    //MARK: Setup Champion Image View
    fileprivate func setupChampionImageView() {
        let padding: CGFloat = 5
        contentView.addSubview(championImageView)
        NSLayoutConstraint.activate([
            championImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            championImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            championImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            championImageView.heightAnchor.constraint(equalTo: championImageView.widthAnchor)
        ])
    }
    
    
    //MARK: Setup Champion Name Label
    fileprivate func setupChampionNameLabel() {
        let padding: CGFloat = 2
        contentView.addSubview(championNameLabel)
        NSLayoutConstraint.activate([
            championNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            championNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            championNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            championNameLabel.bottomAnchor.constraint(equalTo: championImageView.topAnchor)
        ])
    }
}
