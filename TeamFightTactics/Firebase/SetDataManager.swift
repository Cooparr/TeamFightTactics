//
//  SetDataManager.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 10/09/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

class SetDataManager {

    //MARK: Properties
    private let currentInGameSet = TFTSet.five
    private var selectedSet: TFTSet {
        guard let selectedSet = TFTSet(rawValue: UserDefaults.standard.double(forKey: UDKey.setKey)) else {
            print("Error creating TFTSet value from UserDefaults - Setting to default value")
            return .five
        }

        return selectedSet
    }

    
    //MARK: Get Set Data Collection Reference
    private func getSetDataCollectionReference(_ collection: Collection) -> CollectionReference {
        return Firestore.firestore().collection(Collection.setData.rawValue).document(String(selectedSet.rawValue)).collection(collection.rawValue)
    }
    
    
    //MARK: Fetch Set Data
    func fetchData<FetchedItem: Decodable>(from collection: Collection, _ onCompletion: @escaping (Result<[FetchedItem], Error>) -> Void) -> ListenerRegistration? {
        
        switch selectedSet {
        case .one, .two, .three, .four, .four_5:
            fetchFromLocal(withFileName: collection) { (result: Result<[FetchedItem], Error>) in
                switch result {
                case .success (let localData):
                    onCompletion(.success(localData))
                case .failure (let error):
                    onCompletion(.failure(error))
                }
                
            }
            return nil
            
        case .five:
            let listener = fetchFromFirebase(in: collection) { (result: Result<[FetchedItem], Error>) in
                switch result {
                case .success (let fetchedData):
                    onCompletion(.success(fetchedData))
                case .failure (let error):
                    onCompletion(.failure(error))
                }
            }
            return listener
        }
    }
    

    //MARK: Fetch From Firebase
    private func fetchFromFirebase<FirestoreItem: Decodable>(in collection: Collection, _ onCompletion: @escaping (Result<[FirestoreItem], Error>) -> Void) -> ListenerRegistration {
        let listener = getSetDataCollectionReference(collection).addSnapshotListener { querySnapshot, error in
            if let error = error { return onCompletion(.failure(error)) }
            guard let documents = querySnapshot?.documents else { return onCompletion(.failure(SetDataError.unwrapDocumentsError)) }
            let fetchedData = documents.compactMap { try? $0.data(as: FirestoreItem.self) }
            onCompletion(.success(fetchedData))
        }
        return listener
    }


    //MARK: Fetch From Local
    private func fetchFromLocal<LocalItem: Decodable>(withFileName: Collection, _ onCompletion: @escaping (Result<[LocalItem], Error>) -> Void) {
        guard let path = Bundle.main.path(forResource: withFileName.rawValue, ofType: "json", inDirectory: "/LocalData/\(selectedSet.rawValue)") else { return }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonDecoder = JSONDecoder()
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd, yyyy"
            jsonDecoder.dateDecodingStrategy = .formatted(formatter)
            let localItems = try jsonDecoder.decode([LocalItem].self, from: data)
            onCompletion(.success(localItems))
        } catch {
            onCompletion(.failure(SetDataError.localFetchError))
        }
    }
    
    

    deinit {
        print("Manager was deinit'd")
    }
}


//MARK: Firestore Manager Enums
extension SetDataManager {
    
    enum Collection: String {
        case setData = "SetData"
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


enum SetDataError: String, Error, LocalizedError {
    case unexpectedError = "An unexecpted error has occured."
    case localFetchError = "An error has occured when trying to locally fetch the requested set data."
    case firebaseFetchError = "An error has occured when trying to fetch the requested set data from the server."
    case unwrapDocumentsError = "Error occured when unwrapping snapshot documents."
    
    public var errorDescription: String? {
        return self.rawValue
    }
}
