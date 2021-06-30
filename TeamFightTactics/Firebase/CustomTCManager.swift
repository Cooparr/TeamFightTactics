//
//  CustomTCManager.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 14/06/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import Firebase

enum CustomTCManager {
    
    //MARK: Properties
    private(set) static var currentTeamComps = [CustomTeamComposition]()
    private static var selectedSet: Double {
        return UserDefaults.standard.double(forKey: UDKey.setKey)
    }
    
    
    //MARK: Handler Type Aliases
    typealias CreateHandler     = (Result<Void, CustomTCManagerError>) -> Void
    typealias RetrieveHandler   = (Result<[CustomTeamComposition], CustomTCManagerError>) -> Void
    typealias UpdateHandler     = (Result<Void, CustomTCManagerError>) -> Void
    typealias DeleteHandler     = (Result<Void, CustomTCManagerError>) -> Void
    
    
    //MARK: Firestore Reference
    private static func getCustomTeamCompsCollectionReference() throws -> CollectionReference  {
        guard let userId = Auth.auth().currentUser?.uid else { throw CustomTCManagerError.failedToGetCurrentUserId }
        return Firestore.firestore().collection(Collection.users.rawValue).document(userId).collection(Collection.customTeamComps.rawValue)
    }
    
    
    //MARK:- Create Team Comp
    static func createTeamComp(teamComp: CustomTeamComposition?, completed: @escaping CreateHandler) {
        do {
            let validTeamComp = try validateTeamComp(teamComp, against: currentTeamComps)
            let documentId = validTeamComp.uuid.uuidString
            try getCustomTeamCompsCollectionReference().document(documentId).setData(from: validTeamComp)
            completed(.success(()))
        } catch let error as CustomTCManagerError {
            completed(.failure(error))
        } catch {
            completed(.failure(.unexpectedError))
        }
    }
    
    
    //MARK: Retrieve Team Comps
    static func retrieveTeamComps(completed: @escaping RetrieveHandler) -> ListenerRegistration? {
        guard let firestoreRef = try? getCustomTeamCompsCollectionReference() else {
            completed(.failure(.failedToGetCollectionReference))
            return nil
        }
        
        #warning(".whereField casues a small memory leak?")
        let listener = firestoreRef.whereField("set", isEqualTo: selectedSet).addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else { return completed(.failure(.failedToUnwrapDocuments)) }

            self.currentTeamComps = documents.compactMap { document in
                return try? document.data(as: CustomTeamComposition.self)
            }
            
            completed(.success(currentTeamComps))
        }
        return listener
    }
    
    
    //MARK: Update Team Comp
    static func updateExistingTeamComp(teamComp: CustomTeamComposition?, completed: @escaping UpdateHandler) {
        do {
            let validTeamComp = try validateTeamComp(teamComp, against: currentTeamComps)
            try getCustomTeamCompsCollectionReference().document(validTeamComp.uuid.uuidString).setData(from: validTeamComp)
            completed(.success(()))
        } catch let error as CustomTCManagerError {
            completed(.failure(error))
        } catch {
            completed(.failure(.unexpectedError))
        }
    }
    
    
    //MARK: Delete Team Comp
    static func deleteSingleTeamComp(teamCompId: UUID, completed: @escaping DeleteHandler) {
        guard let firestoreRef = try? getCustomTeamCompsCollectionReference() else { return completed(.failure(.failedToGetCollectionReference)) }
        
        firestoreRef.document(teamCompId.uuidString).delete() { error in
            guard error == nil else { return completed(.failure(.failedToDeleteTeamComp)) }
            completed(.success(()))
        }
    }
    
    
    //MARK: Validate Team Comp
    static private func validateTeamComp(_ teamCompToSave: CustomTeamComposition?, against existingTeamComps: [CustomTeamComposition]) throws -> CustomTeamComposition {
        guard let teamCompToSave = teamCompToSave                                                                                   else { throw ValidationError.errorUnwrappingTeamComp }
        guard !teamCompToSave.title.isEmpty                                                                                         else { throw ValidationError.noTeamNameProvided }
        guard !existingTeamComps.contains(where: { $0.uuid != teamCompToSave.uuid && $0.title == teamCompToSave.title })            else { throw ValidationError.nonUniqueTeamName }
        guard !existingTeamComps.contains(where: { $0.uuid != teamCompToSave.uuid && $0.champions == teamCompToSave.champions })    else { throw ValidationError.nonUniqueChampionsInTeamComp }
        guard teamCompToSave.champions.count >= GameRestraints.minimumChampsPerTeam                                                 else { throw ValidationError.minimumChampionsNotMet }
        return teamCompToSave
    }
}

//MARK: Persistence Manager Errors
extension CustomTCManager {
    
    enum Collection: String {
        case users = "Users"
        case customTeamComps = "CustomTeamComps"
    }
    
    enum CustomTCManagerError: String, Error {
        case failedToGetCurrentUserId = "Error thrown when trying to get the current users ID."
        case failedToGetCollectionReference = "Error throw when trying to return collecetion reference to users custom team comps."
        case failedToUnwrapDocuments = "Error thrown when trying to safely unwrap the documents from a query snapshot."
        case failedToCreateTeamComp = "Error thrown when trying to save team composition."
        case failedToRetrieveTeamComps = "Error thrown when trying to get users custom team composition."
        case failedToUpdateTeamComp = "Error thrown when trying to update team composition."
        case failedToDeleteTeamComp = "Error thrown when trying to delete the following team composition: "
        case unexpectedError = "An unexecpted error has occured."
    }
    
    enum ValidationError: String, Error {
        case noTeamNameProvided = "Please give your team compostiion a name."
        case nonUniqueTeamName = "You've already created a team comp with that name."
        case minimumChampionsNotMet = "Your team comp must include at least three champions."
        case nonUniqueChampionsInTeamComp = "A team comp with these exact champions already exists."
        case errorUnwrappingTeamComp = "Error creating desired team comp."
    }
}
