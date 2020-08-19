//
//  DropRate.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 14/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import Foundation

// MARK: - Drop Rate
struct DropRate: DictInit {
    
    let tier: DropRateTier
    let poolValue: Int
    let levelDict: DRLevelValues
    
    init(data: [String: Any]) {
        self.tier = DropRateTier(fromRawValue: data["tier"] as? String ?? "")
        self.poolValue = data["poolValue"] as? Int ?? -1
        self.levelDict = DRLevelValues(data: data["levelValues"] as? [String: String] ?? ["": ""])
    }
}

// MARK: - Drop Rate Level Values
struct DRLevelValues {
    
    let one: String
    let two: String
    let three: String
    let four: String
    let five: String
    let six: String
    let seven: String
    let eight: String
    let nine: String
    
    init(data: [String: String]) {
        self.one = data["one"]  ?? ""
        self.two = data["two"]  ?? ""
        self.three = data["three"] ?? ""
        self.four = data["four"] ?? ""
        self.five = data["five"] ?? ""
        self.six = data["six"] ?? ""
        self.seven = data["seven"] ?? ""
        self.eight = data["eight"] ?? ""
        self.nine = data["nine"] ?? ""
    }
}
