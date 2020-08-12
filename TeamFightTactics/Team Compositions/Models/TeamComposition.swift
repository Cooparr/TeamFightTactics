//
//  TeamComposition.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 15/10/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import Foundation

// MARK: - TeamComposition
class TeamComposition: DictionaryInitialize {
    let title: String
    let tier: TierRating
    let earlyGame, midGame: [String]
    var endGame = [TCEndGameChamps]()
    var synergies = [TCSynergies]()
    var endGameChampObjs = [Champion]()
    var allChampObjs = [Champion]()
    var traitObjs = [Trait]()
    
    required init(data: [String: Any]) {
        self.title = data["title"] as? String ?? ""
        self.tier = TierRating(fromRawValue: data["tier"] as? Int ?? -1)
        self.earlyGame = data["earlyGame"] as? [String] ?? [""]
        self.midGame = data["midGame"] as? [String] ?? [""]
        let endGame = data["endGame"] as? [[String: Any]] ?? [["": ""]]
        let synergies = data["synergies"] as? [[String: Any]] ?? [["": ""]]
        
        endGame.forEach { (champ) in
            self.endGame.append(TCEndGameChamps(data: champ))
        }

        synergies.forEach { (synergy) in
            self.synergies.append(TCSynergies(data: synergy))
        }
    }
}

// MARK: - TC End Game Champs
struct TCEndGameChamps {
    let name: String
    let position: Int
    let items: [String]?
    
    init(data: [String: Any]) {
        self.name = data["name"] as? String ?? ""
        self.position = data["position"] as? Int ?? -1
        self.items = data["items"] as? [String]
    }
}

// MARK: - TC Synergies
struct TCSynergies: Equatable {
    var name: String
    var count: Int
    var rank: SynergyRank

    init(data: [String: Any]) {
        self.name = data["name"] as? String ?? ""
        self.rank = SynergyRank(fromRawValue: data["rank"] as? Int ?? -1)
        self.count = data["count"] as? Int ?? -1
    }
}
