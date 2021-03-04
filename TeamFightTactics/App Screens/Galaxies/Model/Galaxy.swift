//
//  Galaxy.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 09/09/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import Foundation

//MARK:- Galaxy
struct Galaxy: Decodable {
    let name, description: String
    let imageName: String?
    let chance: Int?
    let removed: Bool
}
