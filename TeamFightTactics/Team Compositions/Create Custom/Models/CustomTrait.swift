//
//  CustomTrait.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 14/12/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import Foundation

//MARK:- Custom Trait
struct CustomTrait: Codable, Hashable {
    
    //MARK: Properties
    let name: String
    let effect: String?
    var count: Int
    var rank: SynergyRank
    var isChosen: Bool = false
    let bonuses: [Bonus]
    
    
    //MARK:- Equatable Conformance
    static func == (lhs: CustomTrait, rhs: CustomTrait) -> Bool {
        return lhs.name == rhs.name
    }
}

//MARK:- Custom Trait Methods
extension CustomTrait {
    
    //MARK: Update Trait
    mutating func updateTrait(newCount: Int) {
        if self.isChosen {
            self.count = newCount + 1
        } else {
            self.count = newCount
        }
        
        self.setTraitRank(traitCount: newCount)
    }
    
    //MARK: Add Chosen Buff
    mutating func addChosenBuff() {
        self.isChosen = true
        self.count += 1
    }
    
    
    //MARK: Remove Chosen Buff
    mutating func removeChosenBuff() {
        self.isChosen = false
        self.count -= 1
    }
    
    
    //MARK: Set Trait Rank
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
