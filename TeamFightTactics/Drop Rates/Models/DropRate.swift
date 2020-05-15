//
//  DropRate.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 14/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import Foundation

// MARK: - Drop Rate
struct DropRate: DictionaryInitialize {
    let level: String
    let tierDict: DRTierValues
    
    init(data: [String: Any]) {
        self.level = data["level"] as? String ?? ""
        self.tierDict = DRTierValues(data: data["tierValues"] as? [String: String] ?? ["": ""])
    }
}

// MARK: - Drop Rate Tier Values
struct DRTierValues {
    let one: String
    let two: String
    let three: String
    let four: String
    let five: String
    
    init(data: [String: String]) {
        self.one = data["one"]  ?? ""
        self.two = data["two"]  ?? ""
        self.three = data["three"] ?? ""
        self.four = data["four"] ?? ""
        self.five = data["five"] ?? ""
    }
}
