//
//  DropRateCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 14/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class DropRateCell: BaseCell {
    
    
    //MARK:- Properties
    let dropRateValue: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = ThemeColor.platinum
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return lbl
    }()
    
    
    //MARK:- Override Setup Cell
    override func setupCell() {
        backgroundColor = ThemeColor.charcoal
    }
    
    
    //MARK:- Override Setup Cell Views
    override func setupCellViews() {
        addSubview(dropRateValue)
        NSLayoutConstraint.activate([
            dropRateValue.centerYAnchor.constraint(equalTo: centerYAnchor),
            dropRateValue.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
