//
//  BaseLabel.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 04/11/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class BaseLabel: UILabel {
    
    //MARK: Override Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }

    
    //MARK: Main Convenience Init
    convenience init(fontSize: CGFloat, fontWeight: UIFont.Weight, fontColor: UIColor = ThemeColor.platinum, lblText: String? = nil, textAlignment: NSTextAlignment = .natural, multiLine: Bool = false) {
        self.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        self.textColor = fontColor
        self.text = lblText
        self.textAlignment = textAlignment
        
        if multiLine {
            self.numberOfLines = 0
            self.lineBreakMode = .byWordWrapping
        }
    }
    
    
    //MARK: Alignment Convenience Init
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        self.textColor = ThemeColor.platinum
    }
    
    
    //MARK: Text Style Convenience Init
    convenience init(textStyle: UIFont.TextStyle, weight: UIFont.Weight, fontColor: UIColor = ThemeColor.platinum, textAlignment: NSTextAlignment = .natural, text: String? = nil) {
        self.init(frame: .zero)
        self.font = UIFont.preferredFont(for: textStyle, weight: weight)
        self.adjustsFontForContentSizeCategory = true
        self.adjustsFontSizeToFitWidth = true
        self.textColor = fontColor
        self.textAlignment = textAlignment
        self.text = text
        self.numberOfLines = 0
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
