//
//  Item.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 04/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import Foundation


//MARK:- Item
struct Item: Decodable, Hashable {
    let uuid = UUID()
    let tier: TierRating
    let name, description: String
    let into: [String]?
    let from: [String]?
    let stats: [ItemStat]?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    private enum CodingKeys: String, CodingKey {
        case tier
        case name
        case description
        case into
        case from
        case stats
    }
}


//MARK:- Item Stat
struct ItemStat: Decodable, Hashable {
    let key: StatType?
    let value: String?
    
    enum CodingKeys: String, CodingKey {
        case key = "name"
        case value
    }
}
