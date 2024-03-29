//
//  ItemSelectionCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 21/01/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class ItemSelectionCell: BaseColViewCell, ReusableCell {
    
    //MARK:- Properties
    typealias DataType = Item
    static var reuseId: String = "customTeamCompItemSelectionCell"
    
    private let itemImageView = ItemImageView(cornerRadius: 3.0, borderWidth: 2.0, borderColor: ThemeColor.independence)
    private let itemNameLabel: BaseLabel = {
        let lbl = BaseLabel(textStyle: .caption2, weight: .regular, fontColor: ThemeColor.platinum, textAlignment: .center)
        lbl.numberOfLines = 0
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.85
        return lbl
    }()
    
    
    //MARK:- Configure Cell
    func configureCell(with item: Item) {
        itemNameLabel.text = item.name
//        itemImageView.configureImageViewV2(with: item.name, isShadow: item.isShadow, isRadiant: item.isRadiant)
        itemImageView.configureImageView(with: item.name)
    }
    
    
    //MARK:- Setup Cell
    override func setupCell() {
        backgroundColor = ThemeColor.charcoal
        layer.cornerRadius = 3
        clipsToBounds = true
        
        setupItemImageView(padding: 5.0)
        setupItemNameLabel(padding: 2.0)
    }
    
    
    //MARK: Setup Item Image View
    private func setupItemImageView(padding: CGFloat) {
        contentView.addSubview(itemImageView)
        NSLayoutConstraint.activate([
            itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            itemImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            itemImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            itemImageView.heightAnchor.constraint(equalTo: itemImageView.widthAnchor)
        ])
    }
    
    
    //MARK: Setup Item Name Label
    private func setupItemNameLabel(padding: CGFloat) {
        contentView.addSubview(itemNameLabel)
        NSLayoutConstraint.activate([
            itemNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            itemNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            itemNameLabel.bottomAnchor.constraint(equalTo: itemImageView.topAnchor)
        ])
    }
}
