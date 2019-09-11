//
//  FirestoreChampion.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 11/09/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import Foundation

// MARK: - FirestoreChampion
struct FirestoreChampion {
    let id, key, name: String
    let champOrigin, champClass: [String]
    let cost: Int
    var ability: FirestoreAbility
//    let stats: FirestoreStats
//    let items: [String]
    
    init?(data: [String: Any]) {
        guard
            let id = data["id"] as? String,
            let key = data["key"] as? String,
            let name = data["name"] as? String,
            let champOrigin = data["origin"] as? [String],
            let champClass = data["class"] as? [String],
            let cost = data["cost"] as? Int,
            let ability = data["ability"] as? [String: Any]
            else { return nil }
    
        self.id = id
        self.key = key
        self.name = name
        self.champOrigin = champOrigin
        self.champClass = champClass
        self.cost = cost
        guard let abilityUnwrap = FirestoreAbility(data: ability) else { return nil }
        self.ability = abilityUnwrap
    }
}

// MARK: - FirestoreAbility
struct FirestoreAbility {
    var name: String
    init?(data: [String: Any]) {
        guard
            let name = data["name"] as? String
            else { return nil }
        self.name = name
    }
}
//    let abilityDescription: String
//    let type: TypeEnum
//    let manaCost, manaStart: Int?
//    let stats: [FirestoreStat]
//
//    init(name: String, abilityDescription: String, type: TypeEnum, manaCost: Int?, manaStart: Int?, stats: [FirestoreStat]) {
//        self.name = name
//        self.abilityDescription = abilityDescription
//        self.type = type
//        self.manaCost = manaCost
//        self.manaStart = manaStart
//        self.stats = stats
//    }
    
   
    


//// MARK: - Stat
//struct FirestoreStat: Codable {
//    let type, value: String
//
//    init(type: String, value: String) {
//        self.type = type
//        self.value = value
//    }
//}
//
//enum TypeEnum: String, Codable {
//    case active = "Active"
//    case passive = "Passive"
//}

//// MARK: - Stats
//struct FirestoreStats: Codable {
//    let offense: FirestoreOffense
//    let defense: FirestoreDefense
//
//    init(offense: FirestoreOffense, defense: FirestoreDefense) {
//        self.offense = offense
//        self.defense = defense
//    }
//}
//
//// MARK: - FirestoreDefense
//struct FirestoreDefense: Codable {
//    let health, armor, magicResist: Int
//
//    init(health: Int, armor: Int, magicResist: Int) {
//        self.health = health
//        self.armor = armor
//        self.magicResist = magicResist
//    }
//}
//
//// MARK: - FirestoreOffense
//struct FirestoreOffense: Codable {
//    let damage: Int
//    let attackSpeed: Double
//    let dps, range: Int
//
//    init(damage: Int, attackSpeed: Double, dps: Int, range: Int) {
//        self.damage = damage
//        self.attackSpeed = attackSpeed
//        self.dps = dps
//        self.range = range
//    }
//}
