//
//  Enums.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 13/11/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import Foundation

enum TFTSet: Int {
    case one = 1
    case two
    case three
}

enum TierRating: Int {
    case sTier = 0
    case aTier
    case bTier
    case cTier
    case dTier
    case errorTier
}

enum SynergyRank: Int {
    case gold = 0
    case silver
    case bronze
    case error
}
