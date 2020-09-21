//
//  TCSynergyBadge.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 01/11/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCSynergyBadge: BaseView {
    
    //MARK:- Properties
    let synergyIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.tintColor = ThemeColor.platinum
        return imgView
    }()
    
    let synergyCountLabel: BaseLabel = {
        let lbl = BaseLabel(fontSize: 14, fontWeight: .semibold)
        lbl.textAlignment = .center
        return lbl
    }()
    
    
    //MARK:- Setup View
    override func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 2.0
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 25),
            widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    //MARK: Setup Subviews
    override func setupSubviews() {
        addSubviews(synergyIcon, synergyCountLabel)
        NSLayoutConstraint.activate([
            synergyIcon.widthAnchor.constraint(equalToConstant: 16),
            synergyIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            synergyIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            
            synergyCountLabel.widthAnchor.constraint(equalToConstant: 16),
            synergyCountLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            synergyCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4)
        ])
    }
}
