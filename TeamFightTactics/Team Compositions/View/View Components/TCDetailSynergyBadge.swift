//
//  TCDetailSynergyBadge.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 29/04/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCDetailSynergyBadge: BaseView {
    
    //MARK:- Properties
    let synergyIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.tintColor = ThemeColor.platinum
        return imgView
    }()
    
    let synergyNameLabel: BaseLabel = {
        let lbl = BaseLabel(fontSize: 14, fontWeight: .semibold)
        lbl.textAlignment = .center
        return lbl
    }()
    
    
    //MARK:- Setup View
    override func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 2.0
    }
    
    
    //MARK: Setup Subviews
    override func setupSubviews() {
        let iconSize: CGFloat = 20
        let padding: CGFloat = 5
        
        addSubviews(synergyIcon, synergyNameLabel)
        NSLayoutConstraint.activate([
            synergyIcon.widthAnchor.constraint(equalToConstant: iconSize),
            synergyIcon.heightAnchor.constraint(equalToConstant: iconSize),
            synergyIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            synergyIcon.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            synergyIcon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
        
        NSLayoutConstraint.activate([
            synergyNameLabel.leadingAnchor.constraint(equalTo: synergyIcon.trailingAnchor, constant: padding),
            synergyNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            synergyNameLabel.topAnchor.constraint(equalTo: topAnchor),
            synergyNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
