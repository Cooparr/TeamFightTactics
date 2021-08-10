//
//  BaseLabelTests.swift
//  TFTCompanionTests
//
//  Created by Alexander James Cooper on 10/08/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import XCTest
@testable import TFT_Companion

class BaseLabelTests: XCTestCase {
    
    //MARK: Properties
    var baseLabelConvOneMultiLine: BaseLabel!
    var baseLabelConvOneNotMultiLine: BaseLabel!
    var baseLabelConvTwo: BaseLabel!
    var baseLabelConvThree: BaseLabel!
    
    
    //MARK: Set Up
    override func setUpWithError() throws {
        try super.setUpWithError()
        baseLabelConvOneMultiLine = BaseLabel(fontSize: 15, fontWeight: .regular, multiLine: true)
        baseLabelConvOneNotMultiLine = BaseLabel(fontSize: 15, fontWeight: .regular)
        baseLabelConvTwo = BaseLabel(textAlignment: .center, fontSize: 15)
        baseLabelConvThree = BaseLabel(textStyle: .body, weight: .regular)
    }

    
    //MARK: Tear Down
    override func tearDownWithError() throws {
        baseLabelConvOneMultiLine = nil
        baseLabelConvOneNotMultiLine = nil
        baseLabelConvTwo = nil
        baseLabelConvThree = nil
        try super.tearDownWithError()
    }
    
    
    //MARK: Test 1st Conv Init with Multiline
    func testbaseLabelConvOneMultiLine() {
        XCTAssertFalse(baseLabelConvOneMultiLine.translatesAutoresizingMaskIntoConstraints)
        XCTAssertEqual(baseLabelConvOneMultiLine.frame, .zero)
        XCTAssertEqual(baseLabelConvOneMultiLine.textColor, ThemeColor.platinum)
        XCTAssertEqual(baseLabelConvOneMultiLine.numberOfLines, 0)
        XCTAssertEqual(baseLabelConvOneMultiLine.lineBreakMode, .byWordWrapping)
    }
    
    
    //MARK: Test 1st Conv Init without Multiline
    func testbaseLabelConvOneNotMultiLine() {
        XCTAssertFalse(baseLabelConvOneNotMultiLine.translatesAutoresizingMaskIntoConstraints)
        XCTAssertEqual(baseLabelConvOneNotMultiLine.frame, .zero)
        XCTAssertEqual(baseLabelConvOneNotMultiLine.textColor, ThemeColor.platinum)
        XCTAssertEqual(baseLabelConvOneNotMultiLine.numberOfLines, 1)
        XCTAssertEqual(baseLabelConvOneNotMultiLine.lineBreakMode, .byTruncatingTail)
    }
    
    
    //MARK: Test 2nd Conv Init
    func testConvenienceInitTwo() {
        XCTAssertFalse(baseLabelConvTwo.translatesAutoresizingMaskIntoConstraints)
        XCTAssertEqual(baseLabelConvTwo.frame, .zero)
        XCTAssertEqual(baseLabelConvTwo.textColor, ThemeColor.platinum)
    }
    
    
    //MARK: Test 3rd Conv Init with Multiline
    func testConvenienceInitThree() {
        XCTAssertFalse(baseLabelConvThree.translatesAutoresizingMaskIntoConstraints)
        XCTAssertEqual(baseLabelConvThree.frame, .zero)
        XCTAssertEqual(baseLabelConvThree.numberOfLines, 0)
        XCTAssertTrue(baseLabelConvThree.adjustsFontForContentSizeCategory)
        XCTAssertTrue(baseLabelConvThree.adjustsFontSizeToFitWidth)
    }
}
