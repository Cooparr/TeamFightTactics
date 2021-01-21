//
//  BSSelectorCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 15/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class BSSelectorCell: BaseColViewCell, ReusableCell {
    
    //MARK: Properties
    static let reuseId: String = "baseSelectionId"
    let baseItemImage = GenericImageView(cornerRadius: 3.0, borderWidth: 1.5, borderColor: .independence)

    override var isSelected: Bool {
        willSet {
            handleSelectedState(newValue)
        }
    }
    
    //MARK: Configure Cell
    func configureCell(with item: Item) {
        baseItemImage.image = UIImage(named: item.name.formattedName())
    }
    
    
    //MARK: Setup Cell
    override func setupCell() {
        clipsToBounds = true
        layer.cornerRadius = 3.0
    }
    
    
    //MARK: Setup Cell Views
    override func setupCellViews() {
        addSubview(baseItemImage)
        baseItemImage.alpha = 0.4
        baseItemImage.pinSubview(to: self)
    }
    
    
    //MARK: Handle Selected State Attributes
    fileprivate func handleSelectedState(_ newValue: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.baseItemImage.alpha = newValue ? 1 : 0.4
            self.baseItemImage.layer.borderColor = newValue ? ThemeColor.platinum.cgColor : ThemeColor.independence.cgColor
            self.baseItemImage.layer.borderWidth = newValue ? 2 : 1.5
        }
    }
}
