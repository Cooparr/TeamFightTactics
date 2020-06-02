//
//  Trait.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 24/04/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import Foundation

// MARK: - Trait
struct Trait: DictionaryInitialize, Equatable {
    
    
    let name: String
    let effect: String?
    let tier: TierRating
    var bonuses = [Bonus]()
    
    init(data: [String: Any]) {
        let name = data["name"] as? String ?? ""
        let effect = data["effect"] as? String
        let tier = data["tier"] as? Int ?? -1
        let bonus = data["bonus"] as? [[String: Any]] ?? [["": ""]]
        
        self.name = name
        self.tier = TierRating(fromRawValue: tier)
        self.effect = effect
        
        bonus.forEach { (bonus) in
            self.bonuses.append(Bonus(data: bonus))
        }
    }
    
    static func == (lhs: Trait, rhs: Trait) -> Bool {
        return lhs.name == rhs.name && lhs.effect == rhs.effect
    }
}

// MARK: - Bonus
struct Bonus {
    let count: Int
    let value: String
    let rank: SynergyRank
    
    init(data: [String: Any]) {
        let count = data["count"] as? Int ?? -1
        let value = data["value"] as? String ?? ""
        let rank = data["rank"] as? Int ?? -1
        
        self.count = count
        self.value = value
        self.rank = SynergyRank(fromRawValue: rank)
    }
}
