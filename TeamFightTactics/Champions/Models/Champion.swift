//
//  Champion.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 11/09/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import Foundation

// MARK: - Champion
struct Champion: DictionaryInitialize, Equatable {
    let key, name, imgURL: String
    let patched: String?
    let origins, classes, bestItems: [String]
    let tier: TierRating
    let cost: Cost
    let ability: ChampionAbility
    let stats: ChampionStats
    
    init(data: [String: Any]) {
        self.key = data["key"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.imgURL = data["imageURL"] as? String ?? ""
        self.origins = data["origins"] as? [String] ?? [""]
        self.classes = data["classes"] as? [String] ?? [""]
        self.cost = Cost(fromRawValue: data["cost"] as? Int ?? -1)
        self.bestItems = data["bestItems"] as? [String] ?? [""]
        self.tier = TierRating(fromRawValue: data["tier"] as? Int ?? -1)
        self.patched = data["patched"] as? String
        self.ability = ChampionAbility(data: data["ability"] as? [String : Any] ?? ["": ""])
        self.stats = ChampionStats(data: data["champStats"] as? [String: Any] ?? ["": ""])
    }
    
    static func == (lhs: Champion, rhs: Champion) -> Bool {
        return lhs.key == rhs.key && lhs.imgURL == rhs.imgURL
    }
}


// MARK: - Champion Stats
struct ChampionStats {
    let attackDamage, health, armor, magicResist, range: Int
    let attackSpeed: Double
    
    init(data: [String: Any]) {
        self.attackDamage = data["attackDamage"] as? Int ?? -1
        self.attackSpeed = data["attackSpeed"] as? Double ?? Double(-1)
        self.range = data["range"] as? Int ?? -1
        self.health = data["health"] as? Int ?? -1
        self.armor = data["armor"] as? Int ?? -1
        self.magicResist = data["magicResist"] as? Int ?? -1
    }
}


// MARK: - Champion Ability
struct ChampionAbility {
    let name, imgURL, abilityDescription: String
    let active: Bool
    let manaCost, manaStart: Int?
    var abilityStat: [AbilityStats] = []
    
    init(data: [String: Any]) {
        self.name = data["name"] as? String ?? ""
        self.imgURL = data["imageURL"] as? String ?? ""
        self.abilityDescription = data["description"] as? String ?? ""
        self.active = data["active"] as? Bool ?? false
        self.manaCost = data["manaCost"] as? Int ?? nil
        self.manaStart = data["manaStart"] as? Int ?? nil
        let abilityStats = data["abilityStats"] as? [String: [Any]] ?? ["":[]]

        abilityStats.forEach { (data) in
            let abStat = AbilityStats(data: [data.key: data.value])
            self.abilityStat.append(abStat)
        }
    }
}


// MARK: - Ability Stat
struct AbilityStats {
    var key: String = ""
    var values: [Any] = []
    
    init(data: [String: [Any]]) {
        data.forEach { (key: String, value: [Any]) in
            self.key = key
            self.values = value
        }
    }
}
