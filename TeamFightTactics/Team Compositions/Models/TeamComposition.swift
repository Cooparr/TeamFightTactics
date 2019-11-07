//
//  TeamComposition.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 15/10/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import Foundation

// MARK: - TeamComposition
struct TeamComposition {
    let title: String
    let tier: Int
    let set: [Int]
    let earlyGame, midGame: [String]
    var endGame = [TeamCompositionEndGameChamps]()
    var synergies = [TeamCompositionSynergies]()
    
    init(data: [String: Any]) {
        let title = data["title"] as? String ?? strErr
        let tier = data["tier"] as? Int ?? intErr
        let set = data["set"] as? [Int] ?? [intErr]
        let earlyGame = data["earlyGame"] as? [String] ?? [strErr]
        let midGame = data["midGame"] as? [String] ?? [strErr]
        let endGame = data["endGame"] as? [[String: Any]] ?? [[strErr: strErr]]
        let synergies = data["synergies"] as? [[String: Any]] ?? [[strErr: strErr]]
        
        
        self.title = title
        self.tier = tier
        self.set = set
        self.earlyGame = earlyGame
        self.midGame = midGame
        
        endGame.forEach { (champ) in
            self.endGame.append(TeamCompositionEndGameChamps(data: champ))
        }

        synergies.forEach { (synergy) in
            self.synergies.append(TeamCompositionSynergies(data: synergy))
        }
    }
    
    enum TFTSet: Int {
        case one = 1
        case two
        case three
    }
}

struct TeamCompositionEndGameChamps {
    let name: String
    let position: Int
    let items: [String]?
    
    init(data: [String: Any]) {
        let name = data["name"] as? String ?? strErr
        let position = data["position"] as? Int ?? intErr
        let items = data["items"] as? [String]
        
        self.name = name
        self.position = position
        self.items = items
    }
}

struct TeamCompositionSynergies {
    var name, rank: String
    var count: Int

    init(data: [String: Any]) {
            let name = data["name"] as? String ?? strErr
            let rank = data["rank"] as? String ?? strErr
            let count = data["count"] as? Int ?? intErr

            self.name = name
            self.rank = rank
            self.count = count
    }
}
