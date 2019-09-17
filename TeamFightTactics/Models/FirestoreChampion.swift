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
    let name: String
    let origins, classes: [String]
    let cost: Int
    let ability: FirestoreAbility
    let bestItems: [String]
    
    init(data: [String: Any]) {
        let name = data["name"] as? String ?? ""
        let origins = data["origins"] as? [String] ?? []
        let classes = data["classes"] as? [String] ?? []
        let cost = data["cost"]  as? Int ?? -1
        let items = data["bestItems"] as? [String] ?? []
        let ability = FirestoreAbility(data: data["ability"] as? [String : Any] ?? ["":""])
        
        self.name = name
        self.origins = origins
        self.classes = classes
        self.cost = cost
        self.ability = ability
        self.bestItems = items
    }
}

// MARK: - FirestoreAbility
struct FirestoreAbility {
    let name, abilityDescription, type: String
    let manaCost, manaStart: Int
    var abilityStat: [FirestoreAbilityStat] = []
    
    init(data: [String: Any]) {
        let name = data["name"] as? String ?? ""
        let abilityDescription = data["description"] as? String ?? ""
        let type = data["type"] as? String ?? ""
        let abilityStats = data["abilityStats"] as? [String: [Int]] ?? ["":[]]
        let manaCost = data["manaCost"] as? Int ?? 0
        let manaStart = data["manaStart"] as? Int ?? 0
        
        self.name = name
        self.abilityDescription = abilityDescription
        self.type = type
        self.manaCost = manaCost
        self.manaStart = manaStart
        
        abilityStats.forEach { (data) in
            let abStat = FirestoreAbilityStat(data: [data.key: data.value])
            self.abilityStat.append(abStat)
        }
    }
}


// MARK: - Ability Stat

struct FirestoreAbilityStat  {
    var key: String = ""
    var values: [Int] = []
    
    init(data: [String: [Int]]) {
        data.forEach { (key: String, value: [Int]) in
            self.key = key
            self.values = value
        }
    }
}
