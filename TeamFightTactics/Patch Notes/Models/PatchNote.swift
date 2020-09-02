//
//  PatchNoteAgain.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 17/07/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import Foundation

//MARK:- Patch Note
struct PatchNote: Decodable {
    let set: String
    let date: String
    let version: String
    let notes: [PNSection]
}


//MARK:- Patch Note Section
struct PNSection: Decodable {
    let title: String
    let changes: [PNChange]
}


//MARK:- Patch Note Change
struct PNChange: Decodable {
    let title: String?
    let name: String?
    let devNote: String?
    let points: [String]?
}
