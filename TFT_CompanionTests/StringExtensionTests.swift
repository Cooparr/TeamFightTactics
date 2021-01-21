//
//  StringExtensionTests.swift
//  StringExtensionTests
//
//  Created by Alexander James Cooper on 24/11/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import XCTest
@testable import TFT_Companion

class StringExtensionTests: XCTestCase {

    //MARK: Test Properties
    var testChampName: String!
    var defaultSpecialCharacters: String!
    var alternateSpecialCharacters: String!

    
    //MARK: Set Up
    override func setUp() {
        super.setUp()
        testChampName = "Rek'Sai"
        defaultSpecialCharacters = ". ' Special . ' Characters . '"
        alternateSpecialCharacters = "@!#Special@!#Characters#@!"
    }

    
    //MARK: Tear Down
    override func tearDown() {
        testChampName = nil
        defaultSpecialCharacters = nil
        alternateSpecialCharacters = nil
        super.tearDown()
    }
    
    
    //MARK: Test Bullet Point
    func test_bullet_point() {
        // Given
        XCTAssertEqual(String.bulletPoint, "• ")
        
        // When
        let bulletName = String.bulletPoint + testChampName
        
        // Then
        XCTAssertEqual(bulletName, "• Rek'Sai")
    }
    
    
    //MARK: Test Formatting Champ Name
    func test_formating_champ_name() {
        // Given
        XCTAssertEqual(testChampName, "Rek'Sai")
        
        // When
        let formattedName = testChampName.formattedName()
        
        // Then
        XCTAssertEqual(formattedName, "reksai")
        
    }
    
    
    //MARK: Test Formatting Default Special Characters
    func test_formatting_special_characters() {
        // Given
        XCTAssertEqual(defaultSpecialCharacters, ". ' Special . ' Characters . '")
        XCTAssertEqual(alternateSpecialCharacters, "@!#Special@!#Characters#@!")
        
        // When
        let defaultSpecialString = defaultSpecialCharacters.formattedName()
        let alternateSpecialString = alternateSpecialCharacters.formattedName(charactersToRemove: "@#!")
        
        // Then
        XCTAssertEqual(defaultSpecialString, "specialcharacters")
        XCTAssertEqual(alternateSpecialString, "specialcharacters")
    }
}
