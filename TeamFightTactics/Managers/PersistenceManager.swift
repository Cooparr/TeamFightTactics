//
//  PersistenceManager.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 06/12/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import Foundation

//MARK: Persistence Manager Error
enum PersistenceManagerError: String, Error {
    case failedToCreateTeamCompFile = "Failed to create custom team composition file."
    case failedToCreateFileURL = "An error occured when creating "
    case failedToSaveTeamComp = "Error when trying to save team composition. Please try again."
    case failedToRetrieveTeamComps = "Error when trying to retrieve team composition. Please try again."
    case failedToUpdateTeamComp = "Error occured when trying to update team composition."
    case failedToDeleteTeamComp = "Error occured when trying to delete the follwoing team composition: "
    case failedToDeleteAllTeamComps = "Error when trying to delete all team compositions."
    case teamCompNotFound = "The required team composition was not found."
    case noTeamNameProvided = "Please give your team compostiion a name."
    case nonUniqueTeamName = "You've already created a team comp with that name."
    case minimumChampionsNotMet = "Your team comp must include at least three champions."
    case nonUniqueChampionsInTeamComp = "A team comp with these exact champions already exists."
}


//MARK: PersistenceManagerError
enum PersistenceManager {
    
    //MARK: Properties
    private static var currentTeamComps = [CustomTeamComposition]()
    private static let fileManager = FileManager.default
    private static var selectedSet: String {
        let setNumber = UserDefaults.standard.double(forKey: UDKey.setKey)
        return "Set" + "\(setNumber)"
    }
    
    
    //MARK: Handler Type Aliases
    typealias CreateHandler     = (Result<Void, PersistenceManagerError>) -> Void
    typealias RetrieveHandler   = (Result<[CustomTeamComposition], PersistenceManagerError>) -> Void
    typealias UpdateHandler     = (Result<Void, PersistenceManagerError>) -> Void
    typealias DeleteHandler     = (Result<Void, PersistenceManagerError>) -> Void

    
    //MARK:- Create Team Comp
    static func createTeamComp(teamComp: CustomTeamComposition, completed: @escaping CreateHandler) {
        do {
            try validateTeamComp(teamComp)
            currentTeamComps.append(teamComp)
            try JSONEncoder().encode(currentTeamComps).write(to: getFileURL(), options: .atomicWrite)
            completed(.success(()))
        } catch let error {
            guard let error = error as? PersistenceManagerError else { return completed(.failure(.failedToSaveTeamComp)) }
            completed(.failure(error))
        }
    }
    
    
    //MARK:- Retrieve Team Comps
    static func retrieveTeamComps(completed: @escaping RetrieveHandler) {
        do {
            let data = try Data(contentsOf: getFileURL())
            let teamCompObjs = try JSONDecoder().decode([CustomTeamComposition].self, from: data)
            self.currentTeamComps = teamCompObjs
            completed(.success(teamCompObjs))
        } catch {
            guard !fileDoesntExistYet() else {
                self.currentTeamComps.removeAll()
                return completed(.success([]))
            }
            completed(.failure(.failedToRetrieveTeamComps))
        }
    }
    
    
    //MARK:- Update Existing Team Comp
    static func updateExistingTeamComp(teamComp: CustomTeamComposition, completed: @escaping UpdateHandler) {
        do {
            try validateTeamComp(teamComp)
            guard let index = self.currentTeamComps.firstIndex(where: { $0.uuid == teamComp.uuid }) else { return completed(.failure(.teamCompNotFound)) }
            self.currentTeamComps[index] = teamComp
            try JSONEncoder().encode(currentTeamComps).write(to: getFileURL(), options: .atomicWrite)
            completed(.success(()))
        } catch let error {
            guard let error = error as? PersistenceManagerError else { return completed(.failure(.failedToUpdateTeamComp)) }
            completed(.failure(error))
        }
    }
    
    
    //MARK:- Delete Single Team Comp
    static func deleteSingleTeamComp(teamComp: CustomTeamComposition, completed: @escaping DeleteHandler) {
        do {
            guard self.currentTeamComps.contains(teamComp) else { return completed(.failure(.teamCompNotFound)) }
            currentTeamComps.removeAll { $0 == teamComp }
            try JSONEncoder().encode(currentTeamComps).write(to: getFileURL(), options: .atomicWrite)
            completed(.success(()))
        } catch {
            completed(.failure(.failedToDeleteTeamComp))
        }
    }
    
    
    //MARK: Delete All Team Comps
    static func deleteAllTeamComps(completed: @escaping DeleteHandler) {
        do {
            currentTeamComps.removeAll()
            try JSONEncoder().encode(currentTeamComps).write(to: getFileURL(), options: .atomicWrite)
            completed(.success(()))
        } catch {
            completed(.failure(.failedToDeleteAllTeamComps))
        }
    }
    
    
    //MARK:- Create File URL
    private static func getFileURL() throws -> URL {
        do {
            let documentDirectory = try FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent(selectedSet + "UserCreatedTeamComps").appendingPathExtension("json")
            return fileUrl
        } catch {
            throw PersistenceManagerError.failedToCreateFileURL
        }
    }
    
    
    //MARK: Team Comp File Doesnt Exist
    private static func fileDoesntExistYet() -> Bool {
        guard let fileURLPath = try? getFileURL().path else { return false }
        return !fileManager.fileExists(atPath: fileURLPath)
    }
    
    
    //MARK: Create Team Comp File
    private static func createCustomTeamCompFile() throws {
        do {
            let fileURLPath = try getFileURL().path
            fileManager.createFile(atPath: fileURLPath, contents: nil, attributes: nil)
        } catch {
            throw PersistenceManagerError.failedToCreateTeamCompFile
        }
    }
    
    
    //MARK: Validate Team Comp
    private static func validateTeamComp(_ teamCompToSave: CustomTeamComposition) throws {
        guard !teamCompToSave.title.isEmpty                                                                                        else { throw PersistenceManagerError.noTeamNameProvided }
        guard !currentTeamComps.contains(where: { $0.uuid != teamCompToSave.uuid && $0.title == teamCompToSave.title })            else { throw PersistenceManagerError.nonUniqueTeamName }
        guard !currentTeamComps.contains(where: { $0.uuid != teamCompToSave.uuid && $0.champions == teamCompToSave.champions })    else { throw PersistenceManagerError.nonUniqueChampionsInTeamComp }
        guard teamCompToSave.champions.count >= 3                                                                                  else { throw PersistenceManagerError.minimumChampionsNotMet }
    }
}
