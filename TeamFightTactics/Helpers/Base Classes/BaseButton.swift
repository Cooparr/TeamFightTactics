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
        backgroundColor = ThemeColor.romanSilver
        setTitleColor(ThemeColor.platinum, for: .normal)
    }
    
    
    //MARK: Convenience Init
    convenience init(textStyle: UIFont.TextStyle, cornerRadius: CGFloat) {
        self.init(frame: .zero)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: textStyle)
        layer.cornerRadius = cornerRadius
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
