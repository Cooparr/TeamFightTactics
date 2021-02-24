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
enum TierRating: Int, Decodable, CaseIterable {
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
    
    
    func setTierCharAndColor(for tierLabel: UILabel) {
        switch self {
        case .sTier:
            tierLabel.text = "S"
            tierLabel.backgroundColor = TierRatingColor.sTier
        case .aTier:
            tierLabel.text = "A"
            tierLabel.backgroundColor = TierRatingColor.aTier
        case .bTier:
            tierLabel.text = "B"
            tierLabel.backgroundColor = TierRatingColor.bTier
        case .cTier:
            tierLabel.text = "C"
            tierLabel.backgroundColor = TierRatingColor.cTier
        case .dTier:
            tierLabel.text = "D"
            tierLabel.backgroundColor = TierRatingColor.dTier
        default:
            tierLabel.text = "E"
            tierLabel.backgroundColor = TierRatingColor.eTier
        }
    }
}


//MARK:- SynergyRank
enum SynergyRank: Int, Codable {
    
    #warning("feel like this so be changed, 1) to include chosen as a rank, 2) flip numbers other way around to future proof e.g other = 0, bronze = 1, silver = 2.. chosen = 4")
    case chromatic = -1
    case gold = 0
    case silver
    case bronze
    case unranked
    
    init(fromRawValue: Int) {
        self = SynergyRank(rawValue: fromRawValue) ?? .unranked
    }
    
    func setRankColor(_ choosen: Bool? = nil) -> UIColor {
        if choosen == true {
            return TraitRatingColor.chosen
        } else {
            switch self {
            case .chromatic:
                #warning("should be rainbow, no?")
                return .systemRed
            case .gold:
                return TraitRatingColor.gold
            case .silver:
                return TraitRatingColor.silver
            case .bronze:
                return TraitRatingColor.bronze
            case .unranked:
                return TraitRatingColor.other
            }
        }
    }
}


//MARK:- Cost
enum Cost: Int, Codable, Comparable, CaseIterable {
    case one = 1
    case two
    case three
    case four
    case five
    case six
    case seven
    
    static func < (lhs: Cost, rhs: Cost) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}
