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

extension Firestore {
    func champions(fromSet set: String) -> CollectionReference {
        return self.collection("Development/\(set)/Champions")
    }
    
    func teamComps(fromSet set: String) -> CollectionReference {
      return self.collection("Development/\(set)/TeamCompositions")
    }    
}
