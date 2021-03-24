//
//  TCSynergyBadge.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 01/11/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCSynergyBadge: GradientView {
    
    //MARK:- Properties
    private(set) var badgeTint = ThemeColor.platinum
    private let synergyIcon = IconImageView()
    private let synergyCountLabel = BaseLabel(fontSize: 14, fontWeight: .semibold, textAlignment: .center)
    

    //MARK:- Init
    override init(gradientDirection: GradientView.GradientDirection) {
        super.init(gradientDirection: gradientDirection)
        setupView()
        setupSubviews()
    }

    
    //MARK: Update Synergy Badge
    func updateSynergyBadge(with synergy: TCSynergy) {
        badgeTint = getTintColor(for: synergy.rank, synergy.isChosen)
        updateGradientColors(for: synergy.rank, synergy.isChosen)
        synergyCountLabel.text = "\(synergy.count)"
        synergyCountLabel.textColor = badgeTint
        synergyIcon.image = UIImage(named: "\(synergy.name)")
        synergyIcon.tintColor = badgeTint
    }
    

    //MARK:- Setup View
    private func setupView() {
        layer.cornerRadius = 2
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 25),
            widthAnchor.constraint(equalToConstant: 40)
        ])
    }


    //MARK: Setup Subviews
    private func setupSubviews() {
        let iconSize: CGFloat = 16
        let padding: CGFloat = 4
        
        addSubviews(synergyIcon, synergyCountLabel)
        NSLayoutConstraint.activate([
            synergyIcon.widthAnchor.constraint(equalToConstant: iconSize),
            synergyIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            synergyIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),

            synergyCountLabel.widthAnchor.constraint(equalToConstant: iconSize),
            synergyCountLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            synergyCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
    }

    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
