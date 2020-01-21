//
//  TeamComposition.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 15/10/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import Foundation

// MARK: - TeamComposition
struct TeamComposition: DictionaryInitialize {
    let title: String
    let tier: TierRating
    let set: [Int]
    let earlyGame, midGame: [String]
    var endGame: [TeamCompositionEndGameChamps] = [TeamCompositionEndGameChamps]()
    var synergies: [TeamCompositionSynergies] = [TeamCompositionSynergies]()
    
    init(data: [String: Any]) {
        let title = data["title"] as? String ?? strErr
        let tier = data["tier"] as? Int ?? intErr
        let set = data["set"] as? [Int] ?? [intErr]
        let earlyGame = data["earlyGame"] as? [String] ?? [strErr]
        let midGame = data["midGame"] as? [String] ?? [strErr]
        let endGame = data["endGame"] as? [[String: Any]] ?? [[strErr: strErr]]
        let synergies = data["synergies"] as? [[String: Any]] ?? [[strErr: strErr]]
        
        
        self.title = title
        self.tier = TierRating(rawValue: tier) ?? .errorTier
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
    var name: String
    var count: Int
    var rank: SynergyRank

    init(data: [String: Any]) {
            let name = data["name"] as? String ?? strErr
            let rank = data["rank"] as? Int ?? intErr
            let count = data["count"] as? Int ?? intErr

            self.name = name
            self.rank = SynergyRank(rawValue: rank) ?? .error
            self.count = count
    }
}
