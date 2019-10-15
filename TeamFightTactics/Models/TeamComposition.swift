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
    let earlyGame, midGame, lateGame: [String]
    let synergies: [String: Int]
    
    init(data: [String: Any]) {
        let title = data["title"] as? String ?? strErr
        let tier = data["tier"] as? Int ?? intErr
        let earlyGame = data["earlyGame"] as? [String] ?? [strErr]
        let midGame = data["midGame"] as? [String] ?? [strErr]
        let lateGame = data["lateGame"] as? [String] ?? [strErr]
        let synergies = data["synergies"] as? [String: Int] ?? [strErr: intErr]
        
        self.title = title
        self.tier = tier
        self.earlyGame = earlyGame
        self.midGame = midGame
        self.lateGame = lateGame
        self.synergies = synergies
    }
}
