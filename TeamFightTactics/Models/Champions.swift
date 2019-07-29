//
//  Champions.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 26/07/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import Foundation

// MARK: - Champions
struct Champions: Decodable {
    let aatrox, ahri, akali, anivia: ChampionObject
    let ashe, aurelionSol, blitzcrank, brand: ChampionObject
    let braum, chogath, darius, draven: ChampionObject
    let elise, evelynn, fiora, gangplank: ChampionObject
    let garen, gnar, graves, karthus: ChampionObject
    let kassadin, katarina, kayle, kennen: ChampionObject
    let khazix, kindred, leona, lissandra: ChampionObject
    let lucian, lulu, missFortune: ChampionObject
    let mordekaiser: MordekaiserObject
    let morgana, nidalee, poppy, pyke: ChampionObject
    let rekSai, rengar, sejuani, shen: ChampionObject
    let shyvana, swain, tristana, twistedFate: ChampionObject
    let varus, vayne, veigar, volibear: ChampionObject
    let warwick, yasuo, zed: ChampionObject
    
    enum CodingKeys: String, CodingKey {
        case aatrox = "Aatrox"
        case ahri = "Ahri"
        case akali = "Akali"
        case anivia = "Anivia"
        case ashe = "Ashe"
        case aurelionSol = "AurelionSol"
        case blitzcrank = "Blitzcrank"
        case brand = "Brand"
        case braum = "Braum"
        case chogath = "Chogath"
        case darius = "Darius"
        case draven = "Draven"
        case elise = "Elise"
        case evelynn = "Evelynn"
        case fiora = "Fiora"
        case gangplank = "Gangplank"
        case garen = "Garen"
        case gnar = "Gnar"
        case graves = "Graves"
        case karthus = "Karthus"
        case kassadin = "Kassadin"
        case katarina = "Katarina"
        case kayle = "Kayle"
        case kennen = "Kennen"
        case khazix = "Khazix"
        case kindred = "Kindred"
        case leona = "Leona"
        case lissandra = "Lissandra"
        case lucian = "Lucian"
        case lulu = "Lulu"
        case missFortune = "MissFortune"
        case mordekaiser = "Mordekaiser"
        case morgana = "Morgana"
        case nidalee = "Nidalee"
        case poppy = "Poppy"
        case pyke = "Pyke"
        case rekSai = "RekSai"
        case rengar = "Rengar"
        case sejuani = "Sejuani"
        case shen = "Shen"
        case shyvana = "Shyvana"
        case swain = "Swain"
        case tristana = "Tristana"
        case twistedFate = "TwistedFate"
        case varus = "Varus"
        case vayne = "Vayne"
        case veigar = "Veigar"
        case volibear = "Volibear"
        case warwick = "Warwick"
        case yasuo = "Yasuo"
        case zed = "Zed"
    }
}

// MARK: - ChampionObject
struct ChampionObject: Decodable {
    let id, key, name: String
    let origin, championClass: [String]
    let cost: Int
    let ability: ChampionAbility
    let stats: StatsType
    let items: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, key, name, origin
        case championClass = "class"
        case cost, ability, stats, items
    }
}

// MARK: - ChampionAbility
struct ChampionAbility: Decodable {
    let name, abilityDescription: String
    let type: AbilityType
    let manaCost, manaStart: Int?
    let stats: [AbilityStats]
    
    enum CodingKeys: String, CodingKey {
        case name
        case abilityDescription = "description"
        case type, manaCost, manaStart, stats
    }
}

// MARK: - AbilityStats
struct AbilityStats: Decodable {
    let type: String
    let value: String
}

enum AbilityType: String, Decodable {
    case active = "Active"
    case passive = "Passive"
}

// MARK: - StatsType
struct StatsType: Decodable {
    let offense: Offense
    let defense: Defense
}

// MARK: - Defense
struct Defense: Decodable {
    let health, armor, magicResist: Int
}

// MARK: - Offense
struct Offense: Decodable {
    let damage: Int
    let attackSpeed: Double
    let dps, range: Int
}

// MARK: - MordekaiserObject
struct MordekaiserObject: Decodable {
    let id, key, name: String
    let origin, mordekaiserClass: [String]
    let cost: Int
    let ability: MordekaiserAbility
    let stats: StatsType
    let items: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, key, name, origin
        case mordekaiserClass = "class"
        case cost, ability, stats, items
    }
}

// MARK: - MordekaiserAbility
struct MordekaiserAbility: Decodable {
    let name, abilityDescription: String
    let type: AbilityType
    let manaCost, manaStart: Int
    let stats: [MordeAbilityStats]
    
    enum CodingKeys: String, CodingKey {
        case name
        case abilityDescription = "description"
        case type, manaCost, manaStart, stats
    }
}

// MARK: - MordeAbilityStats
struct MordeAbilityStats: Decodable {
    let type: String
    let value: Value
}

enum Value: Decodable {
    case integer(Int)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Value.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Value"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
