//
//  FirestoreChampion.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 11/09/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import Foundation

let strErr = "<<<Error>>>"
let intErr = -999999

// MARK: - FirestoreChampion
struct FirestoreChampion {
    let name, patched: String
    let origins, classes, bestItems: [String]
    let cost, tier: Int
    let ability: FirestoreAbility
    let stats: FirestoreStats
    
    init(data: [String: Any]) {
        let name = data["name"] as? String ?? strErr
        let origins = data["origins"] as? [String] ?? [strErr]
        let classes = data["classes"] as? [String] ?? [strErr]
        let cost = data["cost"]  as? Int ?? intErr
        let items = data["bestItems"] as? [String] ?? [strErr]
        let tier = data["tier"] as? Int ?? intErr
        let patched = data["patched"] as? String ?? strErr
        let ability = FirestoreAbility(data: data["ability"] as? [String : Any] ?? [strErr:strErr])
        let stats = FirestoreStats(data: data["champStats"] as? [String: Any] ?? [strErr:strErr])
        
        self.name = name
        self.origins = origins
        self.classes = classes
        self.cost = cost
        self.bestItems = items
        self.tier = tier
        self.patched = patched
        self.ability = ability
        self.stats = stats
    }
}

// MARK: - FirestoreAbility
struct FirestoreAbility {
    let name, abilityDescription: String
    let active: Bool
    let manaCost, manaStart: Int
    var abilityStat: [FirestoreAbilityStat] = []
    
    init(data: [String: Any]) {
        let name = data["name"] as? String ?? strErr
        let abilityDescription = data["description"] as? String ?? strErr
        let active = data["active"] as? Bool ?? false
        let abilityStats = data["abilityStats"] as? [String: [Double]] ?? [strErr:[]]
        let manaCost = data["manaCost"] as? Int ?? intErr
        let manaStart = data["manaStart"] as? Int ?? intErr
        
        self.name = name
        self.abilityDescription = abilityDescription
        self.active = active
        self.manaCost = manaCost
        self.manaStart = manaStart
        
        abilityStats.forEach { (data) in
            let abStat = FirestoreAbilityStat(data: [data.key: data.value])
            self.abilityStat.append(abStat)
        }
    }
}

// MARK: - FirestoreAbility
struct FirestoreStats {
    
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


// MARK: - Ability Stat
struct FirestoreAbilityStat  {
    var key: String = strErr
    var values: [Double] = []
    
    init(data: [String: [Double]]) {
        data.forEach { (key: String, value: [Double]) in
            self.key = key
            self.values = value
        }
    }
}
