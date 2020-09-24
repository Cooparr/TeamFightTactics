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
    
    let itemTier: BaseLabel = {
        let lbl = BaseLabel(fontSize: 12, fontWeight: .semibold, fontColor: ThemeColor.richBlack)
        lbl.textAlignment = .center
        lbl.clipsToBounds = true
        lbl.layer.cornerRadius = 6.0
        lbl.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        return lbl
    }()
    let itemImage: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 3.0
        imgView.layer.borderWidth = 2
        imgView.layer.borderColor = ThemeColor.independence.cgColor
        return imgView
    }()
    
    let itemName = BaseLabel(fontSize: 18, fontWeight: .medium)
    let itemDesc = BaseLabel(fontSize: 14, fontWeight: .regular, multiLine: true)
    let itemRecipeStack = ItemRecipeStack()
    let itemStatsStack = ItemStatsStack()
    
    let recipeAndStatsStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .leading
        return stack
    }()
    
    
    //MARK:- Prepare For Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        resetStatViews()
    }
    
    
    //MARK:- Configure Cell
    func configureCell(with item: Item) {
        itemName.text = item.name
        itemImage.image = UIImage(named: item.name.formattedName())
        item.tier.setTierTextAndColor(for: itemTier)
        itemDesc.text = item.description
        updateItemRecipe(item.from)
        updateItemStats(item.stats)
    }
    
    
    //MARK:- Setup Cell
    override func setupCell() {
        backgroundColor = ThemeColor.charcoal
        layer.cornerRadius = 6.0
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.pinSubview(to: self)
        contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true
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
    
    
    //MARK:- Update Item Recipe
    fileprivate func updateItemRecipe(_ fromItems: [String]?) {
        guard let items = fromItems else { return }
        for (index, itemName) in items.enumerated() {
            itemRecipeStack.setRecipeImage(with: itemName, for: index)
        }
    }
    
    
    //MARK:- Update Item Stats
    fileprivate func updateItemStats(_ itemStats: [ItemStat]?) {
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
    fileprivate func resetStatViews() {
        itemStatsStack.arrangedSubviews.forEach { (statView) in
            guard let view = statView as? StatView else { return }
            view.statLabel.text = nil
            view.statIcon.image = nil
            view.statIcon.tintColor = nil
        }
    }
}
