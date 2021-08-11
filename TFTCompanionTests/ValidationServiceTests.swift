//
//  ValidationServiceTests.swift
//  TFTCompanionTests
//
//  Created by Alexander James Cooper on 11/08/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import XCTest
@testable import TFT_Companion

class ValidationServiceTests: XCTestCase {
    
    //MARK: Properties
    var validationService: ValidationService!
    var sampleExistingTeamComps: [CustomTeamComposition]!
    var sampleTeamComp: CustomTeamComposition!
    
    
    //MARK: Setup with Error
    override func setUpWithError() throws {
        try super.setUpWithError()
        validationService = ValidationService()
        
        
        let testBundle = Bundle(for: type(of: self))
        let url = try XCTUnwrap(testBundle.url(forResource: "TestCustomTeamComps", withExtension: "json"))
        let data = try Data(contentsOf: url, options: .mappedIfSafe)
        sampleExistingTeamComps = try JSONDecoder().decode([CustomTeamComposition].self, from: data)
        sampleTeamComp = sampleExistingTeamComps[0]
    }
    
    
    
    //MARK: Tear Down with Error
    override func tearDownWithError() throws {
        validationService = nil
        sampleExistingTeamComps = nil
        sampleTeamComp = nil
        try super.tearDownWithError()
    }
    
    
    //MARK: Test Error Unwrapping
    func testErrorUnwrappingTeamComp() {
        let expectedError = ValidationService.ValidationError.errorUnwrappingTeamComp
        var thrownError: ValidationService.ValidationError?
        
        XCTAssertThrowsError(try validationService.validateTeamComp(nil, against: sampleExistingTeamComps)) { error in
            thrownError = error as? ValidationService.ValidationError
        }
        XCTAssertEqual(expectedError, thrownError)
    }
    
    
    //MARK: Test Team Comp Error Name
    func testEmptyTeamCompTitle() {
        let teamComp = CustomTeamComposition(set: 5.5, title: "", lastUpdated: Date(), patchNumber: "11.5", champions: [], traits: [])
        let expectedError = ValidationService.ValidationError.noTeamNameProvided
        var thrownError: ValidationService.ValidationError?
        
        XCTAssertThrowsError(try validationService.validateTeamComp(teamComp, against: sampleExistingTeamComps)) { error in
            thrownError = error as? ValidationService.ValidationError
        }
        XCTAssertEqual(expectedError, thrownError)
    }
    
    
    //MARK: Test Non Unique Team Name
    func testNonUniqueTeamName() {
        let teamComp = CustomTeamComposition(set: 5.5, title: sampleTeamComp.title, lastUpdated: Date(), patchNumber: "11.5", champions: [], traits: [])
        let expectedError = ValidationService.ValidationError.nonUniqueTeamName
        var thrownError: ValidationService.ValidationError?
        
        XCTAssertThrowsError(try validationService.validateTeamComp(teamComp, against: sampleExistingTeamComps)) { error in
            thrownError = error as? ValidationService.ValidationError
        }
        XCTAssertEqual(expectedError, thrownError)
    }
    
    
    //MARK: Test Non Unique Champions
    func testNonUniqueChampions() {
        let teamComp = CustomTeamComposition(set: 5.5, title: "Anything", lastUpdated: Date(), patchNumber: "11.5", champions: sampleTeamComp.champions, traits: [])
        let expectedError = ValidationService.ValidationError.nonUniqueChampionsInTeamComp
        var thrownError: ValidationService.ValidationError?
        
        XCTAssertThrowsError(try validationService.validateTeamComp(teamComp, against: sampleExistingTeamComps)) { error in
            thrownError = error as? ValidationService.ValidationError
        }
        XCTAssertEqual(expectedError, thrownError)
    }
    
    
    //MARK: Test Minimum Champs Not Met
    func testMinimumChampionsNotMet() {
        let oneChampion = sampleTeamComp.champions[0]
        let errorTeamComp = CustomTeamComposition(set: 5.5, title: "Anything", lastUpdated: Date(), patchNumber: "11.5", champions: [oneChampion], traits: [])
        let expectedError = ValidationService.ValidationError.minimumChampionsNotMet
        var thrownError: ValidationService.ValidationError?
        
        XCTAssertThrowsError(try validationService.validateTeamComp(errorTeamComp, against: sampleExistingTeamComps)) { error in
            thrownError = error as? ValidationService.ValidationError
        }
        XCTAssertEqual(expectedError, thrownError)
        XCTAssertTrue(sampleTeamComp.champions.count >= GameRestraints.minimumChampsPerTeam)
    }
    
    
    //MARK: Test Returns Valid Team Comp
    func testReturnValidTeamComp() {
        let uniqueChampions = [sampleTeamComp.champions[0], sampleTeamComp.champions[0], sampleTeamComp.champions[1]]
        let validTeamComp = CustomTeamComposition(set: 5.5, title: "Valid Team Comp", lastUpdated: Date(), patchNumber: "11.5", champions: uniqueChampions, traits: [])
        XCTAssertNoThrow(try validationService.validateTeamComp(validTeamComp, against: sampleExistingTeamComps))
    }
    
    
    //MARK: Test Error Descriptions
    func testErrorDescriptions() {
        let noTeamNameProvidedDesc = ValidationService.ValidationError.noTeamNameProvided.errorDescription
        let nonUniqueTeamNameDesc = ValidationService.ValidationError.nonUniqueTeamName.errorDescription
        let minimumChampionsNotMetDesc = ValidationService.ValidationError.minimumChampionsNotMet.errorDescription
        let nonUniqueChampionsInTeamCompDesc = ValidationService.ValidationError.nonUniqueChampionsInTeamComp.errorDescription
        let errorUnwrappingTeamCompDesc = ValidationService.ValidationError.errorUnwrappingTeamComp.errorDescription
        
        XCTAssertEqual(noTeamNameProvidedDesc, "Please give your team composition a name.")
        XCTAssertEqual(nonUniqueTeamNameDesc, "You've already created a team comp with that name.")
        XCTAssertEqual(minimumChampionsNotMetDesc, "Your team comp must include at least three champions.")
        XCTAssertEqual(nonUniqueChampionsInTeamCompDesc, "A team comp with these exact champions already exists.")
        XCTAssertEqual(errorUnwrappingTeamCompDesc, "Error creating desired team comp.")
    }
}
