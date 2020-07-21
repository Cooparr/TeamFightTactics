//
//  BaseLabel.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 04/11/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class BaseLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        textColor = ThemeColor.platinum
    }

    convenience init(fontSize: CGFloat, fontWeight: UIFont.Weight, multiLine: Bool = false) {
        self.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        if multiLine {
            self.numberOfLines = 0
            self.lineBreakMode = .byWordWrapping
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
