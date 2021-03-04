//
//  Trait.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 24/04/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import Foundation

//MARK:- Trait
struct Trait: Codable, Hashable {
    let name: String
    let effect: String?
    let tier: TierRating
    let bonuses: [Bonus]

    var count: Int
    var rank: SynergyRank
    var isChosen: Bool
}


//MARK:- Bonus
struct Bonus: Codable, Hashable {
    let count: Int
    let value: String
    let rank: SynergyRank
}


//MARK:- Trait Coding Keys
extension Trait {
    private enum CodingKeys: String, CodingKey {
        case name
        case effect
        case tier
        case bonuses = "bonus"

        case count
        case rank
        case isChosen
    }
}


//MARK:- Decoder Init
extension Trait {
    init(from decoder: Decoder) throws {
        let container       = try decoder.container(keyedBy: CodingKeys.self)
        self.name           = try container.decodeIfPresent(String.self, forKey: .name)         ?? ""
        self.effect         = try container.decodeIfPresent(String.self, forKey: .effect)       ?? ""
        self.tier           = try container.decodeIfPresent(TierRating.self, forKey: .tier)     ?? .errorTier
        self.bonuses        = try container.decodeIfPresent([Bonus].self, forKey: .bonuses)     ?? []
        self.count          = try container.decodeIfPresent(Int.self, forKey: .count)           ?? 0
        self.rank           = try container.decodeIfPresent(SynergyRank.self, forKey: .rank)    ?? .unranked
        self.isChosen       = try container.decodeIfPresent(Bool.self, forKey: .isChosen)       ?? false
    }
}


//MARK:- Equatable Conformance
extension Trait {
    static func == (lhs: Trait, rhs: Trait) -> Bool {
        return lhs.name == rhs.name && lhs.effect == rhs.effect
    }
}


//MARK:- Trait Methods
extension Trait {

    mutating func updateTrait(newCount: Int) {
        if self.isChosen {
            self.count = newCount + 1
        } else {
            self.count = newCount
        }

        self.setTraitRank(traitCount: newCount)
    }


    mutating func addChosenBuff() {
        self.isChosen = true
        self.count += 1
    }


    mutating func removeChosenBuff() {
        self.isChosen = false
        self.count -= 1
    }


    mutating func setTraitRank(traitCount: Int) {
        bonusLoop: for (index, bonus) in self.bonuses.enumerated() {
            // set previous rank if index > 0
            var previousRank: SynergyRank = .unranked
            if index != 0 {
                previousRank = bonuses[index - 1].rank
            }

            // ninja is unique, in that if it doesnt exactly equal the bonus count, you dont get the benefit
            if self.name == "Ninja" && traitCount != bonus.count {
                self.rank = .unranked
            }

            // get max bouns value
            guard let maxBonus = bonuses.last else { break }

            switch traitCount {
            case maxBonus.count...:
                self.rank = maxBonus.rank
                break bonusLoop
            case bonus.count:
                self.rank = bonus.rank
                break bonusLoop
            case ..<bonus.count:
                self.rank = previousRank
                break bonusLoop
            case bonus.count...:
                continue bonusLoop
            default:
                self.rank = .unranked
            }
        }
    }
}
