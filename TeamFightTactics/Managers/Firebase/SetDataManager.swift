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
    
    //MARK: Type Aliases
    typealias FetchDataHandler<FetchedItem> = (Result<[FetchedItem], SetDataError>) -> Void
    typealias FetchResult<FetchedItem> = Result<[FetchedItem], SetDataError>
    
    
    //MARK: Properties
    private var selectedSet = SettingsManager.getDisplayedSet()
    
    
    //MARK: Get Set Data Collection Reference
    private func getSetDataCollectionReference(_ collection: Collection) -> CollectionReference {
        return Firestore.firestore().collection(Collection.setData.rawValue).document(String(selectedSet.rawValue)).collection(collection.rawValue)
    }
    
    
    //MARK: Fetch Set Data
    func fetchData<FetchedItem: Decodable>(from collection: Collection, _ onCompletion: @escaping FetchDataHandler<FetchedItem>) -> ListenerRegistration? {
        switch selectedSet {
        case .one, .two, .three, .four, .four_5, .five:
            fetchFromLocal(withFileName: collection) { (result: FetchResult<FetchedItem>) in
                switch result {
                case .success (let localData):
                    onCompletion(.success(localData))
                case .failure (let error):
                    onCompletion(.failure(error))
                }
                
            }
            return nil
            
        case .latest:
            let listener = fetchFromFirebase(in: collection) { (result: FetchResult<FetchedItem>) in
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
    private func fetchFromFirebase<FirestoreItem: Decodable>(in collection: Collection, _ onCompletion: @escaping FetchDataHandler<FirestoreItem>) -> ListenerRegistration {
        let listener = getSetDataCollectionReference(collection).addSnapshotListener { querySnapshot, error in
            if let error = error {
                print(error)
                return onCompletion(.failure(.firebaseError))
            }
            
            guard let documents = querySnapshot?.documents else { return onCompletion(.failure(.unwrapDocumentsError)) }
            let fetchedData: [FirestoreItem] = documents.compactMap {
                 guard let firetoreItem = try? $0.data(as: FirestoreItem.self) else {
                    print(SetDataError.errorCastingData.rawValue, $0.data())
                    return  nil
                }
                return firetoreItem
            }
            
            onCompletion(.success(fetchedData))
        }
        return listener
    }


    //MARK: Fetch From Local
    private func fetchFromLocal<LocalItem: Decodable>(withFileName: Collection, _ onCompletion: @escaping FetchDataHandler<LocalItem>) {
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
            onCompletion(.failure(.localFetchError))
        }
    }
    
    
    //MARK: Update Current Patch Version
    func updateCurrentPatchVersion() {
        guard let latestSet = TFTSet.allCases.last?.rawValue else { return }
        Firestore.firestore().collection(Collection.setData.rawValue).document(String(latestSet)).collection(Collection.patchNotes.rawValue)
            .order(by: FieldValues.date.rawValue, descending: true).limit(to: 1)
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print(error)
                    return print(SetDataError.firebaseError.rawValue)
                }
                
                guard let patchDoc = querySnapshot?.documents.first else {
                    return print(SetDataError.firstPatchDocError.rawValue)
                }
                guard let currentPatchVersion = patchDoc.get(FieldValues.version.rawValue) as? String else {
                    return print(SetDataError.getPatchVersionError.rawValue)
                }
                
                SettingsManager.setCurrentPatchVersion(to: currentPatchVersion)
        }
    }
}


//MARK: Firestore Manager Enums
extension SetDataManager {
    
    enum Collection: String {
        case setData    = "SetData"
        case items      = "Items"
        case champions  = "Champions"
        case teamComps  = "TeamComps"
        case classes    = "Classes"
        case origins    = "Origins"
        case dropRates  = "DropRates"
        case patchNotes = "PatchNotes"
        case galaxies   = "Galaxies"
    }
    
    enum FieldValues: String {
        case date
        case version
    }
}


enum SetDataError: String, Error, LocalizedError {
    case unexpectedError        = "An unexecpted error has occured."
    case localFetchError        = "An error has occured when trying to locally fetch the requested set data."
    case firebaseError          = "An error was thrown by Cloud Firestore."
    case firebaseFetchError     = "An error has occured when trying to fetch the requested set data from the server."
    case unwrapDocumentsError   = "Error occured when unwrapping snapshot documents."
    case firstPatchDocError     = "Error unwrapping first patch document"
    case getPatchVersionError   = "Error getting 'version' field value from patch document"
    case errorCastingData       = "Error casting the following data: \n"
    
    public var errorDescription: String? {
        return self.rawValue
    }
}
