//
//  PopUpChampTraitBadge.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 09/10/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class PopUpChampTraitBadge: BaseView {
    
    //MARK:- Properties
    let typeLabel = BaseLabel(fontSize: 15, fontWeight: .semibold)
    let typeIcon = IconImageView(tintColor: ThemeColor.platinum)
    let iconContainer = BaseView(backgroundColor: ThemeColor.romanSilver)
    
    
    //MARK:- Layout Subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        iconContainer.layer.cornerRadius = iconContainer.bounds.size.width / 2
        iconContainer.clipsToBounds = true
    }
    
    //MARK:- Setup Subviews
    override func setupSubviews() {
        addSubviews(iconContainer, typeLabel)
        NSLayoutConstraint.activate([
            iconContainer.heightAnchor.constraint(equalToConstant: 20),
            iconContainer.widthAnchor.constraint(equalToConstant: 20),
            iconContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconContainer.trailingAnchor.constraint(equalTo: typeLabel.leadingAnchor, constant: -4),
            
            typeLabel.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 4),
            typeLabel.topAnchor.constraint(equalTo: topAnchor),
            typeLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            typeLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        iconContainer.addSubview(typeIcon)
        NSLayoutConstraint.activate([
            typeIcon.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            typeIcon.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            typeIcon.widthAnchor.constraint(equalToConstant: 17),
            typeIcon.heightAnchor.constraint(equalTo: typeIcon.widthAnchor)
        ])
    }
}
