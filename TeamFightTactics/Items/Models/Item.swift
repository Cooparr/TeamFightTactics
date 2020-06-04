//
//  Item.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 04/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import Foundation

//FIXME: stats currently does not parse
struct Item: DictionaryInitialize {
    
    let id, tier: Int
    let name, description: String
    let into: [String]?
    let from: [Int]?
    let stats: [ItemStat]
    
    init(data: [String: Any]) {
        self.id = data["id"] as? Int ?? -1
        self.name = data["name"] as? String ?? ""
        self.description = data["description"] as? String ?? ""
        self.tier = data["tier"] as? Int ?? -1
        self.into = data["into"] as? [String]
        self.from = data["from"] as? [Int]
        self.stats = data["stats"] as? [ItemStat] ?? [ItemStat(data: ["" : ""])]
        
        
        print("\nid:", self.id)
        print("name:", self.name)
        print("desc:", self.description)
        print("tier:", self.tier)
        print("into:", self.into as Any)
        print("from:", self.from as Any)
        print("stats:", self.stats)
    }
}


struct ItemStat {
    
    let name, value: String
    
    init(data: [String: String]) {
        self.name = data["name"] ?? ""
        self.value = data["value"] ?? ""
    }
    
}
