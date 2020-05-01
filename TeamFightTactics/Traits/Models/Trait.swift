//
//  Trait.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 24/04/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import Foundation

// MARK: - Trait
struct Trait: DictionaryInitialize {
    let name: String
    let effect: String?
    let tier: Int
    var bonus = [Bonus]()
    
    init(data: [String: Any]) {
        let name = data["name"] as? String ?? ""
        let effect = data["effect"] as? String
        let tier = data["tier"] as? Int ?? -1
        let bonus = data["bonus"] as? [[String: Any]] ?? [["": ""]]
        
        self.name = name
        self.tier = tier
        self.effect = effect
        
        bonus.forEach { (bonus) in
            self.bonus.append(Bonus(data: bonus))
        }
    }
}

// MARK: - Bonus
struct Bonus {
    let count: Int
    let value: String
    
    init(data: [String: Any]) {
        let count = data["count"] as? Int ?? -1
        let value = data["value"] as? String ?? ""
        
        self.count = count
        self.value = value
    }
}
