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
    let traitCount: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.makeCircular(size: 20)
        lbl.font = .systemFont(ofSize: 14, weight: .regular)
        lbl.backgroundColor = ThemeColor.richBlack
        lbl.layer.borderWidth = 1
        lbl.textColor = ThemeColor.platinum
        return lbl
    }()
    
    
    //MARK:- Setup Stack
    override func setupStack() {
        axis = .horizontal
        alignment = .center
        spacing = 10
    }
    
    
    //MARK:- Setup Arranged Subviews
    override func setupArrangedSubviews() {
        addArrangedSubviews(traitCount, traitValue)
    }
}
