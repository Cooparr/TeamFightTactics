//
//  Item.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 04/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import Foundation

struct Item: DictInit, Hashable {
    let uuid = UUID()
    let tier: TierRating
    let name, key, description : String
    let into: [String]?
    let from: [String]?
    var stats: [ItemStat] = []

    init(data: [String: Any]) {
        self.name = data["name"] as? String ?? ""
        self.key = name.formattedName()
        self.description = data["description"] as? String ?? ""
        self.tier = TierRating(fromRawValue: data["tier"] as? Int ?? -1)
        self.from = data["from"] as? [String]
        self.into = data["into"] as? [String]
        let stats = data["stats"] as? [[String: String]] ?? [["": ""]]
        
        stats.forEach { stat in
            let itemStat = ItemStat(data: stat)
            self.stats.append(itemStat)
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}


struct ItemStat: Hashable {
    let key: StatType?
    let value: String?

    init(data: [String: String]) {
        self.key = StatType(rawString: data["name"] ?? "") ?? nil
        self.value = data["value"] ?? nil
    }
}
