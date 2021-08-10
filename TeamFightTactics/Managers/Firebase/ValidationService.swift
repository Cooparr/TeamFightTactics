//
//  ValidationService.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 10/08/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import Foundation

struct ValidationService {
    
    //MARK: Validate Team Comp
    func validateTeamComp(_ teamCompToSave: CustomTeamComposition?, against existingTeamComps: [CustomTeamComposition]) throws -> CustomTeamComposition {
        guard let teamCompToSave = teamCompToSave                                                                                   else { throw ValidationError.errorUnwrappingTeamComp }
        guard !teamCompToSave.title.isEmpty                                                                                         else { throw ValidationError.noTeamNameProvided }
        guard !existingTeamComps.contains(where: { $0.uuid != teamCompToSave.uuid && $0.title == teamCompToSave.title })            else { throw ValidationError.nonUniqueTeamName }
        guard !existingTeamComps.contains(where: { $0.uuid != teamCompToSave.uuid && $0.champions == teamCompToSave.champions })    else { throw ValidationError.nonUniqueChampionsInTeamComp }
        guard teamCompToSave.champions.count >= GameRestraints.minimumChampsPerTeam                                                 else { throw ValidationError.minimumChampionsNotMet }
        return teamCompToSave
    }
    
    //MARK: Validation Errors
    enum ValidationError: LocalizedError {
        case noTeamNameProvided
        case nonUniqueTeamName
        case minimumChampionsNotMet
        case nonUniqueChampionsInTeamComp
        case errorUnwrappingTeamComp
        
        
        //MARK: Error Description
        var errorDescription: String? {
            switch self {
            case .noTeamNameProvided:
                return "Please give your team compostiion a name."
            case .nonUniqueTeamName:
                return "You've already created a team comp with that name."
            case .minimumChampionsNotMet:
                return "Your team comp must include at least three champions."
            case .nonUniqueChampionsInTeamComp:
                return "A team comp with these exact champions already exists."
            case .errorUnwrappingTeamComp:
                return "Error creating desired team comp."
            }
        }
    }
}
