//
//  FirestoreManager.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 10/09/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import Firebase

//MARK:- Dictionary Init Protocol
protocol DictionaryInitialize {
    init(data: [String: Any])
}


//MARK:- Firestore Manager
class FirestoreManager {
    
    
    //MARK: Init & Deinit
    init() {
        print("Firestore Manager: ✌️")
    }
    
    deinit {
        print("Firestore Manager: 👋")
    }
    
    
    //MARK:- Firestore Fetch Generic
    func fetchFirestoreData<T: DictionaryInitialize>(from set: String, in collection: String, _ onCompletion: @escaping ([T]) -> ()) {
        Firestore.firestore().fetchDocuments(from: set, in: collection).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Failed to fetch data:", err)
                onCompletion([])
                return
            }

            var allObjs = [T]()
            guard let documents = querySnapshot?.documents else { return }
            for document in documents {
                let obj = T.init(data: document.data())
                allObjs.append(obj)
            }
            
            onCompletion(allObjs)
        }
    }
}


//MARK:- Firestore Extension
extension Firestore {
    func fetchDocuments(from set: String, in collection: String) -> CollectionReference {
        return self.collection("Development/\(set)/\(collection)")
    }
}
