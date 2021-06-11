//
//  BaseButton.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 09/06/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class BaseButton: UIButton {
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    //MARK:- Convenience Inits
    convenience init(textStyle: UIFont.TextStyle, titleColor: UIColor = ThemeColor.platinum, cornerRadius: CGFloat) {
        self.init(frame: .zero)
        backgroundColor = ThemeColor.romanSilver
        layer.cornerRadius = cornerRadius
        setTitleColor(titleColor, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: textStyle)
    }
    
    
    convenience init(btnImage: UIImage?, tintColor: UIColor) {
        self.init(frame: .zero)
        setImage(btnImage, for: .normal)
        self.tintColor = tintColor
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
