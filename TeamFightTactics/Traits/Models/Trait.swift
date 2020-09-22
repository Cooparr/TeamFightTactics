//
//  Trait.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 24/04/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import Foundation

//MARK:- Trait
struct Trait: Decodable, Equatable {
    
    let name: String
    let effect: String?
    let tier: TierRating
    let bonuses: [Bonus]
    
    private enum CodingKeys: String, CodingKey {
        case name
        case effect
        case tier
        case bonuses = "bonus"
    }
    
    static func == (lhs: Trait, rhs: Trait) -> Bool {
        return lhs.name == rhs.name && lhs.effect == rhs.effect
    }
}

//MARK:- Bonus
struct Bonus: Decodable {
    let count: Int
    let value: String
    let rank: SynergyRank
}
