//
//  TeamComposition.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 15/10/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import Foundation

//MARK:- TeamComposition
class TeamComposition: Decodable {
    let title: String
    let tier: TierRating
    let earlyGame, midGame: [String]
    let endGame: [TCEndGameChamp]
    let synergies: [TCSynergy]
    var endGameChampObjs: [Champion]
    var allChampObjs: [Champion]
    var traitObjs: [Trait]
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.tier = try container.decodeIfPresent(TierRating.self, forKey: .tier) ?? TierRating(fromRawValue: -1)
        self.earlyGame = try container.decodeIfPresent([String].self, forKey: .earlyGame) ?? [""]
        self.midGame = try container.decodeIfPresent([String].self, forKey: .midGame) ?? [""]
        self.endGame = try container.decodeIfPresent([TCEndGameChamp].self, forKey: .endGame) ?? []
        self.synergies = try container.decodeIfPresent([TCSynergy].self, forKey: .synergies) ?? []
        self.endGameChampObjs = [Champion]()
        self.allChampObjs = [Champion]()
        self.traitObjs = [Trait]()
    }
    
    enum CodingKeys: String, CodingKey {
        case title = "name"
        case tier
        case earlyGame
        case midGame = "mid"
        case endGame = "characters"
        case synergies
        case endGameChampObjs
        case allChampObjs
        case traitObjs
    }
}

//MARK:- TC End Game Champs
struct TCEndGameChamp: Decodable {
    let name: String
    let position: Int
    let items: [String]?
}

//MARK:- TC Synergies
struct TCSynergy: Decodable, Equatable {
    var name: String
    var count: Int
    var rank: SynergyRank
}
