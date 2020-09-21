//
//  StatView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 18/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit


class StatView: BaseView {
    
    //MARK:- Properties
    let statLabel: BaseLabel
    let iconSize: CGFloat
    let statIcon = BaseImageView()
    
    
    //MARK:- Required Init
    required init(statWidth: CGFloat, iconSize: CGFloat, fontSize: CGFloat, fontWeight: UIFont.Weight) {
        self.iconSize = iconSize
        self.statLabel = BaseLabel(fontSize: fontSize, fontWeight: fontWeight)
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: statWidth).isActive = true
    }
       
    
    //MARK:- Setup View
    override func setupView() {
        addSubviews(statIcon, statLabel)
        NSLayoutConstraint.activate([
            statIcon.heightAnchor.constraint(equalToConstant: iconSize),
            statIcon.widthAnchor.constraint(equalToConstant: iconSize),
            statIcon.topAnchor.constraint(equalTo: topAnchor),
            statIcon.leadingAnchor.constraint(equalTo: leadingAnchor),
            statIcon.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            statLabel.topAnchor.constraint(equalTo: statIcon.topAnchor),
            statLabel.leadingAnchor.constraint(equalTo: statIcon.trailingAnchor, constant: 4),
            statLabel.bottomAnchor.constraint(equalTo: statIcon.bottomAnchor),
            statLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    
    func updateStatIcon(statType: StatType) {
        switch statType {
        case .attDmg:
            statIcon.image = StatIcon.attackDamage
            statIcon.tintColor = StatIconColor.attDamage
        case .attSpd:
            statIcon.image = StatIcon.attackSpeed
            statIcon.tintColor = StatIconColor.attSpeed
        case .armor:
            statIcon.image = StatIcon.armor
            statIcon.tintColor = StatIconColor.armor
        case .health:
            statIcon.image = StatIcon.health
            statIcon.tintColor = StatIconColor.health
        case .abilityPower:
            statIcon.image = StatIcon.abilityPower
            statIcon.tintColor = StatIconColor.abilityPower
        case .magicResist:
            statIcon.image = StatIcon.magicResist
            statIcon.tintColor = StatIconColor.magicResist
        case .critChance:
            statIcon.image = StatIcon.critChance
            statIcon.tintColor = StatIconColor.critChance
        case .dodgeChance:
            statIcon.image = StatIcon.dodgeChance
            statIcon.tintColor = StatIconColor.dodgeChance
        case .mana:
            statIcon.image = StatIcon.mana
            statIcon.tintColor = StatIconColor.mana
        case .range:
            statIcon.image = StatIcon.range
            statIcon.tintColor = StatIconColor.range
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
