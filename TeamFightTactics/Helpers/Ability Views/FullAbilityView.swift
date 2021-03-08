//
//  FullAbilityView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 08/03/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class FullAbilityView: BaseView, AbilityViewProtocol {
    
    //MARK: Properties
    let abilityName = BaseLabel(fontSize: 18, fontWeight: .semibold)
    let abilityMana = BaseLabel(fontSize: 13, fontWeight: .semibold)
    let abilityDesc = BaseLabel(fontSize: 14, fontWeight: .regular, multiLine: true)
    let abilityManaIcon = IconImageView(icon: StatIcon.mana, tintColor: StatIconColor.mana)
    let abilityImage = GenericImageView(cornerRadius: 4.0, borderWidth: 1.5, borderColor: ThemeColor.romanSilver)
    private let abilityManaContainer = BaseView(tamic: false)
    private let abilityStatsStack = BaseStack(axis: .vertical, spacing: 5)
    
    
    //MARK: Full Init
    init(champAbility: ChampionAbility) {
        super.init(frame: .zero)
        createAbilityStatLabels(champAbility: champAbility)
    }
    
    
    //MARK: Create Ability Stat Labels
    fileprivate func createAbilityStatLabels(champAbility: ChampionAbility) {
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
    
    
    //MARK: Setup Subviews
    override func setupSubviews() {
        abilityManaContainer.addSubviews(abilityManaIcon, abilityMana)
        addSubviews(abilityImage, abilityManaContainer, abilityName, abilityDesc, abilityStatsStack)
        
        NSLayoutConstraint.activate([
            abilityManaIcon.heightAnchor.constraint(equalToConstant: 12),
            abilityManaIcon.widthAnchor.constraint(equalTo: abilityManaIcon.heightAnchor),
            abilityManaIcon.topAnchor.constraint(equalTo: abilityManaContainer.topAnchor),
            abilityManaIcon.leadingAnchor.constraint(equalTo: abilityManaContainer.leadingAnchor),
            abilityManaIcon.bottomAnchor.constraint(equalTo: abilityManaContainer.bottomAnchor),
            
            abilityMana.topAnchor.constraint(equalTo: abilityManaContainer.topAnchor),
            abilityMana.leadingAnchor.constraint(equalTo: abilityManaIcon.trailingAnchor, constant: 2),
            abilityMana.trailingAnchor.constraint(equalTo: abilityManaContainer.trailingAnchor),
            abilityMana.bottomAnchor.constraint(equalTo: abilityManaContainer.bottomAnchor),
            
            abilityImage.heightAnchor.constraint(equalToConstant: 50),
            abilityImage.widthAnchor.constraint(equalTo: abilityImage.heightAnchor),
            abilityImage.topAnchor.constraint(equalTo: topAnchor),
            abilityImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            abilityManaContainer.bottomAnchor.constraint(equalTo: abilityImage.bottomAnchor, constant: -2),
            abilityManaContainer.leadingAnchor.constraint(equalTo: abilityName.leadingAnchor),
            
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
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
