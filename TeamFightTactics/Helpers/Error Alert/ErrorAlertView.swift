//
//  ErrorAlertView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 21/01/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class ErrorAlertView: UIView {
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ThemeColor.charcoal
        
        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = ThemeColor.richBlack.cgColor
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
