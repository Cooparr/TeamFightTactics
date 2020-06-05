//
//  ItemCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 05/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class ItemCell: BaseCell {
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    override func setupCell() {
        backgroundColor = .systemRed
        layer.cornerRadius = 6.0
        layer.masksToBounds = true
        
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    
    func setItem(_ item: Item) {
        nameLabel.text = item.name
    }
    
}
