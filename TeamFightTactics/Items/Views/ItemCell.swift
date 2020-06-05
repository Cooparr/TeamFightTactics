//
//  ItemCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 05/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class ItemCell: BaseCell {
    
    override func setupCell() {
        backgroundColor = .systemRed
        layer.cornerRadius = 6.0
        layer.masksToBounds = true
    }
    
}
