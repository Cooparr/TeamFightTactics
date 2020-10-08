//
//  Champion.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 11/09/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import Foundation

//MARK:- Champion
struct Champion: Decodable, Equatable {
    let key, name, imgURL, splashImg: String
    let origins, classes, bestItems: [String]
    let tier: TierRating
    let cost: Cost
    let ability: ChampionAbility
    let stats: ChampionStats

    static func == (lhs: Champion, rhs: Champion) -> Bool {
        return lhs.key == rhs.key && lhs.imgURL == rhs.imgURL
    }

    private enum CodingKeys: String, CodingKey {
        case key
        case name
        case imgURL = "imageURL"
        case splashImg = "splashImage"
        case origins
        case classes
        case bestItems
        case tier
        case cost
        case ability
        case stats = "champStats"
    }
    
    enum Cost: Int, Decodable, Comparable {
        case one = 1
        case two
        case three
        case four
        case five
        case six
        case seven
        
        static func < (lhs: Champion.Cost, rhs: Champion.Cost) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }
    }
}


//MARK:- Champion Stats
struct ChampionStats: Decodable {
    let attackDamage, health, armor, magicResist, range: Int
    let attackSpeed: Double
}


//MARK:- Champion Ability
struct ChampionAbility: Decodable {
    let name, imgURL, description: String
    let active: Bool
    let manaCost, manaStart: Int?
    let abilityStat: [String: [SomeValueType]]
    

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.imgURL = try container.decodeIfPresent(String.self, forKey: .imgURL) ?? ""
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.active = try container.decodeIfPresent(Bool.self, forKey: .active) ?? false
        self.manaCost = try container.decodeIfPresent(Int.self, forKey: .manaCost)
        self.manaStart = try container.decodeIfPresent(Int.self, forKey: .manaStart)
        self.abilityStat = try container.decodeIfPresent([String: [SomeValueType]].self, forKey: .abilityStat) ?? ["":[]]
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case name
        case imgURL = "imageURL"
        case description
        case active
        case manaCost
        case manaStart
        case abilityStat = "abilityStats"
    }
    
    
    enum SomeValueType: Decodable {
        case int(Int)
        case string(String)
        case double(Double)
        
        var getValue: Any? {
            switch self {
            case .string(let s):
                return s
            case .int(let i):
                return i
            case .double(let d):
                return d
            }
        }
        
        init(from decoder: Decoder) throws {
            if let int = try? decoder.singleValueContainer().decode(Int.self) {
                self = .int(int)
                return
            }

            if let string = try? decoder.singleValueContainer().decode(String.self) {
                self = .string(string)
                return
            }

            if let double = try? decoder.singleValueContainer().decode(Double.self) {
                self = .double(double)
                return
            }

            throw SomeValueType.missingValue
        }

        private enum SomeValueType: Error {
            case missingValue
        }
    }
}
