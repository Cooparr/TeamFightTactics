//
//  PatchNoteAgain.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 17/07/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import Foundation

struct PatchNote: DictInit {
    let set: String
    let date: String
    let version: String
    let notes: [PNSection]


    init(data: [String : Any]) {
        self.set = data["set"] as? String ?? ""
        self.date = data["date"] as? String ?? "Undated"
        self.version = data["version"] as? String ?? ""
        
        let notes = data["notes"] as? [[String: Any]] ?? [["": ""]]
        self.notes =  notes.map { note in
            return PNSection(data: note)
        }
    }
}

struct PNSection {
    let title: String
    let changes: [PNChange]

    init(data: [String: Any]) {
        self.title = data["title"] as? String ?? ""
        
        let changes = data["changes"] as? [[String: Any]] ?? [["": ""]]
        self.changes = changes.map { change in
            return PNChange(data: change)
        }
    }
}

struct PNChange {
    let title: String?
    let name: String?
    let devNote: String?
    let points: [String]?
    
    init(data: [String: Any]) {
        self.title = data["title"] as? String
        self.name = data["name"] as? String
        self.devNote = data["devNote"] as? String
        self.points = data["points"] as? [String]
    }
}
