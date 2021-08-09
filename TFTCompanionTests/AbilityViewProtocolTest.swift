//
//  AbilityViewProtocolTest.swift
//  TFT_CompanionTests
//
//  Created by Alexander James Cooper on 06/08/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import XCTest
@testable import TFT_Companion

class AbilityViewProtocolTest: XCTestCase {
    
    //MARK: Test Properties
    var activeAbilityView: SmallAbilityView!
    var passiveAbilityView: SmallAbilityView!
    var activeAbility: ChampionAbility!
    var passiveAbility: ChampionAbility!
    
    //MARK: Set Up
    override func setUpWithError() throws {
        try super.setUpWithError()
        let path = try XCTUnwrap(Bundle.main.path(forResource: "Champions", ofType: "json", inDirectory: "/LocalData/5.0"))
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let champions = try JSONDecoder().decode([Champion].self, from: data)
        
        let activeAbility = try XCTUnwrap(champions.first(where: { $0.ability.active })?.ability)
        let passiveAbility = try XCTUnwrap(champions.first(where: { !$0.ability.active })?.ability)
        
        activeAbilityView = SmallAbilityView()
        passiveAbilityView = SmallAbilityView()
        self.activeAbility = activeAbility
        self.passiveAbility = passiveAbility
    }

    
    //MARK: Tear Down
    override func tearDownWithError() throws {
        activeAbilityView = nil
        passiveAbilityView = nil
        self.activeAbility = nil
        self.passiveAbility = nil
        try super.tearDownWithError()
    }
    
    
    //MARK: Test Configure Ability View
    func testConfigureAbilityView() throws {
        // Given
        XCTAssertEqual(activeAbility.active, true)
        XCTAssertEqual(passiveAbility.active, false)
        let manaStart = try XCTUnwrap(activeAbility.manaStart)
        let manaCost = try XCTUnwrap(activeAbility.manaCost)

        
        // When
        activeAbilityView.configureAbilityView(champAbility: activeAbility)
        passiveAbilityView.configureAbilityView(champAbility: passiveAbility)
        
        
        // Then
        XCTAssertEqual(activeAbilityView.abilityMana.text, "\(manaStart)/\(manaCost)")
        XCTAssertEqual(passiveAbilityView.abilityMana.text, "Passive")
    }
}
 
