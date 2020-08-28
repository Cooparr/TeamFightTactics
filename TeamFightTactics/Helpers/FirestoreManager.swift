//
//  FirestoreManager.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 10/09/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

//MARK:- Dictionary Init Protocol
protocol DictInit {
    init(data: [String: Any])
}


class FirestoreManager {
    
    //MARK: Properties
    var selectedSet: String {
        let setNumber = UserDefaults.standard.integer(forKey: UDKey.setKey)
        return "Set" + "\(setNumber)"
    }
    
    var hasSetChanged: Bool {
        return UserDefaults.standard.bool(forKey: UDKey.hasSetChanged)
    }
    
    
    //MARK: Firestore Reference
    private func firestoreRef(_ collection: FBCollection) -> CollectionReference {
        return Firestore.firestore().collection("\(FBCollection.development.rawValue)/\(selectedSet)/\(collection.rawValue)")
    }
    
    
    func fetchDataDecodable<FBItem: Decodable>(from collection: FBCollection, updateKey: LastUpdateKey, _ onCompletion: @escaping ([FBItem]) -> ()) {
        firestoreRef(collection).getDocuments(source: shouldFetchFromServer(using: updateKey)) { (snapshot, error) in
            guard let documents = snapshot?.documents else {
                print("Decoable fetch data failed:", error?.localizedDescription as Any)
                return onCompletion([])
            }
            
            let fbItems = documents.compactMap { (queryDocSnapshot) -> FBItem? in
                return try? queryDocSnapshot.data(as: FBItem.self)
            }
            onCompletion(fbItems)
        }
        
    }
    
    
    //MARK: Fetch Data
    func fetchData<FBItem: DictInit>(from collection: FBCollection, updateKey: LastUpdateKey, _ onCompletion: @escaping ([FBItem]) -> ()) {
        firestoreRef(collection).getDocuments(source: shouldFetchFromServer(using: updateKey)) { (snapshot, error) in
            if let err = error {
                print("Failed to fetch data:", err.localizedDescription)
                return onCompletion([])
            }
            
            guard let documents = snapshot?.documents else { return }
            let fbItems = documents.map { doc in
                return FBItem.init(data: doc.data())
            }
            
            #warning("Remember to remove this print statement")
            let source = snapshot!.metadata.isFromCache ? "local cache" : "server"
            print("Metadata: Data fetched from \(source)")
            
            
            onCompletion(fbItems)
        }
    }
    
    
    //MARK: Should Fetch From Server
    fileprivate func shouldFetchFromServer(using updateKey: LastUpdateKey) -> FirestoreSource {
        let currentDate = Date()
        let hoursSinceLastFetch = calculateHoursSinceLastFetch(currentDate, updateKey: updateKey)
        let checkpoint = setCheckpointValue(for: updateKey)
        
        if hoursSinceLastFetch > checkpoint || hasSetChanged {
            UserDefaults.standard.set(currentDate, forKey: updateKey.rawValue)
            UserDefaults.standard.set(false, forKey: UDKey.hasSetChanged)
            return .default
        } else {
            return .cache
        }
    }
    
    
    //MARK: Calculate Hours Since Last Fetch
    func calculateHoursSinceLastFetch(_ currentDate: Date, updateKey: LastUpdateKey) -> Int {
        guard let lastRun = UserDefaults.standard.value(forKey: updateKey.rawValue) as? Date else {
            UserDefaults.standard.set(currentDate, forKey: updateKey.rawValue)
            return 0
        }
        return Calendar.current.dateComponents([.hour], from: lastRun, to: currentDate).hour!
    }
    
    
    //MARK: Get Checkpoint Value
    fileprivate func setCheckpointValue(for updateKey: LastUpdateKey) -> AmountOfDays.RawValue {
        switch updateKey {
        case .champs, .items, .teamComps, .traits, .classes, .origins:
            return AmountOfDays.two.rawValue * 24
        case .patchNotes, .dropRates:
            return AmountOfDays.five.rawValue * 24
        }
    }
}


//MARK: Firestore Manager Enums
extension FirestoreManager {
    enum AmountOfDays: Int {
        case one = 1
        case two
        case three
        case four
        case five
        case six
        case seven
    }
    
    enum FBCollection: String {
        case development = "Development"
        case production = "Production"
        case items = "Items"
        case champions = "Champions"
        case teamComps = "TeamCompositions"
        case classes = "Classes"
        case origins = "Origins"
        case dropRates = "DropRates"
        case patchNotes = "PatchNotes"
    }
}
