//
//  CSItemCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 24/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class CStemCell: BaseCell, ReusableCell {
    
    //MARK:- Properties
    typealias DataType = Item
    static let reuseId: String = "combinedItemsId"

    override var isSelected: Bool {
        willSet {
            handleSelectedState(newValue)
        }
    }
    
    
    let combinedItemImage: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 3.0
        imgView.layer.borderWidth = 1.5
        imgView.layer.borderColor = ThemeColor.independence.cgColor
        imgView.alpha = 0.4
        return imgView
    }()
    
    
    //MARK:- Setup Cell
    override func setupCell() {
        layer.cornerRadius = 3
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.pinSubview(to: self)
        
        contentView.addSubview(combinedItemImage)
        combinedItemImage.pinSubview(to: contentView)
    }
    
    
    //MARK:- Configure Cell
    func configureCell(with item: Item) {
        combinedItemImage.image = UIImage(named: item.key)
    }
    
    
    //MARK:- Handle Selected State Attributes
    fileprivate func handleSelectedState(_ newValue: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.combinedItemImage.alpha = newValue ? 1 : 0.4
            self.combinedItemImage.layer.borderColor = newValue ? ThemeColor.platinum.cgColor : ThemeColor.independence.cgColor
            self.combinedItemImage.layer.borderWidth = newValue ? 2.5 : 1.5
        }
    }
}
