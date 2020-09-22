//
//  Enums.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 13/11/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import Foundation
import UIKit

//MARK:- TierRating
enum TierRating: Int, Decodable {
    case sTier = 0
    case aTier
    case bTier
    case cTier
    case dTier
    case errorTier
    
    init(fromRawValue: Int) {
        self = TierRating(rawValue: fromRawValue) ?? .errorTier
    }
    
    func setTierTextAndColor(for tierLabel: UILabel) {
        switch self {
        case .sTier:
            tierLabel.text = "S Tier"
            tierLabel.backgroundColor = TierRatingColor.sTier
        case .aTier:
            tierLabel.text = "A Tier"
            tierLabel.backgroundColor = TierRatingColor.aTier
        case .bTier:
            tierLabel.text = "B Tier"
            tierLabel.backgroundColor = TierRatingColor.bTier
        case .cTier:
            tierLabel.text = "C Tier"
            tierLabel.backgroundColor = TierRatingColor.cTier
        case .dTier:
            tierLabel.text = "D Tier"
            tierLabel.backgroundColor = TierRatingColor.dTier
        default:
            tierLabel.text = "E Tier"
            tierLabel.backgroundColor = TierRatingColor.eTier
        }
    }    
}


//MARK:- SynergyRank
enum SynergyRank: Int, Decodable {
    case gold = 0
    case silver
    case bronze
    case other
    
    init(fromRawValue: Int) {
        self = SynergyRank(rawValue: fromRawValue) ?? .other
    }
    
    func setRankColor(_ choosen: Bool? = nil) -> UIColor {
        if choosen == true {
            return TraitRatingColor.chosen
        } else {
            switch self {
            case .gold:
                return TraitRatingColor.gold
            case .silver:
                return TraitRatingColor.silver
            case .bronze:
                return TraitRatingColor.bronze
            case .other:
                return TraitRatingColor.other
            }
        }
    }
}
