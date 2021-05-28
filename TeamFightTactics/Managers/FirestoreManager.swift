//
//  FirestoreManager.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 10/09/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

class FirestoreManager {
    
    //MARK: Properties
    var selectedSet: String {
        let setNumber = UserDefaults.standard.double(forKey: UDKey.setKey)
        return "Set" + "\(setNumber)"
    }
    
    
    //MARK: Firestore Reference
    private func firestoreRef(_ collection: Collection) -> CollectionReference {
        return Firestore.firestore().collection("\(Collection.development.rawValue)/\(selectedSet)/\(collection.rawValue)")
    }
    
    
    func fetchSetData<Item: Decodable>(from collection: Collection, updateKey: LastUpdateKey, _ onCompletion: @escaping ([Item]) -> ()) {
        switch selectedSet {
        case "Set1.0", "Set2.0", "Set3.0", "Set4.0":
            fetchFromLocal(withFileName: collection) { localItems in
                onCompletion(localItems)
            }
        default:
            fetchFromFirebase(in: collection, updateKey: updateKey) { fbItems in
                onCompletion(fbItems)
            }
        }
    }
    
    
    fileprivate func fetchFromFirebase<FBItem: Decodable>(in collection: Collection, updateKey: LastUpdateKey, _ onCompletion: @escaping ([FBItem]) -> ()) {
        firestoreRef(collection).getDocuments(source: shouldFetchFromServer(using: updateKey)) { (snapshot, error) in
            guard let documents = snapshot?.documents else { return print("Decodable fetch data failed:", error?.localizedDescription as Any) }
            
            let fbItems = documents.compactMap { (queryDocSnapshot) -> FBItem? in
                return try? queryDocSnapshot.data(as: FBItem.self)
            }
            
            onCompletion(fbItems)
        }
    }
    
    
    
    fileprivate func fetchFromLocal<LocalItem: Decodable>(withFileName: Collection, _ onCompletion: @escaping ([LocalItem]) -> ()) {
        guard let path = Bundle.main.path(forResource: withFileName.rawValue, ofType: "json", inDirectory: "/LocalData/" + selectedSet) else { return }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonDecoder = JSONDecoder()
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd, yyyy"
            jsonDecoder.dateDecodingStrategy = .formatted(formatter)
            let localItems = try jsonDecoder.decode([LocalItem].self, from: data)
            onCompletion(localItems)
        } catch {
            return print("Local fetch error")
        }
    }
    
    //MARK: Should Fetch From Server
    fileprivate func shouldFetchFromServer(using updateKey: LastUpdateKey) -> FirestoreSource {
        let currentDate = Date()
        let hoursSinceLastFetch = calculateHoursSinceLastFetch(currentDate, updateKey: updateKey)
        
        switch hoursSinceLastFetch > getCheckpointValue(for: updateKey) {
        case true:
            UserDefaults.standard.set(currentDate, forKey: updateKey.rawValue)
            return .default
        case false:
            return .cache
        }
    }
    
    
    //MARK: Calculate Hours Since Last Fetch
    func calculateHoursSinceLastFetch(_ currentDate: Date, updateKey: LastUpdateKey) -> Int {
        guard let lastRun = UserDefaults.standard.value(forKey: updateKey.rawValue) as? Date else {
            UserDefaults.standard.set(currentDate, forKey: updateKey.rawValue)
            return AmountOfDays.seven.rawValue * 24
        }
        return Calendar.current.dateComponents([.hour], from: lastRun, to: currentDate).hour!
    }
    
    
    //MARK: Get Checkpoint Value
    fileprivate func getCheckpointValue(for updateKey: LastUpdateKey) -> AmountOfDays.RawValue {
        switch updateKey {
        case .champs, .items, .teamComps, .traits, .classes, .origins:
            return AmountOfDays.two.rawValue * 24
        case .patchNotes, .dropRates, .galaxies:
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
    
    enum Collection: String {
        case development = "Development"
        case production = "Production"
        case items = "Items"
        case champions = "Champions"
        case teamComps = "TeamComps"
        case classes = "Classes"
        case origins = "Origins"
        case dropRates = "DropRates"
        case patchNotes = "PatchNotes"
        case galaxies = "Galaxies"
    }
}
