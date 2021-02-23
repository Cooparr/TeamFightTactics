//
//  TappableItemView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 22/02/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class TappableItemView: BaseView {
    
    //MARK: Properties
    var hasItem = false
    var itemName: String?
    let itemImageView = GeneralImageView(frame: .zero)
    
    
    //MARK: Setup View
    override func setupView() {
        super.setupView()
        clipsToBounds = true
        layer.borderWidth = 1
        layer.cornerRadius = 2
        layer.borderColor = ThemeColor.independence.cgColor
        backgroundColor = ThemeColor.richBlack
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clearItem))
        self.addGestureRecognizer(tapGesture)
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
        itemImageView.image = UIImage(named: itemName)
        hasItem = true
    }
    
    
    //MARK: Clear Item
    @objc func clearItem() {
        itemName = nil
        itemImageView.image = nil
        hasItem = false
    }
}
