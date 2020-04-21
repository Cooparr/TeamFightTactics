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
    let earlyGame, midGame: [String]
    var endGame: [TeamCompositionEndGameChamps] = [TeamCompositionEndGameChamps]()
    var synergies: [TeamCompositionSynergies] = [TeamCompositionSynergies]()
    var endGameChampObjs: [Champion]
    var allChampObjs: [Champion]
    
    init(data: [String: Any]) {
        let title = data["title"] as? String ?? ""
        let tier = data["tier"] as? Int ?? -1
        let earlyGame = data["earlyGame"] as? [String] ?? [""]
        let midGame = data["midGame"] as? [String] ?? [""]
        let endGame = data["endGame"] as? [[String: Any]] ?? [["": ""]]
        let synergies = data["synergies"] as? [[String: Any]] ?? [["": ""]]
        let endGameChampObjs = [Champion]()
        let allChampObjs = [Champion]()
        
        self.title = title
        self.tier = TierRating(fromRawValue: tier)
        self.earlyGame = earlyGame
        self.midGame = midGame
        self.endGameChampObjs = endGameChampObjs
        self.allChampObjs = allChampObjs
        
        endGame.forEach { (champ) in
            self.endGame.append(TeamCompositionEndGameChamps(data: champ))
        }

        synergies.forEach { (synergy) in
            self.synergies.append(TeamCompositionSynergies(data: synergy))
        }
    }    
}

// MARK: - TC End Game Champs
struct TeamCompositionEndGameChamps {
    let name: String
    let position: Int
    let items: [String]?
    
    init(data: [String: Any]) {
        let name = data["name"] as? String ?? ""
        let position = data["position"] as? Int ?? -1
        let items = data["items"] as? [String]
        
        self.name = name
        self.position = position
        self.items = items
    }
}

// MARK: - TC Synergies
struct TeamCompositionSynergies: Equatable {
    var name: String
    var count: Int
    var rank: SynergyRank

    init(data: [String: Any]) {
            let name = data["name"] as? String ?? ""
            let rank = data["rank"] as? Int ?? -1
            let count = data["count"] as? Int ?? -1

            self.name = name
            self.rank = SynergyRank(fromRawValue: rank)
            self.count = count
    }
}
