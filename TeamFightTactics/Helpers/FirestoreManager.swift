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

class FireStoreManager {
    
    var allChampions = [Champion]()
    
    
//    func getChampions(_ onCompletion: @escaping ([Champion]) -> Void) {
//        Firestore.firestore().champions(fromSet: "Set1").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents:", err)
//            }
//
//            var objects = [Champion]()
//            guard let documents = querySnapshot?.documents else { return }
//            for document in documents {
//                let champ = Champion(data: document.data())
//                objects.append(champ)
//            }
//            onCompletion(objects)
//        }
//    }
    
    
    func getChampionsTester(_ onCompletion: @escaping () -> Void) {
        print("Fetching Champions")
        Firestore.firestore().champions(fromSet: "Set1").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents:", err)
            }
            
            guard let documents = querySnapshot?.documents else { return }
            for document in documents {
                let champ = Champion(data: document.data())
                self.allChampions.append(champ)
            }
            self.allChampions.sort(by: {$1.cost < $0.cost})
            onCompletion()
        }
    }
    
    
    init() {
        print("Firestore Manager: ✌️")
    }
    
    deinit {
        print("Firestore Manager: 👋")
    }
}


extension Firestore {
    func champions(fromSet set: String) -> CollectionReference {
        return self.collection("Development/\(set)/Champions")
    }
    
    func teamComps(fromSet set: String) -> CollectionReference {
      return self.collection("Development/\(set)/TeamCompositions")
    }    
}
