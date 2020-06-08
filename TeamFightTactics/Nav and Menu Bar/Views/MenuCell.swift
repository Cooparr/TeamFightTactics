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
    let menuLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.textColor = ThemeColor.romanSilver
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return lbl
    }()
    
    override var isHighlighted: Bool {
        didSet{
            guard isHighlighted != oldValue else { return }
            menuLabel.textColor = isHighlighted ? ThemeColor.platinum : ThemeColor.romanSilver
            menuLabel.font = isHighlighted ? activeFont : inactiveFont
        }
    }
    
    override var isSelected: Bool {
        didSet{
            guard isSelected != oldValue else { return }
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
