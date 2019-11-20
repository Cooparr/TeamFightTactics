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
    
    static let development = "Development"
    static let production = "Production"
    static let champions = "Champions"
    static let teamCompositions = "TeamCompositions"
    static let setOne = "Set1"
    static let setTwo = "Set2"
    
    // Root
    static let databaseRoot = Firestore.firestore()
    
    // Dev Production Paths
    static let developmentDatabase = Firestore.firestore().collection(development)
    static let productionDatabase = Firestore.firestore().collection(production)
    
    // Set 1
    static let DevSetOneChamps = developmentDatabase.document(setOne).collection(champions)
    static let DevSetOneTeamComps = developmentDatabase.document(setOne).collection(teamCompositions)
    
    // Set 2
    static let DevSetTwoChamps = developmentDatabase.document(setTwo).collection(champions)
    static let DevSetTwoTeamComps = developmentDatabase.document(setTwo).collection(teamCompositions)

}
