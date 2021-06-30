//
//  FirestoreManagerTests.swift
//  TFT_CompanionTests
//
//  Created by Alexander James Cooper on 18/03/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import XCTest
@testable import TFT_Companion


#warning("This is outdated. Needs updating and probably new tests written.")
class FirestoreManagerTests: XCTestCase {
    
    //MARK: Test Properties
    var firestoreManager: SetDataManager!
    var setNumber: Double!
    var setFourChampions: [Champion]!

    
    //MARK: Set Up
    override func setUp() {
        super.setUp()
        firestoreManager = SetDataManager()
        setNumber = UserDefaults.standard.double(forKey: UDKey.setKey)
    }

    //MARK: Set Up With Error
    override func setUpWithError() throws {
        super.setUp()
        let set4ChampsPath = try XCTUnwrap(Bundle.main.path(forResource: SetDataManager.Collection.champions.rawValue, ofType: "json", inDirectory: "/LocalData/" + "4.0"))
        let set4ChampsData = try Data(contentsOf: URL(fileURLWithPath: set4ChampsPath), options: .mappedIfSafe)
        setFourChampions = try JSONDecoder().decode([Champion].self, from: set4ChampsData)
    }


    //MARK: Tear Down
    override func tearDown() {
        firestoreManager = nil
        setNumber = nil
        super.tearDown()
    }


    //MARK: Tear Down With Error
    override func tearDownWithError() throws {
        setFourChampions = nil
        super.tearDown()
    }


    //MARK: Test If All Champs Parsed
    func test_all_champs_parsed_from_each_set() throws {
        try TFTSet.allCases.forEach { setNumber in
            guard let path = Bundle.main.path(forResource: SetDataManager.Collection.champions.rawValue, ofType: "json", inDirectory: "/LocalData/" + "\(setNumber)") else {
                return
            }

            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let champCount = try JSONDecoder().decode([Champion].self, from: data).count

            switch setNumber {
            case .one, .three:
                XCTAssertEqual(champCount, 57)
            case .two:
                XCTAssertEqual(champCount, 56)
            case .four, .four_5:
                XCTAssertEqual(champCount, 58)
            case .five:
                XCTAssertEqual(champCount, 60)
            }
        }
    }


    //MARK: Test If Champ Obj Parsed Correctly
    func test_first_champ_parsed_correctly() {
        // Given
        let champ = setFourChampions.first

        // When
        let expectedName = "Aatrox"
        let expectedImageURL = "https://raw.communitydragon.org/10.21/game/assets/characters/tft4_aatrox/hud/tft4_aatrox_square.tft_set4.png"
        let expectedSplashURL = "https://cdn.communitydragon.org/10.18.0/champion/Aatrox/splash-art/centered/skin/7"
        let expectedChampStats = ChampionStats(attackDamage: 60, health: 800, armor: 40, magicResist: 30, range: 1, attackSpeed: 0.65)
        let expectedAbilityDesc = "After a brief delay, Aatrox pulls in the farthest enemies then slams the ground, dealing magic damage to all adjacent enemies."
        let expectedAbilityImageURL = "https://raw.communitydragon.org/10.18/game/assets/characters/aatrox/hud/icons2d/aatrox_w.png"
        let expectedAbilityStats = [
            "Damage": [ChampionAbility.SomeValueType.int(175), ChampionAbility.SomeValueType.int(250), ChampionAbility.SomeValueType.int(425)],
            "Number of Enemies": [ChampionAbility.SomeValueType.int(2), ChampionAbility.SomeValueType.int(2), ChampionAbility.SomeValueType.int(5)]
        ]

        // Then
        XCTAssertEqual(champ?.name, expectedName)
        XCTAssertEqual(champ?.cost, Cost(rawValue: 4))
        XCTAssertEqual(champ?.imageURL, expectedImageURL)
        XCTAssertEqual(champ?.splashURL, expectedSplashURL)
        XCTAssertEqual(champ?.bestItems, ["Dragon's Claw", "Gargoyle Stoneplate", "Sunfire Cape"])
        XCTAssertEqual(champ?.customItems, nil)
        XCTAssertEqual(champ?.origins, ["Cultist"])
        XCTAssertEqual(champ?.classes, ["Vanguard"])
        XCTAssertEqual(champ?.stats, expectedChampStats)
        XCTAssertEqual(champ?.ability.name, "Infernal Chains")
        XCTAssertEqual(champ?.ability.imageURL, expectedAbilityImageURL)
        XCTAssertEqual(champ?.ability.description, expectedAbilityDesc)
        XCTAssertEqual(champ?.ability.active, true)
        XCTAssertNotNil(champ?.ability.manaCost)
        XCTAssertNotNil(champ?.ability.manaStart)
        XCTAssertEqual(champ?.ability.manaCost, 150)
        XCTAssertEqual(champ?.ability.manaStart, 75)
        XCTAssertEqual(champ?.ability.abilityStats, expectedAbilityStats)
    }
}
