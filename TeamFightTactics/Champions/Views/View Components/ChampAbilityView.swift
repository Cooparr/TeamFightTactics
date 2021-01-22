//
//  ChampAbilityView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 03/08/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class ChampAbilityView: BaseView {
    
    //MARK:- Properties
    let abilityName = BaseLabel(fontSize: 13, fontWeight: .semibold)
    let abilityMana = BaseLabel(fontSize: 11, fontWeight: .regular)
    let abilityDesc = BaseLabel(fontSize: 11, fontWeight: .regular, multiLine: true)
    let abilityManaIcon = IconImageView(icon: StatIcon.mana, tintColor: StatIconColor.mana)
    let abilityImage = GenericImageView(cornerRadius: 2.0, borderWidth: 1.0, borderColor: ThemeColor.romanSilver)
    

    //MARK:- Setup Subviews
    override func setupSubviews() {
        addSubviews(abilityImage, abilityName, abilityManaIcon, abilityMana, abilityDesc)
        NSLayoutConstraint.activate([
            abilityImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            abilityImage.heightAnchor.constraint(equalToConstant: 30),
            abilityImage.widthAnchor.constraint(equalTo: abilityImage.heightAnchor),
            abilityImage.topAnchor.constraint(equalTo: topAnchor),
            
            abilityName.leadingAnchor.constraint(equalTo: abilityImage.trailingAnchor, constant: 6),
            abilityName.topAnchor.constraint(equalTo: abilityImage.topAnchor),
            
            abilityManaIcon.leadingAnchor.constraint(equalTo: abilityName.trailingAnchor, constant: 8),
            abilityManaIcon.centerYAnchor.constraint(equalTo: abilityName.centerYAnchor),
            abilityManaIcon.heightAnchor.constraint(equalToConstant: 10),
            abilityManaIcon.widthAnchor.constraint(equalTo: abilityManaIcon.heightAnchor),
            
            abilityMana.leadingAnchor.constraint(equalTo: abilityManaIcon.trailingAnchor, constant: 2),
            abilityMana.centerYAnchor.constraint(equalTo: abilityManaIcon.centerYAnchor),
            
            abilityDesc.topAnchor.constraint(equalTo: abilityName.bottomAnchor, constant: 2),
            abilityDesc.leadingAnchor.constraint(equalTo: abilityName.leadingAnchor),
            abilityDesc.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    
    //MARK: Set Champ Ability Info
    func setAbilityInfo(for champAbility: ChampionAbility) {
        abilityName.text = champAbility.name
        abilityDesc.text = champAbility.description
        abilityImage.sd_setImage(with: URL(string: champAbility.imgURL))
        
        switch champAbility.active {
        case false:
            abilityMana.text = "Passive"
        case true:
            if let manaStart = champAbility.manaStart, let manaCost = champAbility.manaCost {
                abilityMana.text = "\(manaStart)/\(manaCost)"
            }
        }
    }
}
