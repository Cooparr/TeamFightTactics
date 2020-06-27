//
//  CSItemCell.swift
//  TeamFightTactics
//
//  Created by Alex Cooper on 26/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class CSItemCell: BaseCell, ReusableCell {
    
    //MARK:- Properties
    typealias DataType = Item
    static var reuseId: String = "combinedItemId"
    
    let itemTier: BaseLabel = {
        let lbl = BaseLabel(fontSize: 12, fontWeight: .semibold)
        lbl.textColor = ThemeColor.richBlack
        lbl.textAlignment = .center
        lbl.clipsToBounds = true
        lbl.layer.cornerRadius = 6.0
        lbl.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        return lbl
    }()
    
    let itemName = BaseLabel(fontSize: 16, fontWeight: .medium)
    let itemDesc: BaseLabel = {
        let lbl = BaseLabel(fontSize: 14, fontWeight: .regular)
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
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
    
    
    let statViewArray = (1...3).map { _ in StatView(statWidth: 70, iconSize: 17, fontSize: 13, fontWeight: .regular) }
    lazy var statHorizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: statViewArray)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
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
        itemImage.image = UIImage(named: item.key)
        item.tier.setTierTextAndColor(for: itemTier)
        itemDesc.text = item.description
        updateStatView(item.stats)
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
        
        contentView.addSubview(itemImage)
        NSLayoutConstraint.activate([
            itemImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            itemImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            itemImage.heightAnchor.constraint(equalToConstant: 50),
            itemImage.widthAnchor.constraint(equalTo: itemImage.heightAnchor)
        ])
        
        contentView.addSubview(itemName)
        NSLayoutConstraint.activate([
            itemName.topAnchor.constraint(equalTo: itemImage.topAnchor),
            itemName.leadingAnchor.constraint(equalTo: itemImage.trailingAnchor, constant: 10),
            itemName.trailingAnchor.constraint(equalTo: itemTier.leadingAnchor, constant: -10)
        ])
        
        contentView.addSubview(statHorizontalStack)
        NSLayoutConstraint.activate([
            statHorizontalStack.topAnchor.constraint(equalTo: itemName.bottomAnchor, constant: 10),
            statHorizontalStack.leadingAnchor.constraint(equalTo: itemName.leadingAnchor),
            statHorizontalStack.bottomAnchor.constraint(equalTo: itemImage.bottomAnchor)
        ])
        
        contentView.addSubview(itemDesc)
        NSLayoutConstraint.activate([
            itemDesc.topAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: 10),
            itemDesc.leadingAnchor.constraint(equalTo: itemImage.leadingAnchor),
            itemDesc.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            itemDesc.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    
    //MARK:- Reset Stat View
    fileprivate func resetStatViews() {
        statViewArray.forEach { (statView) in
            statView.statLabel.text = nil
            statView.statIcon.image = nil
            statView.statIcon.tintColor = nil
        }
    }
    
    
    //MARK:- Update Stat View
    fileprivate func updateStatView(_ stats: [ItemStat]) {
        for (index, stat) in stats.enumerated() {
            guard
                let key = stat.key,
                let value = stat.value
                else { return }
            
            let statView = statViewArray[index]
            statView.statLabel.text = "+\(value)"
            statView.updateStatIcon(statType: key)
        }
    }
}
