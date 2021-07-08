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
enum TierRating: Int, Codable, CaseIterable {
    case sTier = 1
    case aTier
    case bTier
    case cTier
    case dTier
    case noTier
    
    init(fromRawValue: Int) {
        self = TierRating(rawValue: fromRawValue) ?? .noTier
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
            tierLabel.backgroundColor = TierRatingColor.noTier
        }
    }
}


//MARK:- SynergyRank
enum SynergyRank: Int, Codable {
    
    case unranked = 0
    case bronze
    case silver
    case gold
    case chromatic

    
    init(fromRawValue: Int) {
        self = SynergyRank(rawValue: fromRawValue) ?? .unranked
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
