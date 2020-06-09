//
//  Item.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 04/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import Foundation

struct Item: DictionaryInitialize {
    
    let id: Int
    let tier: TierRating
    let name, description, key: String
    let into: [String]?
    let from: [Int]?
    var stats: [ItemStat] = []

    init(data: [String: Any]) {
        self.id = data["id"] as? Int ?? -1
        self.key = data["key"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.description = data["description"] as? String ?? ""
        self.tier = TierRating(fromRawValue: data["tier"] as? Int ?? -1)
        self.into = data["into"] as? [String]
        self.from = data["from"] as? [Int]
        let stats = data["stats"] as? [[String: String]] ?? [["": ""]]
        
        stats.forEach { stat in
            let itemStat = ItemStat(data: stat)
            self.stats.append(itemStat)
        }
    }
}


struct ItemStat {
    
    let name: String
    let value: String

    init(data: [String: String]) {
        self.name = data["name"] ?? ""
        self.value = data["value"] ?? ""
    }
}
