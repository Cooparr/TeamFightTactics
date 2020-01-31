//
//  Champion.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 11/09/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import Foundation

// MARK: - Champion
struct Champion: DictionaryInitialize {
    let key, name: String
    let patched: String?
    let origins, classes, bestItems: [String]
    let tier: TierRating
    let cost: Int
    let ability: ChampionAbility
    let stats: ChampionStats
    
    init(data: [String: Any]) {
        let key = data["key"] as? String ?? ""
        let name = data["name"] as? String ?? ""
        let origins = data["origins"] as? [String] ?? [""]
        let classes = data["classes"] as? [String] ?? [""]
        let cost = data["cost"]  as? Int ?? -1
        let items = data["bestItems"] as? [String] ?? [""]
        let tier = data["tier"] as? Int ?? -1
        let patched = data["patched"] as? String
        let ability = ChampionAbility(data: data["ability"] as? [String : Any] ?? ["": ""])
        let stats = ChampionStats(data: data["champStats"] as? [String: Any] ?? ["": ""])
        
        self.key = key
        self.name = name
        self.origins = origins
        self.classes = classes
        self.cost = cost
        self.bestItems = items
        self.tier = TierRating(rawValue: tier) ?? .errorTier
        self.patched = patched
        self.ability = ability
        self.stats = stats
    }
}

// MARK: - Champion Stats
struct ChampionStats {
    let attackDamage, health, armor, magicResist, range: Int
    let attackSpeed: Double
    
    init(data: [String: Any]) {
        let attDmg = data["attackDamage"] as? Int ?? -1
        let attSpd = data["attackSpeed"] as? Double ?? Double(-1)
        let range = data["range"] as? Int ?? -1
        let health = data["health"] as? Int ?? -1
        let armor = data["armor"] as? Int ?? -1
        let magicResist = data["magicResist"] as? Int ?? -1
        
        self.attackDamage = attDmg
        self.attackSpeed = attSpd
        self.range = range
        self.health = health
        self.armor = armor
        self.magicResist = magicResist
    }
}

// MARK: - Champion Ability
struct ChampionAbility {
    let name, key, abilityDescription: String
    let active: Bool
    let manaCost, manaStart: Int?
    var abilityStat: [AbilityStats] = []
    
    init(data: [String: Any]) {
        let name = data["name"] as? String ?? ""
        let key = data["key"] as? String ?? ""
        let abilityDescription = data["description"] as? String ?? ""
        let active = data["active"] as? Bool ?? false
        let abilityStats = data["abilityStats"] as? [String: [Any]] ?? ["":[]]
        let manaCost = data["manaCost"] as? Int ?? nil
        let manaStart = data["manaStart"] as? Int ?? nil
        
        self.name = name
        self.key = key
        self.abilityDescription = abilityDescription
        self.active = active
        self.manaCost = manaCost
        self.manaStart = manaStart
        
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
