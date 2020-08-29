//
//  PatchNoteAgain.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 17/07/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import Foundation

struct PatchNote: Decodable {
    let set: String
    let date: String
    let version: String
    let notes: [PNSection]
}

struct PNSection: Decodable {
    let title: String
    let changes: [PNChange]
}

struct PNChange: Decodable {
    let title: String?
    let name: String?
    let devNote: String?
    let points: [String]?
}
