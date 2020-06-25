//
//  BSSelectorCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 15/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class BSSelectorCell: BaseCell, ReusableCell {
    
    //MARK: Properties
    static let reuseId: String = "baseSelectionId"
    override var isSelected: Bool {
        willSet {
            handleSelectedState(newValue)
        }
    }
    
    let baseItemImage: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 3.0
        imgView.layer.borderWidth = 1.5
        imgView.layer.borderColor = ThemeColor.independence.cgColor
        imgView.alpha = 0.4
        return imgView
    }()
    
    
    //MARK: Configure Cell
    func configureCell(with item: Item) {
        baseItemImage.image = UIImage(named: item.key)
    }
    
    
    //MARK: Setup Cell
    override func setupCell() {
        clipsToBounds = true
        layer.cornerRadius = 3.0
    }
    
    
    //MARK: Setup Cell Views
    override func setupCellViews() {
        addSubview(baseItemImage)
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
