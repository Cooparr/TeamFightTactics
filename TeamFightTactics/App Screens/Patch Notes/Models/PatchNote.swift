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
    let date: Date
    let version: String
    let notes: [PNSection]
    
    
    //MARK: Get Date As String
    func getDateAsString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM, y"
        return dateFormatter.string(from: self.date)
    }
}


//MARK:- Patch Note Section
struct PNSection: Decodable {
    let title: String
    let devNote: String?
    let changes: [PNChange]?
}


//MARK:- Patch Note Change
struct PNChange: Decodable {
    let title: String?
    let name: String?
    let devNote: String?
    let points: [String]?
}
