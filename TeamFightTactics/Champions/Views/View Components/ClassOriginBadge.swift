//
//  ClassOriginBadge.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 29/11/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class ClassOriginBadge: BaseView {

    //MARK:- Properties
    let typeLabel = BaseLabel(fontSize: 12, fontWeight: .regular)
    let typeIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.tintColor = ThemeColor.platinum
        return imgView
    }()

    
    //MARK:- Setup Views
    override func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ThemeColor.romanSilver
        layer.cornerRadius = 2.0
        heightAnchor.constraint(equalToConstant: 17).isActive = true
    }
    
    //MARK:- Setup Subviews
    override func setupSubviews() {
        addSubview(typeIcon)
        addSubview(typeLabel)
        
        NSLayoutConstraint.activate([
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
