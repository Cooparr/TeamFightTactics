//
//  MenuCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 22/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class MenuCell: BaseCell {
    
    //MARK:- Properties
    let activeFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
    let inactiveFont = UIFont.systemFont(ofSize: 16, weight: .regular)
    let menuLabel: BaseLabel = {
        let lbl = BaseLabel(fontSize: 16, fontWeight: .regular, fontColor: ThemeColor.romanSilver)
        lbl.textAlignment = .center
        return lbl
    }()
    
    override var isHighlighted: Bool {
        didSet{
            menuLabel.textColor = isHighlighted ? ThemeColor.platinum : ThemeColor.romanSilver
            menuLabel.font = isHighlighted ? activeFont : inactiveFont
        }
    }
    
    override var isSelected: Bool {
        didSet{
            menuLabel.textColor = isSelected ? ThemeColor.platinum : ThemeColor.romanSilver
            menuLabel.font = isSelected ? activeFont : inactiveFont
        }
    }
    
    
    //MARK:- Override Setup Cell Views
    override func setupCellViews() {
        addSubview(menuLabel)
        menuLabel.pinSubview(to: self)
    }
}
