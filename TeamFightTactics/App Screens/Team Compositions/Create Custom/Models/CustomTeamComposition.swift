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
    private(set) var set: Double
    private(set) var uuid = UUID()
    private(set) var title: String
    private(set) var lastUpdated: Date
    private(set) var patchNumber: String
    private(set) var description: String?
    private(set) var champions: [Champion]
    private(set) var traits: [Trait]
    
    static func == (lhs: CustomTeamComposition, rhs: CustomTeamComposition) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
