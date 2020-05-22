//
//  TraitsView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 22/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class TraitsView: UIView {
    
    //MARK:- Properties
    let menuBar = MenuBar()
    
    
    //MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
        constrainMenuBar()
    }
    
    
    //MARK:- Constrain Menu Bar
    fileprivate func constrainMenuBar() {
        addSubview(menuBar)
        NSLayoutConstraint.activate([
            menuBar.heightAnchor.constraint(equalToConstant: 50),
            menuBar.topAnchor.constraint(equalTo: topAnchor),
            menuBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
