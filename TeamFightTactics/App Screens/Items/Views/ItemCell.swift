//
//  ItemCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 23/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class ItemCell: BaseColViewCell, ReusableCell {
    
    //MARK:- Properties
    typealias DataType = Item
    static var reuseId: String = "baseItemId"
    
    private let itemName = BaseLabel(fontSize: 18, fontWeight: .medium)
    private let itemDesc = BaseLabel(fontSize: 14, fontWeight: .regular, multiLine: true)
    private let itemImage = ItemImageView(cornerRadius: 3.0, borderWidth: 3.0, borderColor: ThemeColor.independence)
    private let itemRecipeStack = ItemRecipeStack()
    private let itemStatsStack = ItemStatsStack()
    private let recipeAndStatsStack = BaseStack(axis: .vertical, distribution: .fillEqually, alignment: .leading)
    
    private let itemTier: BaseLabel = {
        let lbl = BaseLabel(fontSize: 12, fontWeight: .semibold, fontColor: ThemeColor.richBlack)
        lbl.textAlignment = .center
        lbl.clipsToBounds = true
        lbl.layer.cornerRadius = 6.0
        lbl.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        return lbl
    }()
    
    
    //MARK:- Prepare For Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        resetStatViews()
    }
    
    
    //MARK:- Configure Cell
    func configureCell(with item: Item) {
        itemName.text = item.name
        itemDesc.text = item.description
        item.tier.setTierTextAndColor(for: itemTier)
        itemImage.configureImageView(with: item.name, isShadow: item.isShadow)
        itemRecipeStack.updateRecipeImages(with: item.from, isShadow: item.isShadow)
        updateItemStats(item.stats)
    }
    
    
    //MARK:- Setup Cell
    override func setupCell() {
        backgroundColor = ThemeColor.charcoal
        layer.cornerRadius = 6.0
    }
    
    
    //MARK:- Update Item Stats
    private func updateItemStats(_ itemStats: [ItemStat]?) {
        guard let itemStats = itemStats else { return }
        let firstStat = itemStats[0]
        if firstStat.key != nil && firstStat.value != nil {
            itemStatsStack.isHidden = false
            itemStatsStack.configureStackView(with: itemStats)
        } else {
            itemStatsStack.isHidden = true
        }
    }
    
    
    //MARK:- Reset Stat View
    private func resetStatViews() {
        itemStatsStack.arrangedSubviews.forEach { (statView) in
            guard let view = statView as? StatView else { return }
            view.statLabel.text = nil
            view.statIcon.image = nil
            view.statIcon.tintColor = nil
        }
    }
    
    
    //MARK:- Setup Cell Views
    override func setupCellViews() {
        contentView.addSubview(itemTier)
        NSLayoutConstraint.activate([
            itemTier.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemTier.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemTier.widthAnchor.constraint(equalToConstant: 60),
            itemTier.heightAnchor.constraint(equalToConstant: 17)
        ])

        contentView.addSubview(itemName)
        NSLayoutConstraint.activate([
            itemName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            itemName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            itemName.trailingAnchor.constraint(equalTo: itemTier.leadingAnchor, constant: -10),
        ])

        contentView.addSubview(itemImage)
        NSLayoutConstraint.activate([
            itemImage.topAnchor.constraint(equalTo: itemName.bottomAnchor, constant: 10),
            itemImage.leadingAnchor.constraint(equalTo: itemName.leadingAnchor),
            itemImage.heightAnchor.constraint(equalToConstant: 60),
            itemImage.widthAnchor.constraint(equalTo: itemImage.heightAnchor)
        ])

        contentView.addSubview(recipeAndStatsStack)
        recipeAndStatsStack.addArrangedSubviews(itemStatsStack, itemRecipeStack)
        NSLayoutConstraint.activate([
            recipeAndStatsStack.topAnchor.constraint(equalTo: itemImage.topAnchor),
            recipeAndStatsStack.leadingAnchor.constraint(equalTo: itemImage.trailingAnchor, constant: 10),
            recipeAndStatsStack.bottomAnchor.constraint(equalTo: itemImage.bottomAnchor)
        ])

        contentView.addSubview(itemDesc)
        NSLayoutConstraint.activate([
            itemDesc.topAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: 10),
            itemDesc.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            itemDesc.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            itemDesc.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
