//
//  Item.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 04/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import Foundation

struct Item: DictionaryInitialize, Equatable {
    
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
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        lhs.key == rhs.key && lhs.name == rhs.name
    }
}


struct ItemStat {
    
    let key: StatType?
    let value: String?

    init(data: [String: String]) {
        self.key = StatType(rawString: data["name"] ?? "") ?? nil
        self.value = data["value"]
    }
}
