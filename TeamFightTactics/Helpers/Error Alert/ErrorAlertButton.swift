//
//  ErrorAlertButton.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 21/01/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class ErrorAlertButton: UIButton {
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    
    //MARK: Convenience Init
    convenience init(backgroundColor: UIColor, title: String = "Okay") {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
    
    //MARK: Configure Button
    private func configureButton() {
        layer.cornerRadius = 10
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        setTitleColor(ThemeColor.platinum, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    //MARK: Set Button
    func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
