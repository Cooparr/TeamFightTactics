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
    var abilityStats: [FirestoreAbilityStat] = []
    var newAbStat: NewFirestoreAbilityStat = NewFirestoreAbilityStat(data: ["" : []])
    
    init(data: [String: Any]) {
        let name = data["name"] as? String ?? ""
        let abilityDescription = data["description"] as? String ?? ""
        let type = data["type"] as? String ?? ""
        let abilityStats = data["stats"] as? [[String : String]] ?? [[:]]
        let newAbilityStat = data["abilityStats"] as? [String: [Int]] ?? ["":[]]
        let manaCost = data["manaCost"] as? Int ?? 0
        let manaStart = data["manaStart"] as? Int ?? 0
        
        self.name = name
        self.abilityDescription = abilityDescription
        self.type = type
        self.manaCost = manaCost
        self.manaStart = manaStart
        
        newAbilityStat.forEach { (data) in
            let test = NewFirestoreAbilityStat(data: [data.key: data.value])
            self.newAbStat = test
        }
        
        abilityStats.forEach { data in
            data.forEach({ (type, value) in
                let abilityStat = FirestoreAbilityStat(data: [type : value])
                self.abilityStats.append(abilityStat)
            })
        }
    }
}


// MARK: - Stat
struct FirestoreAbilityStat  {
    let type, value: String
    
    init(data: [String : String]) {
        let type = data["type"] ?? ""
        let value = data["value"] ?? ""
        
        self.type = type
        self.value = value
    }
}


struct NewFirestoreAbilityStat  {
    
    var key: String = ""
    var values: [Int] = []
    
    init(data: [String: [Int]]) {
        data.forEach { (key: String, value: [Int]) in
            self.key = key
            self.values = value
        }
    }
}
