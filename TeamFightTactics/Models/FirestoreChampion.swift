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
    let ability: FirestoreAbility
//    let stats: FirestoreStats
    let items: [String]
    
    init?(data: [String: Any]) {
        guard
            let id = data["id"] as? String,
            let key = data["key"] as? String,
            let name = data["name"] as? String,
            let champOrigin = data["origin"] as? [String],
            let champClass = data["class"] as? [String],
            let cost = data["cost"]  as? Int,
            let ability = data["ability"] as? [String: Any],
            let items = data["items"] as? [String]
            else { return nil }
        guard let abilityUnwrap = FirestoreAbility(data: ability) else { return nil }

        self.id = id
        self.key = key
        self.name = name
        self.champOrigin = champOrigin
        self.champClass = champClass
        self.cost = cost
        self.ability = abilityUnwrap
        self.items = items
    }
}

// MARK: - FirestoreAbility
struct FirestoreAbility {
    let name: String
    let abilityDescription: String
    let type: TypeEnum
    let manaCost, manaStart: Int
    let stats: [FirestoreAbilityStat]

    init?(data: [String: Any]) {
        guard
            let name = data["name"] as? String,
            let abilityDescription = data["description"] as? String,
            let type = data["type"] as? String,
            let abilityStat = data["stat"] as? [String: String]
            else { return nil}
        let manaCost = data["manaCost"] as? Int ?? 0
        let manaStart = data["manaStart"] as? Int ?? 0
        guard let typeUnwrap = TypeEnum(string: type) else { return nil }
        guard let abilityStatUnwrap = FirestoreAbilityStat(data: abilityStat) else { return nil }

        self.name = name
        self.abilityDescription = abilityDescription
        self.type = typeUnwrap
        self.manaCost = manaCost
        self.manaStart = manaStart
        self.stats = [abilityStatUnwrap]
        
    }
}


// MARK: - Stat
struct FirestoreAbilityStat  {
    let type, value: String

    init?(data: [String: String]) {
        guard
            let type = data["type"],
            let value = data["value"]
            else { return nil }

        self.type = type
        self.value = value
    }
}




// MARK: - Type Enum
enum TypeEnum: String {
    case active = "Active"
    case passive = "Passive"

    init?(string: String) {
        switch string {
        case "Active": self = .active
        case "Passive": self = .passive
        default: return nil
        }
    }
}




//// MARK: - Stats
//struct FirestoreStats {
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
//struct FirestoreDefense {
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
//struct FirestoreOffense {
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
