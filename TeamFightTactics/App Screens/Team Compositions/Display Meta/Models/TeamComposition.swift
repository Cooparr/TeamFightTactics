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
    var endGameChampObjs = [Champion]()
    var allChampObjs = [Champion]()
    var traitObjs = [Trait]()
}


//MARK:- TC End Game Champs
struct TCEndGameChamp: Decodable {
    let name: String
    let position: Int
    let items: [String]?
    let level: Int?
}


//MARK:- TC Synergies
struct TCSynergy: Decodable, Equatable {
    var name: String
    var count: Int
    var rank: SynergyRank
    var isChosen: Bool?
}


//MARK: Coding Keys
extension TeamComposition {
    private enum CodingKeys: String, CodingKey {
        case title
        case tier
        case earlyGame
        case midGame
        case endGame
        case synergies
    }
}
