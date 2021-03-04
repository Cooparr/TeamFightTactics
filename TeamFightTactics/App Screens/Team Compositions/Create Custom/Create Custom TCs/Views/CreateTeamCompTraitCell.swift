//
//  CreateTeamCompTraitCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 14/12/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class CreateTeamCompTraitCell: BaseColViewCell, ReusableCell {
    
    //MARK:- Properties
    typealias DataType = Trait
    static var reuseId: String = "createCustomTeamCompTraitsCellId"
    
    let traitIconImageView = IconImageView(tintColor: ThemeColor.platinum)
    let traitNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = ThemeColor.platinum
        lbl.font = UIFont.preferredFont(forTextStyle: .callout)
        return lbl
    }()
    
    let traitCountLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = ThemeColor.platinum
        lbl.font = UIFont.preferredFont(forTextStyle: .callout)
        return lbl
    }()
    
    
    //MARK:- Configure Cell
    func configureCell(with trait: Trait) {
        traitIconImageView.image = UIImage(named: trait.name)
        traitNameLabel.text = trait.name
        traitCountLabel.text = String(trait.count)
        backgroundColor = trait.rank.setRankColor(trait.isChosen)
    }
    
    
    //MARK:- Setup Cell
    override func setupCell() {
        backgroundColor = ThemeColor.romanSilver
        layer.cornerRadius = 6
    }
    
    
    //MARK:- Setup Cell Views
    override func setupCellViews() {
        contentView.addSubviews(traitIconImageView, traitCountLabel, traitNameLabel)
        NSLayoutConstraint.activate([
            traitIconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            traitIconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            traitIconImageView.widthAnchor.constraint(equalToConstant: 17),
            traitIconImageView.heightAnchor.constraint(equalTo: traitIconImageView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            traitCountLabel.topAnchor.constraint(equalTo: traitIconImageView.topAnchor),
            traitCountLabel.leadingAnchor.constraint(equalTo: traitIconImageView.trailingAnchor, constant: 3),
            traitCountLabel.bottomAnchor.constraint(equalTo: traitIconImageView.bottomAnchor),
            traitCountLabel.widthAnchor.constraint(equalToConstant: 10)
        ])
        
        NSLayoutConstraint.activate([
            traitNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            traitNameLabel.leadingAnchor.constraint(equalTo: traitCountLabel.trailingAnchor, constant: 3),
            traitNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            traitNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
