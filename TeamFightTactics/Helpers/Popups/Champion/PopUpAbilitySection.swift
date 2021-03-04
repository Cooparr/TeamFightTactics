//
//  PopUpAbilitySection.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 13/10/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class PopUpAbilitySection: BaseView {
    
    //MARK:- Properties
    let abilityName = BaseLabel(fontSize: 18, fontWeight: .semibold)
    let abilityMana = BaseLabel(fontSize: 13, fontWeight: .semibold)
    let abilityDesc = BaseLabel(fontSize: 14, fontWeight: .regular, multiLine: true)
    let abilityManaContainer = BaseView(tamic: false)
    let abilityStatsStack = BaseStack(axis: .vertical, spacing: 5)
    let abilityManaIcon = IconImageView(icon: StatIcon.mana, tintColor: StatIconColor.mana)
    let abilityImage = GenericImageView(cornerRadius: 4.0, borderWidth: 1.5, borderColor: ThemeColor.romanSilver)

    
    //MARK:- Override Setup View
    override func setupView() {
        abilityManaContainer.addSubviews(abilityManaIcon, abilityMana)
        constrainManaIconAndLabel()
        
        addSubviews(abilityImage, abilityManaContainer, abilityName, abilityDesc, abilityStatsStack)
        constrainAbilityImage()
        constrainManaContainer()
        constrainNameDescriptionAndStats()
    }
    
    
    //MARK:- Configure Ability Section
    func configureAbilitySection(_ champAbility: ChampionAbility) {
        setAbilityInfo(for: champAbility)
        createAbilityStatLabels(champAbility)
    }
    
    
    //MARK:- Set Ability Info
    #warning("Duplicate function - already in ChampAbilityView Class - Inhertience might fix this!")
    fileprivate func setAbilityInfo(for champAbility: ChampionAbility) {
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
    
    
    //MARK:- Create Ability Stat Labels
    fileprivate func createAbilityStatLabels(_ champAbility: ChampionAbility) {
        champAbility.abilityStat.forEach { (statName, statValues) in
            let abilityStatLabel = BaseLabel(fontSize: 14, fontWeight: .regular, multiLine: true)
            let valueString = statValues.map {
                guard let val = $0.getValue else { return "nil" }
                return "\(val)"
            }.joined(separator: " / ")
            abilityStatLabel.text = "\(statName): \(valueString)"
            abilityStatsStack.addArrangedSubview(abilityStatLabel)
        }
    }
    
    
    //MARK:- Constrain Mana Icon & Label
    fileprivate func constrainManaIconAndLabel() {
        NSLayoutConstraint.activate([
            abilityManaIcon.heightAnchor.constraint(equalToConstant: 12),
            abilityManaIcon.widthAnchor.constraint(equalTo: abilityManaIcon.heightAnchor),
            abilityManaIcon.topAnchor.constraint(equalTo: abilityManaContainer.topAnchor),
            abilityManaIcon.leadingAnchor.constraint(equalTo: abilityManaContainer.leadingAnchor),
            abilityManaIcon.bottomAnchor.constraint(equalTo: abilityManaContainer.bottomAnchor),
            
            abilityMana.topAnchor.constraint(equalTo: abilityManaContainer.topAnchor),
            abilityMana.leadingAnchor.constraint(equalTo: abilityManaIcon.trailingAnchor, constant: 2),
            abilityMana.trailingAnchor.constraint(equalTo: abilityManaContainer.trailingAnchor),
            abilityMana.bottomAnchor.constraint(equalTo: abilityManaContainer.bottomAnchor)
        ])
    }
    
    
    //MARK:- Constrain Ability Image
    fileprivate func constrainAbilityImage() {
        NSLayoutConstraint.activate([
            abilityImage.heightAnchor.constraint(equalToConstant: 50),
            abilityImage.widthAnchor.constraint(equalTo: abilityImage.heightAnchor),
            abilityImage.topAnchor.constraint(equalTo: topAnchor),
            abilityImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
    }
    
    
    //MARK:- Constrain ManaContainer
    fileprivate func constrainManaContainer() {
        NSLayoutConstraint.activate([
            abilityManaContainer.bottomAnchor.constraint(equalTo: abilityImage.bottomAnchor, constant: -2),
            abilityManaContainer.leadingAnchor.constraint(equalTo: abilityName.leadingAnchor)
        ])
    }
    
    
    //MARK:- Constrain Name Description & Stats
    fileprivate func constrainNameDescriptionAndStats() {
        NSLayoutConstraint.activate([
            abilityName.bottomAnchor.constraint(equalTo: abilityManaContainer.topAnchor, constant: -4),
            abilityName.leadingAnchor.constraint(equalTo: abilityImage.trailingAnchor, constant: 6),
            
            abilityDesc.topAnchor.constraint(equalTo: abilityImage.bottomAnchor, constant: 6),
            abilityDesc.leadingAnchor.constraint(equalTo: abilityImage.leadingAnchor),
            abilityDesc.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            
            abilityStatsStack.topAnchor.constraint(equalTo: abilityDesc.bottomAnchor, constant: 4),
            abilityStatsStack.leadingAnchor.constraint(equalTo: abilityDesc.leadingAnchor, constant: 20),
            abilityStatsStack.trailingAnchor.constraint(equalTo: abilityDesc.trailingAnchor),
            abilityStatsStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
