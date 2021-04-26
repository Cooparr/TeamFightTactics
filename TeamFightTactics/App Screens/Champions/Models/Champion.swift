//
//  Champion.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 11/09/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import Foundation

//MARK:- Champion
struct Champion: Codable, Equatable, TierRated {
    let name, imageURL, splashURL: String
    let origins, classes, bestItems: [String]
    var customItems: [String]?
    let tier: TierRating
    let cost: Cost
    let ability: ChampionAbility
    let stats: ChampionStats
    static let maxNumOfItemsCanHold = 3
    
    
    static func == (lhs: Champion, rhs: Champion) -> Bool {
        return lhs.name == rhs.name && lhs.imageURL == rhs.imageURL
    }
}


//MARK:- Champion Stats
struct ChampionStats: Codable, Equatable {
    let attackDamage, health, armor, magicResist, range: Int
    let attackSpeed: Double
}


//MARK:- Champion Ability
struct ChampionAbility: Codable {
    let name, imageURL, description: String
    let active: Bool
    let manaCost, manaStart: Int?
    let abilityStats: [String: [SomeValueType]]
    

    init(from decoder: Decoder) throws {
        let container       = try decoder.container(keyedBy: CodingKeys.self)
        self.name           = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.imageURL       = try container.decodeIfPresent(String.self, forKey: .imageURL) ?? ""
        self.description    = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.active         = try container.decodeIfPresent(Bool.self, forKey: .active) ?? false
        self.manaCost       = try container.decodeIfPresent(Int.self, forKey: .manaCost)
        self.manaStart      = try container.decodeIfPresent(Int.self, forKey: .manaStart)
        self.abilityStats   = try container.decodeIfPresent([String: [SomeValueType]].self, forKey: .abilityStats) ?? ["":[]]
    }


    private enum CodingKeys: String, CodingKey {
        case name
        case imageURL
        case description
        case active
        case manaCost
        case manaStart
        case abilityStats
    }
    
    
    enum SomeValueType: Codable, Equatable {
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

        
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            
            switch self {
            case .string(let string):
                try container.encode(string)
            case .int(let int):
                try container.encode(int)
            case .double(let double):
                try container.encode(double)
            }
        }
        
        private enum SomeValueType: Error {
            case missingValue
        }
    }
}


//MARK: Champion Methods
extension Champion {
    mutating func addCustomItem(_ itemName: String) {
        guard canAddCustomItem() else { return }
        guard customItems != nil else {
            return self.customItems = [itemName]
        }
        
        self.customItems?.append(itemName)
    }
    
    
    mutating func removeCustomItem(_ itemName: String) {
        guard let itemToRemove = self.customItems?.firstIndex(of: itemName) else { return }
        self.customItems?.remove(at: itemToRemove)
        guard let customItems = self.customItems, !customItems.isEmpty else { return self.customItems = nil }
    }
    
    
    private func canAddCustomItem() -> Bool {
        guard self.customItems != nil else { return true }
        guard let customItems = self.customItems else { return false }
        return customItems.count < 3
    }
}
