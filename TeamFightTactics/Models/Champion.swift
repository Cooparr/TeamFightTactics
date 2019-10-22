//
//  Champion.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 11/09/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import Foundation

// MARK: - Champion
struct Champion {
    let key, name, patched: String
    let origins, classes, bestItems: [String]
    let set: [Int]
    let cost, tier: Int
    let ability: ChampionAbility
    let stats: ChampionStats
    
    init(data: [String: Any]) {
        let key = data["key"] as? String ?? strErr
        let name = data["name"] as? String ?? strErr
        let origins = data["origins"] as? [String] ?? [strErr]
        let classes = data["classes"] as? [String] ?? [strErr]
        let cost = data["cost"]  as? Int ?? intErr
        let items = data["bestItems"] as? [String] ?? [strErr]
        let tier = data["tier"] as? Int ?? intErr
        let patched = data["patched"] as? String ?? strErr
        let set = data["set"] as? [Int] ?? [intErr]
        let ability = ChampionAbility(data: data["ability"] as? [String : Any] ?? [strErr:strErr])
        let stats = ChampionStats(data: data["champStats"] as? [String: Any] ?? [strErr:strErr])
        
        self.key = key
        self.name = name
        self.origins = origins
        self.classes = classes
        self.cost = cost
        self.bestItems = items
        self.tier = tier
        self.patched = patched
        self.ability = ability
        self.stats = stats
        self.set = set
    }
    
    enum Set: Int {
        case one = 1
        case two = 2
        case three = 3
    }
}

// MARK: - Champion Stats
struct ChampionStats {
    let attackDamage, health, armor, magicResist, range: Int
    let attackSpeed: Double
    
    init(data: [String: Any]) {
        let attDmg = data["attackDamage"] as? Int ?? intErr
        let attSpd = data["attackSpeed"] as? Double ?? Double(intErr)
        let range = data["range"] as? Int ?? intErr
        let health = data["health"] as? Int ?? intErr
        let armor = data["armor"] as? Int ?? intErr
        let magicResist = data["magicResist"] as? Int ?? intErr
        
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
    let name, abilityDescription: String
    let active: Bool
    let manaCost, manaStart: Int?
    var abilityStat: [AbilityStats] = []
    
    init(data: [String: Any]) {
        let name = data["name"] as? String ?? strErr
        let abilityDescription = data["description"] as? String ?? strErr
        let active = data["active"] as? Bool ?? false
        let abilityStats = data["abilityStats"] as? [String: [Any]] ?? [strErr:[]]
        let manaCost = data["manaCost"] as? Int ?? nil
        let manaStart = data["manaStart"] as? Int ?? nil
        
        self.name = name
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
    var key: String = strErr
    var values: [Any] = []
    
    init(data: [String: [Any]]) {
        data.forEach { (key: String, value: [Any]) in
            self.key = key
            self.values = value
        }
    }
}
