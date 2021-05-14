//
//  ItemSelectorCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 12/05/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class ItemSelectorCell: BaseColViewCell, ReusableCell {
    
    //MARK:- Properties
    typealias DataType = Item
    static let reuseId: String = "itemSelectorCellId"
    
    private(set) var item: Item?
    private let itemImageView = ItemImageView(cornerRadius: 3.0)
    private let universalBorderWidth: CGFloat = 2.0
    private let fadedBorderColor: UIColor = ThemeColor.independence
    private let selectedBorderColor: UIColor = ThemeColor.platinum
    let fadedAlphaValue: CGFloat = 0.4
    let selectedAlphaValue: CGFloat = 1.0

    
    //MARK: Override isSelected
    override var isSelected: Bool {
        willSet {
            guard let isShadowItem = item?.isShadow else { return }
            UIView.animate(withDuration: 0.5) {
                self.updateCellApperance(ifSelected: newValue, orShadow: isShadowItem)
            }
        }
    }
    
    
    //MARK: Prepare For Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        resetContentViewBorder()
    }
    
    
    //MARK:- Configure Cell
    func configureCell(with item: Item) {
        self.item = item
        itemImageView.image = UIImage(named: item.name.formattedName())
        updateCellApperance(ifSelected: isSelected, orShadow: item.isShadow)
    }
    
    
    //MARK:- Setup Cell
    override func setupCell() {
        clipsToBounds = true
        layer.cornerRadius = 3.0        
    }
    
    
    //MARK:- Setup Cell Views
    override func setupCellViews() {
        contentView.addSubview(itemImageView)
        itemImageView.pinSubview(to: contentView)
    }
    
    
    //MARK: Update Cell Apperance
    private func updateCellApperance(ifSelected isSelected: Bool, orShadow isShadow: Bool) {
        contentView.alpha = isSelected ? selectedAlphaValue : fadedAlphaValue
        
        guard !isShadow else { return }
        contentView.layer.borderColor = isSelected ? selectedBorderColor.cgColor : fadedBorderColor.cgColor
        contentView.layer.borderWidth = universalBorderWidth
    }
    
    
    //MARK: Reset Content View Border
    private func resetContentViewBorder() {
        contentView.layer.borderColor = nil
        contentView.layer.borderWidth = 0.0
    }
}
