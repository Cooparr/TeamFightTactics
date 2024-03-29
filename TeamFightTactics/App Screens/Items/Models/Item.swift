//
//  Item.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 04/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import Foundation

protocol TierRated {
    var tier: TierRating { get }
}

//MARK:- Item
struct Item: Decodable, Hashable, TierRated {
    let tier: TierRating
    let name, description: String
    let into: [String]?
    let from: [String]?
    let stats: [ItemStat]?
    let isShadow: Bool
    let isRadiant: Bool?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(tier)
        hasher.combine(name)
        hasher.combine(description)
        hasher.combine(into)
        hasher.combine(from)
        hasher.combine(stats)
        hasher.combine(isShadow)
        hasher.combine(isRadiant)
    }
}


//MARK:- Item Stat
struct ItemStat: Decodable, Hashable {
    let key: StatType?
    let value: String?
    
    private enum CodingKeys: String, CodingKey {
        case key = "name"
        case value
    }
    
    enum StatType: String, Decodable {
        case attDmg = "ad"
        case attSpd = "as"
        case armor = "ar"
        case health = "hp"
        case abilityPower = "ap"
        case magicResist = "mr"
        case critChance = "cr"
        case dodgeChance = "dg"
        case mana = "mana"
        case range = "rg"
        
        init?(rawString: String) {
            switch rawString {
            case "ad": self = .attDmg
            case "as": self = .attSpd
            case "ar": self = .armor
            case "hp": self = .health
            case "ap": self = .abilityPower
            case "mr": self = .magicResist
            case "cr": self = .critChance
            case "dg": self = .dodgeChance
            case "mana": self = .mana
            case "rg": self = .range
            default: return nil
            }
        }
    }
}
