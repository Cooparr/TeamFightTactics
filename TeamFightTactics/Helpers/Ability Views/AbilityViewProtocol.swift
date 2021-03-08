//
//  AbilityViewProtocol.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 04/03/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

//MARK: Protocol
protocol AbilityViewProtocol {
    var abilityName: BaseLabel { get }
    var abilityMana: BaseLabel { get }
    var abilityDesc: BaseLabel { get }
    var abilityManaIcon: IconImageView { get }
    var abilityImage: GenericImageView { get }
}


//MARK: Protocol Methods
extension AbilityViewProtocol {
    
    func configureAbilityView(champAbility: ChampionAbility) {
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
