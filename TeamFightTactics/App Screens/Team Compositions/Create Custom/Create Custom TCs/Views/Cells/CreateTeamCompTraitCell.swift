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
    
    private(set) var cellTint = ThemeColor.platinum
    let gradientBackground = GradientView(gradientDirection: .topLeftToBottomRight)
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
        cellTint = gradientBackground.getTintColor(for: trait.rank, trait.isChosen)
        gradientBackground.updateGradientColors(for: trait.rank, trait.isChosen)
        traitIconImageView.image = UIImage(named: trait.name)
        traitIconImageView.tintColor = cellTint
        traitNameLabel.text = trait.name
        traitNameLabel.textColor = cellTint
        traitCountLabel.text = String(trait.count)
        traitCountLabel.textColor = cellTint
    }
    
    
    //MARK:- Setup Cell Views
    override func setupCellViews() {
        contentView.addSubviews(gradientBackground, traitIconImageView, traitCountLabel, traitNameLabel)
        gradientBackground.layer.cornerRadius = 6.0
        gradientBackground.pinSubview(to: contentView)
        
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
