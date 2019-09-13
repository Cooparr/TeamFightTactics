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
    let items: [String]
    
    init (data: [String: Any]) {
        let id = data["id"] as? String ?? ""
        let key = data["key"] as? String ?? ""
        let name = data["name"] as? String ?? ""
        let champOrigin = data["origin"] as? [String] ?? []
        let champClass = data["class"] as? [String] ?? []
        let cost = data["cost"]  as? Int ?? -1
        let items = data["items"] as? [String] ?? []
        
        let ability = FirestoreAbility(data: data["ability"] as! [String : Any])
        
        self.id = id
        self.key = key
        self.name = name
        self.champOrigin = champOrigin
        self.champClass = champClass
        self.cost = cost
        self.ability = ability
        self.items = items
    }
}

// MARK: - FirestoreAbility
struct FirestoreAbility {
    let name: String
    let abilityDescription: String
    let type: TypeEnum
    let manaCost, manaStart: Int
    var stats: [FirestoreAbilityStat] = []
    
    init (data: [String: Any]) {
        let name = data["name"] as? String ?? ""
        let abilityDescription = data["description"] as? String ?? ""
        let type = data["type"] as? TypeEnum ?? TypeEnum.active
        let abilityStats = data["stats"] as? [String : String]
        let manaCost = data["manaCost"] as? Int ?? 0
        let manaStart = data["manaStart"] as? Int ?? 0
        
        self.name = name
        self.abilityDescription = abilityDescription
        self.type = type
        self.manaCost = manaCost
        self.manaStart = manaStart
        
        abilityStats.forEach { (key, value) in
            let abilityStat = FirestoreAbilityStat(data: [key: value])!
            stats.append(abilityStat)
        }
    }
}


// MARK: - Stat
struct FirestoreAbilityStat  {
    let type, value: String
    
    init(data: [String: String]) {
        let type = data["type"] ?? ""
        let value = data["value"] ?? ""
        
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
