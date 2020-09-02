//
//  DropRate.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 14/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import Foundation

//MARK:- Drop Rate
struct DropRate: Decodable {
    
    let tier: DropRateTier
    let poolValue: Int
    let levelDict: DRLevelValues
    
    enum CodingKeys: String, CodingKey {
        case tier
        case poolValue
        case levelDict = "levelValues"
    }
}

//MARK:- Drop Rate Level Values
struct DRLevelValues: Decodable {
    
    let one: String
    let two: String
    let three: String
    let four: String
    let five: String
    let six: String
    let seven: String
    let eight: String
    let nine: String
}
