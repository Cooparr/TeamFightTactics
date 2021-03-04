//
//  CustomTeamComposition.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 25/11/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import Foundation

//MARK:- Custom Team Composition
struct CustomTeamComposition: Codable, Equatable {
    let title: String
    let champions: [Champion]
    let traits: [Trait]
}
