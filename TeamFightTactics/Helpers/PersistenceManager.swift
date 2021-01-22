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
    case unknownError = "An unexpected error has occured."
    case failedToCreateTeamCompFile = "Failed to create custom team composition file."
    case teamCompFileDoesntExist = "You dont have any team compositions saved to delete."
    case failedToSaveTeamComp = "Error when trying to save team composition. Please try again."
    case failedToRetrieveTeamComps = "Error when trying to retrieve team composition. Please try again."
    case failedToDeleteAllTeamComps = "Error when trying to delete all team compositions."
    case noTeamNameProvided = "Please give your team compostiion a name."
    case nonUniqueTeamName = "You've already created a team comp with that name."
    case noChampionsInTeamComp = "Your team comp must include at least one champion."
    case nonUniqueChampionsInTeamComp = "A team comp with these exact champions already exists."
    case nothingToDelete = "You dont have any custom team compositions to delete."
}


//MARK: Persistence Manager Action
enum PersistenceActionType {
    case add, delete
}


//MARK: PersistenceManagerError
enum PersistenceManager {
    
    //MARK: Properties
    static let fileManager = FileManager.default
    static let fileName = "UserCreatedTeamComps"
    static let pathExtension = "json"
    

    //MARK: Save Teamp Comps
    static func saveTeamComps(teamComps: [CustomTeamComposition]) -> PersistenceManagerError? {
        do {
            let fileURL = try fileManager.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(fileName).appendingPathExtension(pathExtension)
            try JSONEncoder().encode(teamComps).write(to: fileURL)
            return nil
        } catch {
            return .failedToSaveTeamComp
        }
    }
    
    
    //MARK: Retrieve Team Comps
    static func retrieveTeamComps(completed: @escaping (Result<[CustomTeamComposition], PersistenceManagerError>)  -> Void) {
        do {
            let fileURL = try fileManager.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent(fileName).appendingPathExtension(pathExtension)

            let data = try Data(contentsOf: fileURL)
            let teamCompData = try JSONDecoder().decode([CustomTeamComposition].self, from: data)
             completed(.success(teamCompData))
            
        } catch {
            guard !fileDoesntExistYet(fileName: fileName, pathExtension: pathExtension) else { return completed(.success([])) }
            completed(.failure(.failedToRetrieveTeamComps))
        }
    }
    
    
    //MARK: Update Team Comp
    static func updateTeamComp(teamComp: CustomTeamComposition, actionType: PersistenceActionType, completed: @escaping (PersistenceManagerError?) -> Void) {
        retrieveTeamComps { result in
            switch result {
            case .success(var existingTeamComps):
                
                switch actionType {
                case .add:
                    let validResult = Result { try validate(teamComp, against: existingTeamComps) }
                    switch validResult {
                    case .success:
                        existingTeamComps.append(teamComp)
                    case .failure(let error):
                        guard let error = error as? PersistenceManagerError else { return completed(.unknownError) }
                        return completed(error)
                    }
                    
                case .delete:
                    existingTeamComps.removeAll { $0 == teamComp }
                }
                
                completed(saveTeamComps(teamComps: existingTeamComps))
                
            case .failure(let error):
                guard fileDoesntExistYet(fileName: fileName, pathExtension: pathExtension) else { return completed(error) }
                do {
                    try createCustomTeamCompFile()
                    completed(saveTeamComps(teamComps: [teamComp]))
                } catch {
                    guard let error = error as? PersistenceManagerError else { return completed(.unknownError) }
                    completed(error)
                }
            }
        }
    }
    
    
    //MARK: Delete All Team Comps
    static func deleteAllTeamComps(completed: @escaping (PersistenceManagerError?) -> Void) {
        guard !fileDoesntExistYet(fileName: fileName, pathExtension: pathExtension) else { return completed(.teamCompFileDoesntExist) }
        retrieveTeamComps { result in
            switch result {
            case .success(let teamComps):
                if teamComps.isEmpty { return completed(.nothingToDelete) }
                _ = saveTeamComps(teamComps: [])
                completed(nil)
            case .failure:
                completed(.failedToRetrieveTeamComps)
            }
        }
    }
    
    
    
    //MARK: Delete Team Comp File
    static func deleteCustomTeamCompFile(completed: @escaping (PersistenceManagerError?) -> Void) {
        do {
            let documentDirectory = try fileManager.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileUrl = documentDirectory.appendingPathComponent(fileName).appendingPathExtension(pathExtension)
            try fileManager.removeItem(at: fileUrl)
            completed(nil)
        } catch {
            guard let error = error as? PersistenceManagerError else { return completed(.unknownError) }
            completed(error)
        }
    }
    
    
    
    //MARK: Team Comp File Doesnt Exist
    fileprivate static func fileDoesntExistYet(fileName: String, pathExtension: String) -> Bool {
        guard let documentDirectory = try? fileManager.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else { return false }
        let fileURL = documentDirectory.appendingPathComponent(fileName).appendingPathExtension(pathExtension)
        return !fileManager.fileExists(atPath: fileURL.path)
    }
    
    
    //MARK: Create Team Comp File
    fileprivate static func createCustomTeamCompFile() throws {
        do {
            let documentDirectory = try fileManager.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent(fileName).appendingPathExtension(pathExtension)
            fileManager.createFile(atPath: fileUrl.path, contents: nil, attributes: nil)
        } catch {
            throw PersistenceManagerError.failedToCreateTeamCompFile
        }
    }
    
    
    //MARK: Validate Team Comp
    fileprivate static func validate(_ teamCompToSave: CustomTeamComposition, against existingTeamComps: [CustomTeamComposition]) throws {
        guard !teamCompToSave.title.isEmpty                                                     else { throw PersistenceManagerError.noTeamNameProvided }
        guard !existingTeamComps.contains(where: { $0.title == teamCompToSave.title })          else { throw PersistenceManagerError.nonUniqueTeamName }
        guard !teamCompToSave.champions.isEmpty                                                 else { throw PersistenceManagerError.noChampionsInTeamComp }
        guard !existingTeamComps.contains(where: { $0.champions == teamCompToSave.champions })  else { throw PersistenceManagerError.nonUniqueChampionsInTeamComp }
    }
}
