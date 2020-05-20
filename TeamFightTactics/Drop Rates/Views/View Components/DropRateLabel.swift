//
//  DropRateLabel.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 18/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class DropRateLabel: UILabel {

    //MARK:- Override Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    
    //MARK:- Setup Label
    fileprivate func setupLabel() {
        font = UIFont.systemFont(ofSize: 15, weight: .bold)
        textAlignment = .center
        textColor = ThemeColor.platinum
        backgroundColor = ThemeColor.charcoal
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
