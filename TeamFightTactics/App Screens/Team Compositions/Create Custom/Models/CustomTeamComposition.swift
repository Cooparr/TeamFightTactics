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
    
    static let maxTeamCompSize = 9
    static let champOccurencesPerTeamComp = 2
    
    private(set) var uuid = UUID()
    var title: String
    var description: String?
    var champions: [Champion]
    var traits: [Trait]
    
    static func == (lhs: CustomTeamComposition, rhs: CustomTeamComposition) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
