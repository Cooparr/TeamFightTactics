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
        mainStackView.pinSubviewWithPadding(to: self, top: 10, leading: 10, trailing: -10, bottom: -35)
    }
}
