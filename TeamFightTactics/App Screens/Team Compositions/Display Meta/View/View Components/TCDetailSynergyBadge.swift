//
//  TCDetailSynergyBadge.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 29/04/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCDetailSynergyBadge: GradientView {
    
    //MARK:- Properties
    private(set) var badgeTint = ThemeColor.platinum
    private let synergyIcon = IconImageView()
    private let synergyNameLabel = BaseLabel(fontSize: 14, fontWeight: .semibold, textAlignment: .center)
    
    
    //MARK:- Init
    override init(gradientDirection: GradientView.GradientDirection) {
        super.init(gradientDirection: gradientDirection)
        setupSubviews()
        layer.cornerRadius = 4
    }
    
    
    //MARK: Update Synergy Badge
    func configureSynergyBadge(with trait: Trait) {
        badgeTint = getTintColor(for: trait.rank, trait.isChosen)
        updateGradientColors(for: trait.rank, trait.isChosen)
        synergyIcon.tintColor = badgeTint
        synergyIcon.image = UIImage(named: "\(trait.name)")
        synergyNameLabel.textColor = badgeTint
        synergyNameLabel.text = trait.name
    }
    
    
    //MARK:- Setup Subviews
    private func setupSubviews() {
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
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
