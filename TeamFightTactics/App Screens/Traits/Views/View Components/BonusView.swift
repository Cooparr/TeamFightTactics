//
//  BonusView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 02/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class BonusView: BaseStack {
    
    //MARK:- Properties
    let traitValue = BaseLabel(fontSize: 14, fontWeight: .regular, multiLine: true)
    let traitCountView = CircularTraitCountView(size: 25.0)
    
    
    //MARK:- Setup Stack
    override func setupStack() {
        axis = .horizontal
        alignment = .center
        spacing = 10
    }
    
    
    //MARK:- Setup Arranged Subviews
    override func setupArrangedSubviews() {
        addArrangedSubviews(traitCountView, traitValue)
    }
}
