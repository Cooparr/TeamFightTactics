//
//  TCDetailSynergyBadge.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 29/04/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCDetailSynergyBadge: UIView {
    
    //MARK:- Properties
    let synergyIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.tintColor = ThemeColor.platinum
        return imgView
    }()
    
    let synergyNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = ThemeColor.platinum
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return lbl
    }()
    
    
    //MARK:- Override Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupBadge()
        setupIconAndLabelSubviews()
        
        
        backgroundColor = TraitRatingColor.gold
    }
    
    
    //MARK:- Setup Synergry Badge View
    fileprivate func setupBadge() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 2.0
    }
    
    
    //MARK:- Setup Subviews & Constraints
    fileprivate func setupIconAndLabelSubviews() {
        let iconSize: CGFloat = 20
        let padding: CGFloat = 5
        
        addSubview(synergyIcon)
        NSLayoutConstraint.activate([
            synergyIcon.widthAnchor.constraint(equalToConstant: iconSize),
            synergyIcon.heightAnchor.constraint(equalToConstant: iconSize),
            synergyIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            synergyIcon.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            synergyIcon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
        
        addSubview(synergyNameLabel)
        NSLayoutConstraint.activate([
            synergyNameLabel.leadingAnchor.constraint(equalTo: synergyIcon.trailingAnchor, constant: padding),
            synergyNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            synergyNameLabel.topAnchor.constraint(equalTo: topAnchor),
            synergyNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
