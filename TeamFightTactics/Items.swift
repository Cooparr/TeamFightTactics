//
//  Items.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 22/07/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import Foundation

// MARK: - ItemsValue
struct ItemsValue: Decodable {
    let key, name: String
    let type: TypeEnum
    let bonus: String
    let tier, depth: Int
    let stats: [Stat]?
    let kind: Kind
    let buildsInto: [String]?
    let champs: [Champ]
    let buildsFrom: [BuildsFrom]?
}

enum BuildsFrom: String, Decodable {
    case bfsword = "bfsword"
    case chainvest = "chainvest"
    case giantsbelt = "giantsbelt"
    case needlesslylargerod = "needlesslylargerod"
    case negatroncloak = "negatroncloak"
    case recurvebow = "recurvebow"
    case spatula = "spatula"
    case tearofthegoddess = "tearofthegoddess"
}

enum Champ: String, Decodable {
    case ashe = "Ashe"
    case yasuo = "Yasuo"
    case zed = "Zed"
}

enum Kind: String, Decodable {
    case advanced = "advanced"
    case basic = "basic"
}

// MARK: - Stat
struct Stat: Decodable {
    let name: String?
    let title: String
    let amount: String?
}

enum TypeEnum: String, Decodable {
    case defensive = "Defensive"
    case offensive = "Offensive"
    case utility = "Utility"
}

typealias Items = [String: ItemsValue]
