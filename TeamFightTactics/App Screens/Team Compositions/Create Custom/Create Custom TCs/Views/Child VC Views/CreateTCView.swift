//
//  CreateTeamCompView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 04/12/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class CreateTCView: BaseView {
    
    //MARK:- Properties
    let mainStackView = BaseStack(axis: .vertical, spacing: 10)
    
    
    //MARK:- Setup View
    override func setupView() {
        backgroundColor = ThemeColor.richBlack
        
        addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
