//
//  Items.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 22/07/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import Foundation

// MARK: - ItemsValue
struct ItemsValue: Codable {
    let key, name: String
    let type: ItemsType
    let bonus: String
    let tier, depth: Int
    let stats: [ItemsStat]?
    let kind: Kind
    let buildsInto: [String]?
    let champs: [Champ]
    let buildsFrom: [BuildsFrom]?
}

enum BuildsFrom: String, Codable {
    case bfsword = "bfsword"
    case chainvest = "chainvest"
    case giantsbelt = "giantsbelt"
    case needlesslylargerod = "needlesslylargerod"
    case negatroncloak = "negatroncloak"
    case recurvebow = "recurvebow"
    case spatula = "spatula"
    case tearofthegoddess = "tearofthegoddess"
}

enum Champ: String, Codable {
    case ashe = "Ashe"
    case yasuo = "Yasuo"
    case zed = "Zed"
}

enum Kind: String, Codable {
    case advanced = "advanced"
    case basic = "basic"
}

// MARK: - ItemsStat
struct ItemsStat: Codable {
    let name: String?
    let title: String
    let amount: String?
}

enum ItemsType: String, Codable {
    case defensive = "Defensive"
    case offensive = "Offensive"
    case utility = "Utility"
}

typealias Items = [String: ItemsValue]
