//
//  TeamComposition.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 15/10/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import Foundation

// MARK:- TeamComposition
struct TeamComposition {
    let title: String
    let tier: Int
    let set: [Int]
    let earlyGame, midGame: [String]
    let endGame: [[String: Any]]
    let synergies: [String: Int]
    
    init(data: [String: Any]) {
        let title = data["title"] as? String ?? strErr
        let tier = data["tier"] as? Int ?? intErr
        let set = data["set"] as? [Int] ?? [intErr]
        let earlyGame = data["earlyGame"] as? [String] ?? [strErr]
        let midGame = data["midGame"] as? [String] ?? [strErr]
        let endGame = data["endGame"] as? [[String: Any]] ?? [[strErr:[]]]
        let synergies = data["synergies"] as? [String: Int] ?? [strErr: intErr]
        
        self.title = title
        self.tier = tier
        self.set = set
        self.earlyGame = earlyGame
        self.midGame = midGame
        self.endGame = endGame
        self.synergies = synergies
    }
}
