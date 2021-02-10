//
//  ClassOriginBadge.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 29/11/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class ChampTraitBadge: BaseView {

    //MARK:- Properties
    let typeLabel = BaseLabel(fontSize: 12, fontWeight: .regular)
    let typeIcon = IconImageView(tintColor: ThemeColor.platinum)
    
    
    //MARK:- Setup View
    override func setupView() {
        backgroundColor = ThemeColor.romanSilver
        layer.cornerRadius = 2
    }
    
    
    //MARK:- Setup Subviews
    override func setupSubviews() {
        addSubviews(typeIcon, typeLabel)
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 17),
            
            typeIcon.heightAnchor.constraint(equalToConstant: 12.5),
            typeIcon.widthAnchor.constraint(equalToConstant: 12.5),
            typeIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            typeIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            typeIcon.trailingAnchor.constraint(equalTo: typeLabel.leadingAnchor, constant: -2),
            
            typeLabel.leadingAnchor.constraint(equalTo: typeIcon.trailingAnchor, constant: 2),
            typeLabel.topAnchor.constraint(equalTo: topAnchor),
            typeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            typeLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
