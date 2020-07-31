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
        self.name = data["name"] as? String ?? ""
        self.effect = data["effect"] as? String
        self.tier = TierRating(fromRawValue: data["tier"] as? Int ?? -1)
        let bonus = data["bonus"] as? [[String: Any]] ?? [["": ""]]
        
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
        self.count = data["count"] as? Int ?? -1
        self.value = data["value"] as? String ?? ""
        self.rank = SynergyRank(fromRawValue: data["rank"] as? Int ?? -1)
    }
}
