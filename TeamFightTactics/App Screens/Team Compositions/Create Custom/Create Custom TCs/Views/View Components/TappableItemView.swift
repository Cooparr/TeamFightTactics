//
//  TappableItemView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 22/02/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

protocol RemoveCustomItemDelegate: class {
    func removeCustomItem(cell: SelectedChampionCell, _ itemName: String)
}

class TappableItemView: BaseView {
    
    //MARK: Properties
    var hasItem = false
    var itemName: String?
    let itemImageView = GeneralImageView(frame: .zero)
    weak var removeItemDelegate: RemoveCustomItemDelegate?
    
    //MARK: Setup View
    override func setupView() {
        super.setupView()
        clipsToBounds = true
        layer.borderWidth = 1
        layer.cornerRadius = 2
        layer.borderColor = ThemeColor.independence.cgColor
        backgroundColor = ThemeColor.richBlack
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 35),
            self.widthAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
 
    
    //MARK: Setup Subviews
    override func setupSubviews() {
        super.setupSubviews()
        addSubview(itemImageView)
        itemImageView.pinSubview(to: self)
    }
    
    
    //MARK: Set Item
    func setItem(_ itemName: String) {
        self.itemName = itemName
        self.itemImageView.image = UIImage(named: itemName)
        self.hasItem = true
    }
    
    
    //MARK: Clear Item
    func clearItem() {
        self.itemName = nil
        self.itemImageView.image = nil
        self.hasItem = false
    }
}
