//
//  CreateTCSortButton.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 14/01/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class CreateTCSortButton: UIButton {
    
    //MARK:- Properties
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? ThemeColor.romanSilver : ThemeColor.richBlack
        }
    }
    
    
    //MARK:- Override Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .callout)
        
        setTitleColor(.tertiaryLabel, for: .normal)
        setTitleColor(ThemeColor.platinum, for: .selected)
        
        layer.borderColor = ThemeColor.romanSilver.cgColor
        layer.borderWidth = 1.5
        layer.cornerRadius = 6
    }
    
    
    //MARK: Convenience Init
    convenience init(title: String, tag: Int) {
        self.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.tag = tag
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
