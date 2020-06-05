//
//  ItemPageCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 05/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class ItemPageCell: BaseCell {
    
    let itemName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let itemImage: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    
    override func setupCell() {
        backgroundColor = .systemRed
        
        addSubview(itemName)
        NSLayoutConstraint.activate([
            itemName.centerYAnchor.constraint(equalTo: centerYAnchor),
            itemName.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        addSubview(itemImage)
        NSLayoutConstraint.activate([
            itemImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            itemImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemImage.heightAnchor.constraint(equalToConstant: 60),
            itemImage.widthAnchor.constraint(equalTo: itemImage.heightAnchor)
        ])
        
    }
    
    
    func setItem(_ item: Item) {
        itemName.text = item.name
        itemImage.image = UIImage(named: item.key)
    }
    
}
