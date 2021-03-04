//
//  DropRateCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 14/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class DropRateCell: BaseColViewCell, ReusableCell {
    
    //MARK:- Properties
    typealias DataType = String
    static var reuseId: String = "dropRateCellId"
    let dropRateValue: BaseLabel = {
        let lbl = BaseLabel(fontSize: 15, fontWeight: .bold)
        lbl.textAlignment = .center
        return lbl
    }()
    
    
    //MARK:- Configure Cell
    func configureCell(with dropRateChance: String) {
        dropRateValue.text = dropRateChance
    }
    
    
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
