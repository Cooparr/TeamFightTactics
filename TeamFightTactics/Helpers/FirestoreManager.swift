//
//  FirestoreManager.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 10/09/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import Firebase

let strErr = "<<<Error>>>"
let intErr = -999999

struct FirestoreManager {
    static let database = Firestore.firestore()
    
    static let champs = database.collection("Champions")
    static let teamComps = database.collection("TeamCompositions")
}
