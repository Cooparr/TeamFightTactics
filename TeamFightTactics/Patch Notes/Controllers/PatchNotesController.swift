//
//  PatchNotesController.swift
//  TeamFightTactics
//
//  Created by Alex Cooper on 24/07/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit
import FirebaseFirestore

class PatchNotesController: UIViewController {
    
    var set1 = "Set1"
    var set2 = "Set2"
    var champ = "Champions"
    var teamComp = "TeamCompositions"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = CustomColor.charcoal
        navigationItem.title = "Patch Notes"
        setupTempButtonViews()
    }
    
    fileprivate func setupTempButtonViews() {
        view.addSubview(addChampsToDatabase)
        addChampsToDatabase.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addChampsToDatabase.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        addChampsToDatabase.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        view.addSubview(addTeamCompsToDatabase)
        addTeamCompsToDatabase.topAnchor.constraint(equalTo: addChampsToDatabase.bottomAnchor, constant: 8).isActive = true
        addTeamCompsToDatabase.leadingAnchor.constraint(equalTo: addChampsToDatabase.leadingAnchor).isActive = true
        addTeamCompsToDatabase.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }

    //MARK: Add Champs Button
    let addChampsToDatabase: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Champions", for: .normal)
        btn.backgroundColor = CustomColor.romanSilver
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 1
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        btn.addTarget(self, action: #selector(setOneChamps), for: .touchUpInside)
        btn.addTarget(self, action: #selector(setTwoChamps), for: .touchUpInside)

        
        // Change this to true, when wanting to add Champs to Database.
        btn.isEnabled = true
        return btn
    }()
    
    //MARK: Add Team Comps Button
    let addTeamCompsToDatabase: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Team Compositions", for: .normal)
        btn.backgroundColor = CustomColor.romanSilver
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 1
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        btn.addTarget(self, action: #selector(setOneTeamComps), for: .touchUpInside)
        btn.addTarget(self, action: #selector(setTwoTeamComps), for: .touchUpInside)
        
        // Change this to true, when wanting to add TeamComps to Database.
        btn.isEnabled = true
        return btn
    }()
    
    //MARK:- setOneTeamComps
    @objc func setOneTeamComps() {
        print("Adding Set One Team Compositions")
        
        //MARK: Brawlers
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Brawlers").setData([
            "title": "Brawlers",
            "tier": 0,
            "set": [1],
            "synergies": [
                [
                    "name": "Brawler",
                    "count": 6,
                    "rank": 0
                ],
                [
                    "name": "Gunslinger",
                    "count": 2,
                    "rank": 2
                ],
                [
                    "name": "Hextech",
                    "count": 2,
                    "rank": 2
                ],
                [
                    "name": "Robot",
                    "count": 1,
                    "rank": 0
                ],
                [
                    "name": "Void",
                    "count": 2,
                    "rank": 2
                ]
            ],
            "endGame": [
                [
                    "name": "Warwick",
                    "position": 19
                ],
                [
                    "name": "Blitzcrank",
                    "position": 14,
                    "items": ["ionicspark", "ionicspark"]
                ],
                [
                    "name": "Lucian",
                    "position": 20
                ],
                [
                    "name": "RekSai",
                    "position": 5
                ],
                [
                    "name": "Vi",
                    "position": 15
                ],
                [
                    "name": "Volibear",
                    "position": 13
                ],
                [
                    "name": "Chogath",
                    "position": 7,
                    "items": ["giantslayer", "trapclaw"]
                ],
                [
                    "name": "Jinx",
                    "position": 21,
                    "items": ["giantslayer", "trapclaw"]
                ]
            ],
            "earlyGame": ["Fiora", "Garen", "Lucian"],
            "midGame": ["Blitzcrank", "RekSai", "Vi", "Chogath", "Jinx"]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
   

        //MARK: Dragon Knights
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("DragonKnights").setData([
            "title": "Dragon Knights",
            "tier": 0,
            "set": [1],
            "synergies": [
                [
                    "name": "Dragon",
                    "count": 2,
                    "rank": 0
                ],
                [
                    "name": "Guardian",
                    "count": 2,
                    "rank": 0
                ],
                [
                    "name": "Phantom",
                    "count": 2,
                    "rank": 0
                ],
                [
                    "name": "Knight",
                    "count": 4,
                    "rank": 1
                ]
            ],
            "endGame": [
                [
                    "name": "Mordekaiser",
                    "position": 3
                ],
                [
                    "name": "Poppy",
                    "position": 5
                ],
                [
                    "name": "Aurelion Sol",
                    "position": 18,
                    "items": ["morellonomicon", "rabadonsdeathcap", "seraphsembrace"]
                ],
                [
                    "name": "Kindred",
                    "position": 19
                ],
                [
                    "name": "Leona",
                    "position": 11
                ],
                [
                    "name": "Sejuani",
                    "position": 4,
                    "items": ["guardianangel"]
                ],
                [
                    "name": "Kayle",
                    "position": 17,
                    "items": ["guinsoosrageblade", "spearofshojin"]
                ],
                [
                    "name": "Pantheon",
                    "position": 12
                ]
            ],
            "earlyGame": ["Fiora", "Garen", "Lucian"],
            "midGame": ["Darius", "Mordekaiser", "Poppy", "Kindred", "Sejuani"]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Yordle Shapeshifters
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("YordleShapeshifters").setData([
            "title": "Yordle Shapeshifter",
            "tier": 1,
            "set": [1],
            "synergies": [
                [
                    "name": "Demon",
                    "count": 2,
                    "rank": 2
                ],
                [
                    "name": "Dragon",
                    "count": 2,
                    "rank": 0
                ],
                [
                    "name": "Ninja",
                    "count": 1,
                    "rank": 2
                ],
                [
                    "name": "Shapeshifter",
                    "count": 3,
                    "rank": 2
                ],
                [
                    "name": "Sorcerer",
                    "count": 3,
                    "rank": 2
                ],
                [
                    "name": "Yordle",
                    "count": 6,
                    "rank": 1
                ]
            ],
            "endGame": [
                [
                    "name": "Lulu",
                    "position": 8
                ],
                [
                    "name": "Kennen",
                    "position": 2,
                    "items": ["guardianangel", "morellonomicon"]
                ],
                [
                    "name": "Poppy",
                    "position": 3
                ],
                [
                    "name": "Shyvana",
                    "position": 1,
                    "items": ["mittens", "warmogsarmor"]
                ],
                [
                    "name": "Veigar",
                    "position": 16
                ],
                [
                    "name": "AurelionSol",
                    "position": 15,
                    "items": ["darkin"]
                ],
                [
                    "name": "Gnar",
                    "position": 9,
                    "items": ["dragonsclaw"]
                ],
                [
                    "name": "Swain",
                    "position": 10
                ]
            ],
            "earlyGame": ["Graves", "Lucian", "Tristana"],
            "midGame": ["Lulu", "Poppy", "Veigar", "Shyvana", "Aurelionsol"]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Wild Sorcerers
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("WildSorcerers").setData([
            "title": "Wild Sorcerers",
            "tier": 1,
            "set": [1],
            "synergies": [
                [
                    "name": "Wild",
                    "count": 4,
                    "rank": 0
                ],
                [
                    "name": "Dragon",
                    "count": 2,
                    "rank": 0
                ],
                [
                    "name": "Shapeshifter",
                    "count": 3,
                    "rank": 2
                ],
                [
                    "name": "Sorcerer",
                    "count": 3,
                    "rank": 2
                ]
            ],
            "endGame": [
                [
                    "name": "Nidalee",
                    "position": 8
                ],
                [
                    "name": "Warwick",
                    "position": 2
                ],
                [
                    "name": "Ahri",
                    "position": 16,
                    "items": ["statikkshiv", "statikkshiv"]
                ],
                [
                    "name": "TwistedFate",
                    "position": 1,
                    "items": ["guinsoosrageblade", "hextechgunblade", "warmogsarmor"]
                ],
                [
                    "name": "Shyvana",
                    "position": 1,
                    "items": ["guinsoosrageblade", "hextechgunblade", "warmogsarmor"]
                ],
                [
                    "name": "AurelionSol",
                    "position": 15
                ],
                [
                    "name": "Gnar",
                    "position": 10,
                    "items": ["dragonsclaw"]
                ]
            ],
            "earlyGame": ["Nidalee", "Warwick"],
            "midGame": ["Nidalee", "Warwick", "Ahri", "Shyvana", "Gnar"]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Glacial Rangers
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("GlacialRangers").setData([
            "title": "Glacial Rangers",
            "tier": 2,
            "set": [1],
            "synergies": [
                [
                    "name": "Glacial",
                    "count": 4,
                    "rank": 1
                ],
                [
                    "name": "Knight",
                    "count": 2,
                    "rank": 2
                ],
                [
                    "name": "Phantom",
                    "count": 2,
                    "rank": 0
                ],
                [
                    "name": "Ranger",
                    "count": 4,
                    "rank": 0
                ]
            ],
            "endGame": [
                [
                    "name": "Mordekaiser",
                    "position": 1
                ],
                [
                    "name": "Varus",
                    "position": 16
                ],
                [
                    "name": "Ashe",
                    "position": 15,
                    "items": ["guinsoosrageblade", "spearofshojin", "statikkshiv"]
                ],
                [
                    "name": "Volibear",
                    "position": 10
                ],
                [
                    "name": "Kindred",
                    "position": 9,
                    "items": ["guardianangel"]
                ],
                [
                    "name": "Sejuani",
                    "position": 2,
                    "items": ["darkin"]
                ],
                [
                    "name": "Anivia",
                    "position": 17
                ],
                [
                    "name": "Kaisa",
                    "position": 8
                ]
            ],
            "earlyGame": ["Fiora", "Garen", "Vayne"],
            "midGame": ["Mordekaiser", "Ashe", "Kindred", "Sejuani"]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Ninja Assassins
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("NinjaAssassins").setData([
            "title": "Ninja Assassins",
            "tier": 1,
            "set": [1],
            "synergies": [
                [
                    "name": "Assassin",
                    "count": 6,
                    "rank": 0
                ],
                [
                    "name": "Ninja",
                    "count": 4,
                    "rank": 0
                ]
            ],
            "endGame": [
                [
                    "name": "Pyke",
                    "position": 21
                ],
                [
                    "name": "Shen",
                    "position": 15
                ],
                [
                    "name": "Zed",
                    "position": 19,
                    "items": ["bloodthirster", "inifintyedge"]
                ],
                [
                    "name": "Katarina",
                    "position": 18,
                    "items": ["jeweledgauntlet"]
                ],
                [
                    "name": "Kennen",
                    "position": 16,
                    "items": ["guardianangel", "youmuusghostblade"]
                ],
                [
                    "name": "Rengar",
                    "position": 17
                ],
                [
                    "name": "Akali",
                    "position": 20,
                    "items": ["seraphsembrace"]
                ]
            ],
            "earlyGame": ["Khazix", "Pyke", "Zed"],
            "midGame": ["Shen", "Pyke", "Zed", "Kennen", "Akali"]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Nobles
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Nobles").setData([
            "title": "Nobles",
            "tier": 2,
            "set": [1],
            "synergies": [
                [
                    "name": "Blademaster",
                    "count": 3,
                    "rank": 2
                ],
                [
                    "name": "Exile",
                    "count": 3,
                    "rank": 2
                ],
                [
                    "name": "Gunslinger",
                    "count": 2,
                    "rank": 2
                ],
                [
                    "name": "Knight",
                    "count": 2,
                    "rank": 2
                ],
                [
                    "name": "Noble",
                    "count": 6,
                    "rank": 0
                ]
            ],
            "endGame": [
                [
                    "name": "Fiora",
                    "position": 15
                ],
                [
                    "name": "Garen",
                    "position": 5
                ],
                [
                    "name": "Vayne",
                    "position": 21
                ],
                [
                    "name": "Lucian",
                    "position": 7
                ],
                [
                    "name": "Gangplank",
                    "position": 3,
                    "items": ["guardianangel", "redbuff", "hextechgunblade"]
                ],
                [
                    "name": "Leona",
                    "position": 7
                ],
                [
                    "name": "Kayle",
                    "position": 17,
                    "items": ["spearofshojin", "guinsoosrageblade"]
                ],
                [
                    "name": "Yasuo",
                    "position": 1,
                    "items": ["seraphsembrace", "ludensecho"]
                ],
            ],
            "earlyGame": ["Fiora", "Garen", "Lucian"],
            "midGame": ["Fiora", "Garen", "Lucian", "Gangplank"]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Pirate Gunslingers
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("PirateGunslingers").setData([
            "title": "Pirate Gunslingers",
            "tier": 3,
            "set": [1],
            "synergies": [
                [
                    "name": "Brawler",
                    "count": 2,
                    "rank": 2
                ],
                [
                    "name": "Gunslinger",
                    "count": 6,
                    "rank": 0
                ],
                [
                    "name": "Hextech",
                    "count": 2,
                    "rank": 2
                ],
                [
                    "name": "Pirate",
                    "count": 3,
                    "rank": 0
                ]
            ],
            "endGame": [
                [
                    "name": "Graves",
                    "position": 2,
                    "items": ["giantslayer"]
                ],
                [
                    "name": "Tristana",
                    "position": 17,
                    "items": ["giantslayer", "guinsoosrageblade"]
                ],
                [
                    "name": "Lucian",
                    "position": 18
                ],
                [
                    "name": "Gangplank",
                    "position": 3,
                    "items": ["guardianangel", "redbuff", "hush"]
                ],
                [
                    "name": "Vi",
                    "position": 4
                ],
                [
                    "name": "Chogath",
                    "position": 1
                ],
                [
                    "name": "Jinx",
                    "position": 16
                ],
                [
                    "name": "MissFortune",
                    "position": 15
                ]
            ],
            "earlyGame": ["Graves", "Tristana", "Lucian"],
            "midGame": ["Graves", "Tristana", "Lucian", "Pyke", "Gangplank"]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Void Assassins
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("VoidAssassins").setData([
            "title": "Void Assassins",
            "tier": 2,
            "set": [1],
            "synergies": [
                [
                    "name": "Assassin",
                    "count": 6,
                    "rank": 0
                ],
                [
                    "name": "Brawler",
                    "count": 2,
                    "rank": 2
                ],
                [
                    "name": "Ninja",
                    "count": 1,
                    "rank": 2
                ],
                [
                    "name": "Void",
                    "count": 5,
                    "rank": 0
                ]
            ],
            "endGame": [
                [
                    "name": "Khazix",
                    "position": 18
                ],
                [
                    "name": "Kassadin",
                    "position": 21,
                    "items": ["infinityedge", "youmuusghostblade", "rapidfirecanon"]
                ],
                [
                    "name": "Pyke",
                    "position": 14,
                    "items": ["morellonomicon"]
                ],
                [
                    "name": "RekSai",
                    "position": 16
                ],
                [
                    "name": "Rengar",
                    "position": 19
                ],
                [
                    "name": "Akali",
                    "position": 20
                ],
                [
                    "name": "Chogath",
                    "position": 15
                ],
                [
                    "name":"Kaisa",
                    "position": 17
                ]
            ],
            "earlyGame": ["Khazix", "Pyke", "Zed"],
            "midGame": ["Kassadin", "Khazix", "Pyke", "Reksai", "Zed"]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Glacial Elementalists
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("GlacialElementalists").setData([
            "title": "Glacial Elementalists",
            "tier": 3,
            "set": [1],
            "synergies": [
                [
                    "name": "Demon",
                    "count": 2,
                    "rank": 2
                ],
                [
                    "name": "Elementalist",
                    "count": 3,
                    "rank": 0
                ],
                [
                    "name": "Glacial",
                    "count": 6,
                    "rank": 0
                ],
                [
                    "name": "Guardian",
                    "count": 2,
                    "rank": 0
                ]
            ],
            "endGame": [
                [
                    "name": "Braum",
                    "position": 3
                ],
                [
                    "name": "Lissandra",
                    "position": 1
                ],
                [
                    "name": "Ashe",
                    "position": 15
                ],
                [
                    "name": "Volibear",
                    "position": 10,
                    "items": ["hush", "rapidfirecanon", "titanichydra"]
                ],
                [
                    "name": "Brand",
                    "position": 8,
                    "items": ["morellonomicon"]
                ],
                [
                    "name": "Sejuani",
                    "position": 2,
                    "items": ["darkin"]
                ],
                [
                    "name": "Anivia",
                    "position": 16
                ],
                [
                    "name": "Pantheon",
                    "position": 9
                ]
            ],
            "earlyGame": ["Fiora", "Garen", "Vayne"],
            "midGame": ["Lissandra", "Varus", "Ashe", "Kennen", "Brand"]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Knights
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Knights").setData([
            "title": "Knights",
            "tier": 1,
            "set": [1],
            "synergies": [
                [
                    "name": "Knight",
                    "count": 6,
                    "rank": 0
                ],
                [
                    "name": "Phantom",
                    "count": 6,
                    "rank": 0
                ],
                [
                    "name": "Ranger",
                    "count": 2,
                    "rank": 2
                ]
            ],
            "endGame": [
                [
                    "name": "Darius",
                    "position": 15
                ],
                [
                    "name": "Garen",
                    "position": 3
                ],
                [
                    "name": "Mordekaiser",
                    "position": 1
                ],
                [
                    "name": "Poppy",
                    "position": 5
                ],
                [
                    "name": "Kindred",
                    "position": 19
                ],
                [
                    "name": "Sejuani",
                    "position": 7,
                    "items": ["morellonomicon"]
                ],
                [
                    "name": "Kaisa",
                    "position": 18,
                    "items": ["giantslayer", "guinsoossrageblade", "statikkshiv"]
                ],
                [
                    "name": "Kayle",
                    "position": 20,
                    "items": ["spearofshojin", "guinsoosrageblade"]
                ]
            ],
            "earlyGame": ["Fiora", "Garen", "Vayne"],
            "midGame": ["Garen", "Mordekaiser", "Poppy", "Kindred", "Sejuani"]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Elemental Rangers
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("ElementalRangers").setData([
            "title": "Elemental Rangers",
            "tier": 2,
            "set": [1],
            "synergies": [
                [
                    "name": "Demon",
                    "count": 2,
                    "rank": 2
                ],
                [
                    "name": "Elementalist",
                    "count": 3,
                    "rank": 0
                ],
                [
                    "name": "Glacial",
                    "count": 4,
                    "rank": 1
                ],
                [
                    "name": "Ranger",
                    "count": 4,
                    "rank": 0
                ]
            ],
            "endGame": [
                [
                    "name": "Vayne",
                    "position": 10
                ],
                [
                    "name": "Lissandra",
                    "position": 1
                ],
                [
                    "name": "Varus",
                    "position": 16
                ],
                [
                    "name": "Ashe",
                    "position": 15,
                    "items": ["guinsoosrageblade", "spearofshojin", "runaanshurricane"]
                ],
                [
                    "name": "Brand",
                    "position": 8,
                    "items": ["morellonomicon"]
                ],
                [
                    "name": "Kindred",
                    "position": 9
                ],
                [
                    "name": "Sejuani",
                    "position": 2
                ],
                [
                    "name": "Anivia",
                    "position": 17
                ]
            ],
            "earlyGame": ["Fiora", "Garen", "Vayne"],
            "midGame": ["Lissandra", "Varus", "Ashe", "Kennen", "Brand"]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Ninja Elementalist
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("NinjaElementalist").setData([
            "title": "Ninja Elementalist",
            "tier": 1,
            "set": [1],
            "synergies": [
                [
                    "name": "Assassin",
                    "count": 3,
                    "rank": 2
                ],
                [
                    "name": "Elementalist",
                    "count": 3,
                    "rank": 0
                ],
                [
                    "name": "Ninja",
                    "count": 4,
                    "rank": 0
                ]
            ],
            "endGame": [
                [
                    "name": "Shen",
                    "position": 21
                ],
                [
                    "name": "Zed",
                    "position": 17,
                    "items": ["bloodthirster", "infinityedge"]
                ],
                [
                    "name": "Kennen",
                    "position": 18,
                    "items": ["guardianangel", "youmuusghostblade"]
                ],
                [
                    "name": "Akali",
                    "position": 16,
                    "items": ["dragonsclaw", "seraphsembrace"]
                ],
                [
                    "name": "Brand",
                    "position": 20
                ],
                [
                    "name": "Anivia",
                    "position": 19
                ]
            ],
            "earlyGame": ["Khazix", "Pyke", "Zed"],
            "midGame": ["Shen", "Zed", "Kennen", "Akali"]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Imperial Elementalist
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("ImperialElementalist").setData([
            "title": "Imperial Elementalist",
            "tier": 1,
            "set": [1],
            "synergies": [
                [
                    "name": "Demon",
                    "count": 2,
                    "rank": 2
                ],
                [
                    "name": "Elementalist",
                    "count": 3,
                    "rank": 0
                ],
                [
                    "name": "Glacial",
                    "count": 2,
                    "rank": 2
                ],
                [
                    "name": "Imperial",
                    "count": 4,
                    "rank": 0
                ],
                [
                    "name": "Knight",
                    "count": 2,
                    "rank": 2
                ],
                [
                    "name": "Ninja",
                    "count": 1,
                    "rank": 2
                ]
            ],
            "endGame": [
                [
                    "name": "Darius",
                    "position": 3
                ],
                [
                    "name": "Katarina",
                    "position": 15,
                    "items": ["darkin"]
                ],
                [
                    "name": "Kennen",
                    "position": 4,
                    "items": ["guardianangel", "morellonomicon"]
                ],
                [
                    "name": "Brand",
                    "position": 17
                ],
                [
                    "name": "Draven",
                    "position": 18,
                    "items": ["bloodthirster", "guinsoosrageblade"]
                ],
                [
                    "name": "Sejuani",
                    "position": 5
                ],
                [
                    "name": "Anivia",
                    "position": 19
                ],
                [
                    "name": "Swain",
                    "position": 16
                ]
            ],
            "earlyGame": ["Darius", "Nidalee", "Warwick"],
            "midGame": ["Darius", "Lissandra", "Kennen", "Brand", "Draven"]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Demon Shapeshifters
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("DemonShapeshifters").setData([
            "title": "Demon Shapeshifters",
            "tier": 2,
            "set": [1],
            "synergies": [
                [
                    "name": "Demon",
                    "count": 4,
                    "rank": 0
                ],
                [
                    "name": "Dragon",
                    "count": 2,
                    "rank": 0
                ],
                [
                    "name": "Guardian",
                    "count": 2,
                    "rank": 0
                ],
                [
                    "name": "Shapeshifter",
                    "count": 3,
                    "rank": 2
                ]
            ],
            "endGame": [
                [
                    "name": "Evelynn",
                    "position": 17
                ],
                [
                    "name": "Morgana",
                    "position": 3
                ],
                [
                    "name": "Shyvana",
                    "position": 4,
                    "items": ["hextechgunblade", "guinsoosrageblade", "warmogsarmor"]
                ],
                [
                    "name": "Brand",
                    "position": 18
                ],
                [
                    "name": "Gnar",
                    "position": 5
                ],
                [
                    "name": "Leona",
                    "position": 12
                ],
                [
                    "name": "Pantheon",
                    "position": 11
                ],
                [
                    "name": "Swain",
                    "position": 19,
                    "items": ["morellonomicon", "guardianangel"]
                ]
            ],
            "earlyGame": ["Camille", "Jayce", "Varus"],
            "midGame": ["Camille", "Elise", "Jayce", "Varus", "Shyvana"]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                print("Set One All Done")
            }
        }
    }

    //MARK:- setTwoTeamComps
    @objc func setTwoTeamComps() {
        print("Adding Set Two Team Compositions")
    }

    //MARK:- setOneChamps
    @objc func setOneChamps() {
        print("Adding Set One Champions")

        //MARK: Aatrox
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Aatrox").setData([
            "key": "Aatrox",
            "name": "Aatrox",
            "cost": 3,
            "origins": ["Demon"],
            "classes": ["Blademaster"],
            "tier": 2,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "hextechgunblade",
                "spearofshojin",
                "guardianangel"
            ],
            "ability": [
                "name": "The Darkin Blade",
                "key": "AatroxQ",
                "active": true,
                "description": "Aatrox cleaves the area in front of him, dealing damage to enemies inside it.",
                "manaCost": 75,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [300, 600, 900]
                ]
            ],
            "champStats": [
                "armor": 25,
                "attackDamage": 65,
                "attackSpeed": 0.65,
                "health": 700,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Ahri
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Ahri").setData([
            "key": "Ahri",
            "name": "Ahri",
            "cost": 2,
            "origins": ["Wild"],
            "classes": ["Sorcerer"],
            "tier": 2,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "statikkshiv",
                "guinsoosrageblade",
                "ludensecho"
            ],
            "ability": [
                "name": "Orb of Deception",
                "key": "AhriOrbofDeception",
                "active": true,
                "description": "Ahri fires an orb in a line that returns to her, damaging enemies it passes through.",
                "manaCost": 75,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [100, 200, 300]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 50,
                "attackSpeed": 0.55,
                "health": 450,
                "magicResist": 20,
                "range": 3
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Akali
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Akali").setData([
            "key": "Akali",
            "name": "Akali",
            "cost": 4,
            "origins": ["Ninja"],
            "classes": ["Assassin"],
            "tier": 2,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "phantomdancer",
                "seraphsembrace",
                "rabadonsdeathcap"
            ],
            "ability": [
                "name": "Five Point Strike",
                "key": "AkaliQ",
                "active": true,
                "description": "Akali throws shurikens in front of her, dealing damage.",
                "manaCost": 25,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [200, 350, 500]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 80,
                "attackSpeed": 0.7,
                "health": 650,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Anivia
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Anivia").setData([
            "key": "Anivia",
            "name": "Anivia",
            "cost": 5,
            "origins": ["Glacial"],
            "classes": ["Elementalist"],
            "tier": 2,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "seraphsembrace",
                "rabadonsdeathcap",
                "morellonomicon"
            ],
            "ability": [
                "name": "Glacial Storm",
                "key": "GlacialStorm",
                "active": true,
                "description": "Anivia channels a large hailstorm, damaging enemies inside of it.",
                "manaCost": 100,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [800, 950, 1200],
                    "Attack Speed Slow": [50, 70, 90],
                    "Storm Duration": ["6s"]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 40,
                "attackSpeed": 0.6,
                "health": 700,
                "magicResist": 20,
                "range": 3
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Ashe
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Ashe").setData([
            "key": "Ashe",
            "name": "Ashe",
            "cost": 3,
            "origins": ["Glacial"],
            "classes": ["Ranger"],
            "tier": 2,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "statikkshiv",
                "guinsoosrageblade",
                "spearofshojin"
            ],
            "ability": [
                "name": "Enchanted Crystal Arrow",
                "key": "EnchantedCrystalArrow",
                "active": true,
                "description": "Ashe fires an arrow that travels across the map, damages, and stuns (stun duration based on each hex traveled).",
                "manaCost": 100,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [700, 950, 1200],
                    "Stun Duration": ["1s", "1.5s", "2s"]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 65,
                "attackSpeed": 0.7,
                "health": 550,
                "magicResist": 20,
                "range": 4
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Aurelion Sol
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("AurelionSol").setData([
            "key": "AurelionSol",
            "name": "Aurelion Sol",
            "cost": 4,
            "origins": ["Dragon"],
            "classes": ["Sorcerer"],
            "tier": 1,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "rapidfirecannon",
                "spearofshojin",
                "morellonomicon"
            ],
            "ability": [
                "name": "Voice of Light",
                "key": "AurelionSolR",
                "active": true,
                "description": "Aurelion Sol breathes a large blast of fire in a line, dealing damage to enemies",
                "manaCost": 125,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [250, 500, 750],
                    "Channel Duration": ["0.35s"]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 40,
                "attackSpeed": 0.6,
                "health": 650,
                "magicResist": 20,
                "range": 3
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Blitzcrank
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Blitzcrank").setData([
            "key": "Blitzcrank",
            "name": "Blitzcrank",
            "cost": 2,
            "origins": ["Robot"],
            "classes": ["Brawler"],
            "tier": 1,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "spearofshojin",
                "ludensecho",
                "rabadonsdeathcap"
            ],
            "ability": [
                "name": "Rocket Grab",
                "key": "RocketGrab",
                "active": true,
                "description": "Blitzcrank pulls the furthest enemy to him.",
                "manaCost": 125,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [250, 550, 850],
                    "Stun Duration": ["2.5s"]
                ]
            ],
            "champStats": [
                "armor": 35,
                "attackDamage": 50,
                "attackSpeed": 0.5,
                "health": 650,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Brand
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Brand").setData([
            "key": "Brand",
            "name": "Brand",
            "cost": 4,
            "origins": ["Demon"],
            "classes": ["Elementalist"],
            "tier": 1,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "morellonomicon",
                "spearofshojin",
                "hextechgunblade"
            ],
            "ability": [
                "name": "Pyroclasm",
                "key": "BrandR",
                "active": true,
                "description": "Brand launches a bouncing fireball, damaging enemies hit.",
                "manaCost": 150,
                "manaStart": 50,
                "abilityStats": [
                    "Damage": [250, 450, 650],
                    "Bounces": [4, 4, 6]
                ]
            ],
            "champStats": [
                "armor": 25,
                "attackDamage": 60,
                "attackSpeed": 0.6,
                "health": 700,
                "magicResist": 20,
                "range": 3
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Braum
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Braum").setData([
            "key": "Braum",
            "name": "Braum",
            "cost": 2,
            "origins": ["Glacial"],
            "classes": ["Guardian"],
            "tier": 3,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "thornmail",
                "warmogsarmor",
                "dragonsclaw"
            ],
            "ability": [
                "name": "Unbreakable",
                "key": "BraumE",
                "active": true,
                "description": "Braum creates a barrier that blocks all incoming damage.",
                "manaCost": 75,
                "manaStart": 0,
                "abilityStats": [
                    "Damage Reduction": ["70%", "80%", "90%"],
                    "Duration": ["4s"]
                ]
            ],
            "champStats": [
                "armor": 75,
                "attackDamage": 40,
                "attackSpeed": 0.6,
                "health": 650,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Camille
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Camille").setData([
            "key": "Camille",
            "name": "Camille",
            "cost": 1,
            "origins": ["Hextech"],
            "classes": ["Blademaster"],
            "tier": 5,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "spearofshojin",
                "titanichydra",
                "guardianangel"
            ],
            "ability": [
                "name": "The Hextech Ultimatum",
                "key": "CamilleR",
                "active": true,
                "description": "Camille singles out an enemy, dealing magic damage and rooting them for few seconds. Camille's allies in range will prioritize attacking that enemy.",
                "manaCost": 150,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [200, 325, 450],
                    "Root Duration": ["4s", "5s", "6s"]
                ]
            ],
            "champStats": [
                "armor": 25,
                "attackDamage": 55,
                "attackSpeed": 0.6,
                "health": 550,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Cho'gath
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Cho'gath").setData([
            "key": "Chogath",
            "name": "Cho'Gath",
            "cost": 4,
            "origins": ["Void"],
            "classes": ["Brawler"],
            "tier": 1,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "morellonomicon",
                "hextechgunblade",
                "yuumi"
            ],
            "ability": [
                "name": "Rupture",
                "key": "Rupture",
                "active": true,
                "description": "Cho'gath ruptures an area, stunning and damaging enemies inside of it.",
                "manaCost": 150,
                "manaStart": 50,
                "abilityStats": [
                    "Damage": [175, 350, 525],
                    "Knockup Duration": ["1.5s", "1.75s", "2s"],
                    "AoE Radius": [3],
                    "Delay": ["1.5s"]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 70,
                "attackSpeed": 0.6,
                "health": 1000,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Darius
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Darius").setData([
            "key": "Darius",
            "name": "Darius",
            "cost": 1,
            "origins": ["Imperial"],
            "classes": ["Knight"],
            "tier": 3,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "dragonsclaw",
                "warmogsarmor",
                "phantomdancer"
            ],
            "ability": [
                "name": "Decimate",
                "key": "DariusCleave",
                "active": true,
                "description": "Darius swings his axe, damaging nearby enemies and healing himself based off his missing health.",
                "manaCost": 100,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [150, 225, 300],
                    "Heal": [100, 150, 200],
                    "Delay": ["1.5s"]
                ]
            ],
            "champStats": [
                "armor": 40,
                "attackDamage": 50,
                "attackSpeed": 0.5,
                "health": 600,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Draven
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Draven").setData([
            "key": "Draven",
            "name": "Draven",
            "cost": 4,
            "origins": ["Imperial"],
            "classes": ["Blademaster"],
            "tier": 0,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "bloodthirster",
                "rapidfirecannon",
                "guardianangel"
            ],
            "ability": [
                "name": "Spinning Axes",
                "key": "DravenSpinning",
                "active": false,
                "description": "Draven gains bonus on-hit damage and Attack Speed. Stacks up to two times.",
                "manaCost": nil,
                "manaStart": nil,
                "abilityStats": [
                    "Buff Duration": ["8s"],
                    "Attack Damage Multiplier": ["150%", "200%", "250%"]
                ]
            ],
            "champStats": [
                "armor": 25,
                "attackDamage": 70,
                "attackSpeed": 0.75,
                "health": 650,
                "magicResist": 20,
                "range": 3
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Elise
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Elise").setData([
            "key": "Elise",
            "name": "Elise",
            "cost": 1,
            "origins": ["Demon"],
            "classes": ["Shapeshifter"],
            "tier": 5,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "guinsoosrageblade",
                "thornmail",
                "warmogsarmor"
            ],
            "ability": [
                "name": "Spider Form",
                "key": "EliseR",
                "active": true,
                "description": "Elise fires a cocoon stunning the nearest enemy and transforms, summoning 2 Spiderlings.",
                "manaCost": 100,
                "manaStart": 0,
                "abilityStats": [
                    "Life Steal": ["60%", "90%", "120%"],
                    "Number of Spiderlings": [1, 2, 4],
                    "Spiderling Attack Damage": [60],
                    "Spiderling Attack Speed": [0.7],
                    "Spiderling Health": [500]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 45,
                "attackSpeed": 0.6,
                "health": 500,
                "magicResist": 20,
                "range": 2
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Evelynn
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Evelynn").setData([
            "key": "Evelynn",
            "name": "Evelynn",
            "cost": 3,
            "origins": ["Demon"],
            "classes": ["Assassin"],
            "tier": 2,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "spearofshojin",
                "hextechgunblade",
                "guardianangel"
            ],
            "ability": [
                "name": "Last Caress",
                "key": "EvelynnR",
                "active": true,
                "description": "Evelynn deals damage to the 3 closest enemies and teleports away. Damage is increased against low health enemies.",
                "manaCost": 75,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [200, 300, 400],
                    "Crit Multiplier": ["3x", "4x", "5x"],
                    "Crit Threshold": ["50% HP"],
                    "Blink Distance": [3]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 70,
                "attackSpeed": 0.6,
                "health": 550,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Fiora
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Fiora").setData([
            "key": "Fiora",
            "name": "Fiora",
            "cost": 1,
            "origins": ["Noble"],
            "classes": ["Blademaster"],
            "tier": 3,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "titanichydra",
                "spearofshojin",
                "statikkshiv"
            ],
            "ability": [
                "name": "Riposte",
                "key": "FioraW",
                "active": true,
                "description": "Fiora becomes immune to damage and spells. After a short delay, she stuns and damages the closest enemy.",
                "manaCost": 75,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [100, 250, 400],
                    "Stun Duration": ["1.5s"],
                    "Block Duration": ["1.5s"]
                ]
            ],
            "champStats": [
                "armor": 25,
                "attackDamage": 40,
                "attackSpeed": 1,
                "health": 400,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Gangplank
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Gangplank").setData([
            "key": "Gangplank",
            "name": "Gangplank",
            "cost": 3,
            "origins": ["Pirate"],
            "classes": ["Gunslinger", "Blademaster"],
            "tier": 3,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "redbuff",
                "seraphsembrace",
                "guardianangel"
            ],
            "ability": [
                "name": "Powder Kegs",
                "key": "GangplankE",
                "active": false,
                "description": "Gangplank periodically creates barrels. On cast, Gangplank detonates the barrels, damaging nearby enemies.",
                "manaCost": 100,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [150, 250, 350]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 55,
                "attackSpeed": 0.65,
                "health": 700,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Garen
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Garen").setData([
            "key": "Garen",
            "name": "Garen",
            "cost": 1,
            "origins": ["Noble"],
            "classes": ["Knight"],
            "tier": 3,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "morellonomicon",
                "thornmail",
                "warmogsarmor"
            ],
            "ability": [
                "name": "Judgement",
                "key": "GarenE",
                "active": true,
                "description": "Garen rapidly spins his sword around his body, becoming immune to magic damage and dealing damage to nearby enemies.",
                "manaCost": 100,
                "manaStart": 0,
                "abilityStats": [
                    "Total Damage": [360, 585, 810],
                    "Damage per Tick": [50, 65, 80],
                    "Total Ticks": [9] ,
                    "Spin Duration": ["4s"]
                ]
            ],
            "champStats": [
                "armor": 40,
                "attackDamage": 50,
                "attackSpeed": 0.6,
                "health": 600,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Gnar
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Gnar").setData([
            "key": "Gnar",
            "name": "Gnar",
            "cost": 4,
            "origins": ["Wild", "Yordle"],
            "classes": ["Shapeshifter"],
            "tier": 0,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "guardianangel",
                "warmogsarmor",
                "dragonsclaw"
            ],
            "ability": [
                "name": "GNAR!",
                "key": "GnarR",
                "active": true,
                "description": "Gnar transforms and jumps behind the furthest enemy, damaging and shoving enemies backwards.",
                "manaCost": 100,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [200, 300, 400],
                    "CC Duration": ["2s"],
                    "Knockback Distance": [2],
                    "Transform Duration": ["60s"],
                    "Transform Bonus HP": [250, 450, 650],
                    "Transform Bonus Attack Damage": [50, 100, 150]
                ]
            ],
            "champStats": [
                "armor": 30,
                "attackDamage": 50,
                "attackSpeed": 0.7,
                "health": 700,
                "magicResist": 20,
                "range": 2
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Graves
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Graves").setData([
            "key": "Graves",
            "name": "Graves",
            "cost": 1,
            "origins": ["Pirate"],
            "classes": ["Gunslinger"],
            "tier": 3,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "redbuff",
                "rapidfirecannon",
                "rapidfirecannon"
            ],
            "ability": [
                "name": "Buckshot",
                "key": "GravesChargeShot",
                "active": false,
                "description": "Graves' attacks deal splash damage to nearby enemies.",
                "manaCost": nil,
                "manaStart": nil,
                "abilityStats": [
                    "Damage Multiplier": [0.1, 0.2, 0.3]
                ]
            ],
            "champStats": [
                "armor": 30,
                "attackDamage": 55,
                "attackSpeed": 0.55,
                "health": 450,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Jayce
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Jayce").setData([
            "key": "Jayce",
            "name": "Jayce",
            "cost": 2,
            "origins": ["Hextech"],
            "classes": ["Shapeshifter"],
            "tier": 4,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "statikkshiv",
                "guinsoosrageblade",
                "hush"
            ],
            "ability": [
                "name": "Mecury Cannon",
                "key": "JayceStanceHtG",
                "active": true,
                "description": "Jayce knocks away an emeny in melee range, dealing damage and stunning them for few seconds. He then transforms his hammer into a cannon, increasing his attack range by 3 hexes and gaining max attack speed for few attacks.",
                "manaCost": 50,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [200, 350, 500],
                    "Stun Duration": ["2.5s", "4.25s", "6s"],
                    "Attacks": [3, 5, 7]
                ]
            ],
            "champStats": [
                "armor": 35,
                "attackDamage": 55,
                "attackSpeed": 0.7,
                "health": 600,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Jinx
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Jinx").setData([
            "key": "Jinx",
            "name": "Jinx",
            "cost": 4,
            "origins": ["Hextech"],
            "classes": ["Gunslinger"],
            "tier": 3,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "rapidfirecannon",
                "bloodthirster",
                "redbuff"
            ],
            "ability": [
                "name": "Get Excited!",
                "key": "Jinx_Passive",
                "active": false,
                "description": "Jinx gets excited as she participates in kills. On her first takedown, she gains attack speed. On her second, she swaps to her rocket launcher causing her attacks to deal bonus area damage.",
                "manaCost": nil,
                "manaStart": nil,
                "abilityStats": [
                    "Damage": [100, 200, 300],
                    "Attack Speed": ["60%", "80%", "100%"]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 75,
                "attackSpeed": 0.7,
                "health": 550,
                "magicResist": 20,
                "range": 3
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Kai'sa
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Kai'sa").setData([
            "key": "Kaisa",
            "name": "Kai'Sa",
            "cost": 5,
            "origins": ["Void"],
            "classes": ["Assassin", "Ranger"],
            "tier": 3,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "statikkshiv",
                "rapidfirecannon",
                "guardianangel"
            ],
            "ability": [
                "name": "Killer Instinct",
                "key": "KaisaR",
                "active": true,
                "description": "Kai'Sa dashes to the farthest enemy unit, gaining a damage shield and Attack Speed for 3 seconds.",
                "manaCost": 125,
                "manaStart": 50,
                "abilityStats": [
                    "Attack Speed": ["30%", "60%", "90%"],
                    "Shield Amount": [300, 600, 900]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 55,
                "attackSpeed": 1.25,
                "health": 700,
                "magicResist": 20,
                "range": 2
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Karthus
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Karthus").setData([
            "key": "Karthus",
            "name": "Karthus",
            "cost": 5,
            "origins": ["Phantom"],
            "classes": ["Sorcerer"],
            "tier": 1,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "morellonomicon",
                "rabadonsdeathcap",
                "seraphsembrace"
            ],
            "ability": [
                "name": "Requiem",
                "key": "KarthusFallenOne",
                "active": true,
                "description": "Karthus deals damage to a number of random enemies after a long channel.",
                "manaCost": 125,
                "manaStart": 40,
                "abilityStats": [
                    "Damage": [3500, 600, 850],
                    "Targets": [5, 7, 9]
                ]
            ],
            "champStats": [
                "armor": 25,
                "attackDamage": 65,
                "attackSpeed": 0.65,
                "health": 850,
                "magicResist": 20,
                "range": 3
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Kassadin
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Kassadin").setData([
            "key": "Kassadin",
            "name": "Kassadin",
            "cost": 1,
            "origins": ["Void"],
            "classes": ["Sorcerer"],
            "tier": 3,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "guinsoosrageblade",
                "rapidfirecannon",
                "bloodthirster"
            ],
            "ability": [
                "name": "Nether Blade",
                "key": "NetherBlade",
                "active": false,
                "description": "Kassadin's attacks steal mana from enemies, converting it into a shield.",
                "manaCost": nil,
                "manaStart": nil,
                "abilityStats": [
                    "Shield Duration": ["4s"],
                    "Mana Steal": [25, 50, 75]
                ]
            ],
            "champStats": [
                "armor": 35,
                "attackDamage": 40,
                "attackSpeed": 0.55,
                "health": 550,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Katarina
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Katarina").setData([
            "key": "Katarina",
            "name": "Katarina",
            "cost": 3,
            "origins": ["Imperial"],
            "classes": ["Assassin"],
            "tier": 1,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "morellonomicon",
                "rabadonsdeathcap",
                "seraphsembrace"
            ],
            "ability": [
                "name": "Death Lotus",
                "key": "KatarinaR",
                "active": true,
                "description": "Katarina channels and fires daggers at a number of nearby enemies, dealing damage and reducing healing.",
                "manaCost": 85,
                "manaStart": 0,
                "abilityStats": [
                    "Damage Per Tick": [45, 70, 95],
                    "Channel Duration": ["2.5s"],
                    "Grievous Wounds Duration": ["3s"],
                    "Targets": [4, 6, 8]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 65,
                "attackSpeed": 0.6,
                "health": 450,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Kayle
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Kayle").setData([
            "key": "Kayle",
            "name": "Kayle",
            "cost": 5,
            "origins": ["Noble"],
            "classes": ["Knight"],
            "tier": 1,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "spearofshojin",
                "guinsoosrageblade",
                "bloodthirster"
            ],
            "ability": [
                "name": "Divine Judgement",
                "key": "KayleR",
                "active": true,
                "description": "Kayle shields an ally, making them immune to damage.",
                "manaCost": 125,
                "manaStart": 0,
                "abilityStats": [
                    "Shield Duration": ["2s", "2.5s", "3s"],
                    "Extra Targets": [0, 1, 2]
                ]
            ],
            "champStats": [
                "armor": 40,
                "attackDamage": 60,
                "attackSpeed": 1,
                "health": 750,
                "magicResist": 20,
                "range": 3
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Kennen
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Kennen").setData([
            "key": "Kennen",
            "name": "Kennen",
            "cost": 3,
            "origins": ["Ninja", "Yordle"],
            "classes": ["Elementalist"],
            "tier": 1,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "morellonomicon",
                "guardianangel",
                "hextechgunblade"
            ],
            "ability": [
                "name": "Slicing Maelstrom",
                "key": "KennenShurikenStorm",
                "active": true,
                "description": "Kennen summons a storm around him, dealing damage and stunning enemies inside of it.",
                "manaCost": 150,
                "manaStart": 50,
                "abilityStats": [
                    "Damage": [225, 450, 675],
                    "Stun Duration": ["1.25s"]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 65,
                "attackSpeed": 0.65,
                "health": 550,
                "magicResist": 20,
                "range": 2
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Kha'Zix
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Kha'Zix").setData([
            "key": "Khazix",
            "name": "Kha'Zix",
            "cost": 1,
            "origins": ["Void"],
            "classes": ["Assassin"],
            "tier": 3,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "spearofshojin",
                "hextechgunblade",
                "guardianangel"
            ],
            "ability": [
                "name": "Taste their Fear",
                "key": "KhazixQ",
                "active": true,
                "description": "Kha'Zix slashes the closest enemy, dealing bonus damage to enemies that are alone.",
                "manaCost": 65,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [150, 250, 350],
                    "Isolation Damage": [400, 600, 800]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 55,
                "attackSpeed": 0.6,
                "health": 500,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Kindred
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Kindred").setData([
            "key": "Kindred",
            "name": "Kindred",
            "cost": 4,
            "origins": ["Phantom"],
            "classes": ["Ranger"],
            "tier": 1,
            "patched": "no",
            "bestItems": [
                "guardianangel",
                "spearofshojin",
                "statikkshiv"
            ],
            "ability": [
                "name": "Lamb's Respite",
                "key": "LambsRespite",
                "active": true,
                "description": "Kindred creates a zone around herself that prevents allies from dying.",
                "manaCost": 150,
                "manaStart": 50,
                "abilityStats": [
                    "Duration": ["3s", "4s", "5s"],
                    "Minimum HP": [300, 600, 900]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 60,
                "attackSpeed": 0.7,
                "health": 600,
                "magicResist": 20,
                "range": 3
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Leona
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Leona").setData([
            "key": "Leona",
            "name": "Leona",
            "cost": 4,
            "origins": ["Noble"],
            "classes": ["Guardian"],
            "tier": 2,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "warmogsarmor",
                "dragonsclaw",
                "thornmail"
            ],
            "ability": [
                "name": "Solar Flare",
                "key": "LeonaSolarFlare",
                "active": true,
                "description": "Leona calls down a solar ray, stunning enemies in the center and dealing damage to enemies inside it.",
                "manaCost": 100,
                "manaStart": 50,
                "abilityStats": [
                    "Damage": [175, 250, 325],
                    "Stun Duration": ["5s", "7s", "9s"],
                    "Stun Delay": ["0.625s"]
                ]
            ],
            "champStats": [
                "armor": 100,
                "attackDamage": 45,
                "attackSpeed": 0.55,
                "health": 750,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Lissandra
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Lissandra").setData([
            "key": "Lissandra",
            "name": "Lissandra",
            "cost": 2,
            "origins": ["Glacial"],
            "classes": ["Elementalist"],
            "tier": 3,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "morellonomicon",
                "seraphsembrace",
                "serpahsembrace"
            ],
            "ability": [
                "name": "Frozen Tomb",
                "key": "LissandraR",
                "active": true,
                "description": "Lissandra encases the target in ice, dealing damage to nearby enemies. Below half HP, Lissandra instead encases herself, becoming untargetable.",
                "manaCost": 85,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [175, 325, 475],
                    "Enemy Stun Duration": ["1.5s"],
                    "Untargetable Duration": ["2s"],
                    "Slow Duration": ["3s"],
                    "Slow Field Duration": ["3s"]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 40,
                "attackSpeed": 0.6,
                "health": 500,
                "magicResist": 20,
                "range": 3
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Lucian
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Lucian").setData([
            "key": "Lucian",
            "name": "Lucian",
            "cost": 2,
            "origins": ["Noble"],
            "classes": ["Gunslinger"],
            "tier": 1,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "lundensecho",
                "guinsoosrageblade",
                "spearofshojin"
            ],
            "ability": [
                "name": "Relentless Pursuit",
                "key": "LucianE",
                "active": true,
                "description": "Lucian dashes away to safety and attacks an enemy twice, once with Attack Damage and once with Spell Damage.",
                "manaCost": 35,
                "manaStart": 0,
                "abilityStats": [
                    "Second Shot Damage": [100, 225, 350]
                ]
            ],
            "champStats": [
                "armor": 25,
                "attackDamage": 65,
                "attackSpeed": 0.65,
                "health": 600,
                "magicResist": 20,
                "range": 3
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Lulu
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Lulu").setData([
            "key": "Lulu",
            "name": "Lulu",
            "cost": 2,
            "origins": ["Yordle"],
            "classes": ["Sorcerer"],
            "tier": 2,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "spearofshojin",
                "spearofshojin",
                "searaphsembrace"
            ],
            "ability": [
                "name": "Wild Growth",
                "key": "LuluR",
                "active": true,
                "description": "Lulu grants an ally bonus Health, knocking up enemies near them.",
                "manaCost": 150,
                "manaStart": 0,
                "abilityStats": [
                    "Bonus HP": [300, 400, 500],
                    "Extra Targets": [0, 1, 2],
                    "Duration": ["6s"],
                    "Knockup Duration": ["1.25s"]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 50,
                "attackSpeed": 0.6,
                "health": 500,
                "magicResist": 20,
                "range": 2
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Miss Fortune
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("MissFortune").setData([
            "key": "MissFortune",
            "name": "Miss Fortune",
            "cost": 5,
            "origins": ["Pirate"],
            "classes": ["Gunslinger"],
            "tier": 2,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "seraphsembrace",
                "rabadonsdeathcap",
                "morellonomicon"
            ],
            "ability": [
                "name": "Bullet Time",
                "key": "MissFortuneBulletTime",
                "active": true,
                "description": "Miss Fortune channels and fires several waves of bullets in a cone.",
                "manaCost": 150,
                "manaStart": 0,
                "abilityStats": [
                    "Channel Duration": ["3s"],
                    "Total Damage": [1300, 2000, 2700]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 75,
                "attackSpeed": 0.95,
                "health": 750,
                "magicResist": 20,
                "range": 3
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Mordekaiser
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Mordekasier").setData([
            "key": "Mordekaiser",
            "name": "Mordekaiser",
            "cost": 1,
            "origins": ["Phantom"],
            "classes": ["Knight"],
            "tier": 4,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "warmogsarmor",
                "thornmail",
                "dragonsclaw"
            ],
            "ability": [
                "name": "Obliterate",
                "key": "MordekaiserQ",
                "active": true,
                "description": "Mordekaiser slams his mace in front him, dealing damage in a line.",
                "manaCost": 150,
                "manaStart": 50,
                "abilityStats": [
                    "Damage": [250, 500, 750]
                ]
            ],
            "champStats": [
                "armor": 40,
                "attackDamage": 50,
                "attackSpeed": 0.5,
                "health": 550,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Morgana
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Morgana").setData([
            "key": "Morgana",
            "name": "Morgana",
            "cost": 3,
            "origins": ["Demon"],
            "classes": ["Sorcerer"],
            "tier": 2,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "morellonomicon",
                "rabadonsdeathcap",
                "seraphsembrace"
            ],
            "ability": [
                "name": "Soul Shackles",
                "key": "MorganaR",
                "active": true,
                "description": "Morgana fires chains to nearby enemies, dealing damage and stunning after a short delay if they are still nearby.",
                "manaCost": 150,
                "manaStart": 50,
                "abilityStats": [
                    "Damage": [175, 300, 425],
                    "Chain Duration": ["3s"],
                    "Stun Duration": ["2s", "4s", "6s"]
                ]
            ],
            "champStats": [
                "armor": 30,
                "attackDamage": 50,
                "attackSpeed": 0.6,
                "health": 650,
                "magicResist": 20,
                "range": 2
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Nidalee
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Nidalee").setData([
            "key": "Nidalee",
            "name": "Nidalee",
            "cost": 1,
            "origins": ["Wild"],
            "classes": ["Shapeshifter"],
            "tier": 4,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "rapidfirecannon",
                "guinsoosrageblade",
                "statikkshiv"
            ],
            "ability": [
                "name": "Primal Surge",
                "key": "PrimalSurge",
                "active": true,
                "description": "Nidalee heals herself and two allies, then transforms",
                "manaCost": 85,
                "manaStart": 0,
                "abilityStats": [
                    "HoT Total Heal": [150, 225, 600],
                    "HoT Duration": ["6s"],
                    "Transform Damage": [20, 65, 120]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 50,
                "attackSpeed": 0.65,
                "health": 500,
                "magicResist": 20,
                "range": 3
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Pantheon
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Pantheon").setData([
            "key": "Pantheon",
            "name": "Pantheon",
            "cost": 5,
            "origins": ["Dragon"],
            "classes": ["Guardian"],
            "tier": 1,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "spearofshojin",
                "frozenheart",
                "warmogsarmor"
            ],
            "ability": [
                "name": "Grand Starfall",
                "key": "PantheonR",
                "active": true,
                "description": "Pantheon leaps in the air, becomes untargetable, and crashes down towards the farthest enemy stunning them. As he lands, Pantheon deals magic damage to all enemies in his path based of their Maximum Health. They then burn for an additional percentage of their Maximum Health as True Damage over a few seconds and applies Grievous Wounds.",
                "manaCost": 200,
                "manaStart": 150,
                "abilityStats": [
                    "Max HP Damage": ["10%", "20%", "30%"],
                    "Stun Duration": ["2s"]
                ]
            ],
            "champStats": [
                "armor": 80,
                "attackDamage": 75,
                "attackSpeed": 0.75,
                "health": 850,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Poppy
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Poppy").setData([
            "key": "Poppy",
            "name": "Poppy",
            "cost": 3,
            "origins": ["Yordle"],
            "classes": ["Knight"],
            "tier": 3,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "thornmail",
                "dragonsclaw",
                "warmogsarmor"
            ],
            "ability": [
                "name": "Keeper's Verdict",
                "key": "PoppyR",
                "active": true,
                "description": "Poppy brings down her hammer, knocking away nearby enemies.",
                "manaCost": 75,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [300, 500, 700],
                    "Knock Duration": ["1s"],
                    "Stun Duration": ["2s"],
                    "Number of Targets Hit": [1, 2, 3]
                ]
            ],
            "champStats": [
                "armor": 40,
                "attackDamage": 50,
                "attackSpeed": 0.5,
                "health": 800,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Pyke
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Pyke").setData([
            "key": "Pyke",
            "name": "Pyke",
            "cost": 2,
            "origins": ["Pirate"],
            "classes": ["Assassin"],
            "tier": 2,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "frozenheart",
                "spearofshojin",
                "morelonomicon"
            ],
            "ability": [
                "name": "Phantom Undertow",
                "key": "PykeE",
                "active": true,
                "description": "Pyke dashes behind the furthest enemy, creating an afterimage that stuns enemies it passes through.",
                "manaCost": 125,
                "manaStart": 50,
                "abilityStats": [
                    "Damage": [150, 200, 250],
                    "Stun Duration": ["1.5s", "2s", "2.5s"],
                    "Stun Delay": ["1s"]
                ]
            ],
            "champStats": [
                "armor": 25,
                "attackDamage": 60,
                "attackSpeed": 0.6,
                "health": 600,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Rek'Sai
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Rek'Sai").setData([
            "key": "RekSai",
            "name": "Rek'Sai",
            "cost": 2,
            "origins": ["Void"],
            "classes": ["Brawler"],
            "tier": 3,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "spearofshojin",
                "warmogsarmor",
                "dragonsclaw"
            ],
            "ability": [
                "name": "Burrow",
                "key": "RekSaiW",
                "active": true,
                "description": "Rek'Sai burrows for a short duration becoming untargetable and healing. When Rek'Sai unburrows she deals damage and knocks up the closest enemy.",
                "manaCost": 150,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [200, 350, 500],
                    "Heal Amount": [150, 300, 450],
                    "Burrow Duration": ["1s"],
                    "Knockup Duration": ["1.75s"]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 50,
                "attackSpeed": 0.6,
                "health": 650,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Rengar
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Rengar").setData([
            "key": "Rengar",
            "name": "Rengar",
            "cost": 3,
            "origins": ["Wild"],
            "classes": ["Assassin"],
            "tier": 1,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "bloodthirster",
                "rapidfirecannon",
                "guardianangel"
            ],
            "ability": [
                "name": "Savgery",
                "key": "RengarQ",
                "active": true,
                "description": "Rengar leaps to the weakest enemy and stabs them.",
                "manaCost": 75,
                "manaStart": 0,
                "abilityStats": [
                    "Damage Multiplier": [2.1, 3.2, 4.3],
                    "Attack Speed": ["30%", "50%", "70%"],
                    "Crit Chance": ["25%"],
                    "Buff Duration": ["6s"]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 70,
                "attackSpeed": 0.6,
                "health": 550,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Sejuani
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Sejuani").setData([
            "key": "Sejuani",
            "name": "Sejuani",
            "cost": 4,
            "origins": ["Glacial"],
            "classes": ["Knight"],
            "tier": 0,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "morellonomicon",
                "warmogsarmor",
                "guardianangel"
            ],
            "ability": [
                "name": "Glacial Prison",
                "key": "SejuaniR",
                "active": true,
                "description": "Sejuani creates a large glacial storm, stunning enemies within it after a short delay.",
                "manaCost": 150,
                "manaStart": 50,
                "abilityStats": [
                    "Damage": [100, 175, 250],
                    "Stun Duration": ["2s", "3.5s", "5s"]
                ]
            ],
            "champStats": [
                "armor": 40,
                "attackDamage": 45,
                "attackSpeed": 0.55,
                "health": 800,
                "magicResist": 25,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Shen
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Shen").setData([
            "key": "Shen",
            "name": "Shen",
            "cost": 2,
            "origins": ["Ninja"],
            "classes": ["Blademaster"],
            "tier": 3,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "warmogsarmor",
                "dragonsclaw",
                "thornmail"
            ],
            "ability": [
                "name": "Spirit's Refuge",
                "key": "ShenW",
                "active": true,
                "description": "Shen creates a zone around himself, allowing allies to dodge all attacks.",
                "manaCost": 150,
                "manaStart": 100,
                "abilityStats": [
                    "Zone Duration": ["3s", "4s", "5s"]
                ]
            ],
            "champStats": [
                "armor": 30,
                "attackDamage": 65,
                "attackSpeed": 0.7,
                "health": 700,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Shyvana
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Shyvana").setData([
            "key": "Shyvana",
            "name": "Shyvana",
            "cost": 3,
            "origins": ["Dragon"],
            "classes": ["Shapeshifter"],
            "tier": 0,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "hextechgunblade",
                "phantomdancer",
                "warmogsarmor"
            ],
            "ability": [
                "name": "Dragon's Descent",
                "key": "ShyvanaTransformCast",
                "active": true,
                "description": "Shyvana dashes away and transforms. While transformed, Shyvana's attacks become ranged and light the ground on fire.",
                "manaCost": 85,
                "manaStart": 0,
                "abilityStats": [
                    "Bonus Attack Damage": [100, 150, 200],
                    "Burn Damage": [200, 300, 400]
                ]
            ],
            "champStats": [
                "armor": 30,
                "attackDamage": 50,
                "attackSpeed": 0.7,
                "health": 650,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Swain
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Swain").setData([
            "key": "Swain",
            "name": "Swain",
            "cost": 5,
            "origins": ["Imperial", "Demon"],
            "classes": ["Shapeshifter"],
            "tier": 0,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "morellonomicon",
                "guardianangel",
                "dragonsclaw"
            ],
            "ability": [
                "name": "Demonflare",
                "key": "SwainR",
                "active": true,
                "description": "Swain transforms, draining health from all nearby enemies.",
                "manaCost": 100,
                "manaStart": 0,
                "abilityStats": [
                    "Damage Per Tick": [40, 80, 120],
                    "Heal Per Tick": [30, 60, 90],
                    "Transform Duration": ["6s"]
                ]
            ],
            "champStats": [
                "armor": 25,
                "attackDamage": 65,
                "attackSpeed": 0.65,
                "health": 850,
                "magicResist": 20,
                "range": 2
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Tristana
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Tristana").setData([
            "key": "Tristana",
            "name": "Tristana",
            "cost": 1,
            "origins": ["Yordle"],
            "classes": ["Gunslinger"],
            "tier": 4,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "rapidfirecannon",
                "redbuff",
                "giantslayer"
            ],
            "ability": [
                "name": "Explosion Charge",
                "key": "TristanaE",
                "active": true,
                "description": "Tristana places a bomb on her current target that detonates after 4 attacks, damaging nearby enemies.",
                "manaCost": 50,
                "manaStart": 0,
                "abilityStats": [
                    "Charge Damage": [70, 110, 150],
                    "Charge Duration": ["4s"]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 50,
                "attackSpeed": 0.65,
                "health": 500,
                "magicResist": 20,
                "range": 4
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Twisted Fate
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("TwistedFate").setData([
            "key": "TwistedFate",
            "name": "Twisted Fate",
            "cost": 2,
            "origins": ["Pirate"],
            "classes": ["Sorcerer"],
            "tier": 3,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "statikkshiv",
                "guinsoosrageblade",
                "seraphsembrace"
            ],
            "ability": [
                "name": "Pick a Card",
                "key": "PickACard",
                "active": true,
                "description": "Twisted Fate throws a card that either stuns, deals damage around his target, or restores mana to himself and nearby allies.",
                "manaCost": 50,
                "manaStart": 0,
                "abilityStats": [
                    "Red Card AoE Damage": [150, 250, 350],
                    "Yellow Card Stun Duration": ["2s", "3s", "4s"],
                    "Blue Card Mana Restore": [30, 50, 70]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 40,
                "attackSpeed": 0.7,
                "health": 500,
                "magicResist": 20,
                "range": 3
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Varus
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Varus").setData([
            "key": "Varus",
            "name": "Varus",
            "cost": 2,
            "origins": ["Demon"],
            "classes": ["Ranger"],
            "tier": 2,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "spearofshojin",
                "guinsoosrageblade",
                "statikkshiv"
            ],
            "ability": [
                "name": "Piercing Arrow",
                "key": "VarusQ",
                "active": true,
                "description": "Varus charges and fires an arrow, dealing damage to all enemies in a line.",
                "manaCost": 75,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [300, 550, 800],
                    "Cast Time": ["1.5s"]
                ]
            ],
            "champStats": [
                "armor": 25,
                "attackDamage": 50,
                "attackSpeed": 0.7,
                "health": 500,
                "magicResist": 20,
                "range": 4
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Vayne
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Vayne").setData([
            "key": "Vayne",
            "name": "Vayne",
            "cost": 1,
            "origins": ["Noble"],
            "classes": ["Ranger"],
            "tier": 3,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "rapidfirecannon",
                "guinsoosrageblade",
                "guinsoosrageblade"
            ],
            "ability": [
                "name": "Silver Bolts",
                "key": "VayneSilveredBolts",
                "active": false,
                "description": "Vayne deals bonus true damage every third attack based on the enemy's maximum health.",
                "manaCost": nil,
                "manaStart": nil,
                "abilityStats": [
                    "Max HP Damage": ["8%", "12%", "16%"]
                ]
            ],
            "champStats": [
                "armor": 25,
                "attackDamage": 40,
                "attackSpeed": 0.7,
                "health": 550,
                "magicResist": 20,
                "range": 3
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Veigar
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Veigar").setData([
            "key": "Veigar",
            "name": "Veigar",
            "cost": 3,
            "origins": ["Yordle"],
            "classes": ["Sorcerer"],
            "tier": 3,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "seraphsembrace",
                "ludensecho",
                "spearofshojin"
            ],
            "ability": [
                "name": "Primordial Burst",
                "key": "VeigarR",
                "active": true,
                "description": "Veigar blasts an enemy with magical energy. This spell instantly kills if the enemy is a lower star level than Veigar.",
                "manaCost": 75,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [650, 650, 950]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 45,
                "attackSpeed": 0.55,
                "health": 500,
                "magicResist": 20,
                "range": 3
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Vi
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Vi").setData([
            "key": "Vi",
            "name": "Vi",
            "cost": 3,
            "origins": ["Hextech"],
            "classes": ["Brawler"],
            "tier": 2,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "morellonomicon",
                "spearofshojin",
                "warmogsarmor"
            ],
            "ability": [
                "name": "Assault and Battery",
                "key": "ViR",
                "active": true,
                "description": "Vi charges down the furthest enemy, knocking aside anyone in her way. When she reaches her target she deals magic damage and knocks them up. Other enemies knocked aside take the same damage.",
                "manaCost": 150,
                "manaStart": 75,
                "abilityStats": [
                    "Damage": [300, 500, 700],
                    "Stun Duration": ["2s", "2.5s", "3s"]
                ]
            ],
            "champStats": [
                "armor": 25,
                "attackDamage": 55,
                "attackSpeed": 0.65,
                "health": 700,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Volibear
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Volibear").setData([
            "key": "Volibear",
            "name": "Volibear",
            "cost": 3,
            "origins": ["Glacial"],
            "classes": ["Brawler"],
            "tier": 2,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "rapidfirecannon",
                "warmogsarmor",
                "redbuff"
            ],
            "ability": [
                "name": "Thunder Claws",
                "key": "VolibearR",
                "active": true,
                "description": "Volibear's attacks bounce between enemies.",
                "manaCost": 75,
                "manaStart": 0,
                "abilityStats": [
                    "Chain Damage Multiplier": ["80%", "90%", "100%"],
                    "Bounces": [3, 4, 5]
                ]
            ],
            "champStats": [
                "armor": 30,
                "attackDamage": 70,
                "attackSpeed": 0.6,
                "health": 750,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Warwick
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Warwick").setData([
            "key": "Warwick",
            "name": "Warwick",
            "cost": 1,
            "origins": ["Wild"],
            "classes": ["Brawler"],
            "tier": 4,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "frozenheart",
                "cursedblade",
                "warmogsarmor"
            ],
            "ability": [
                "name": "Infinite Duress",
                "key": "WarwickR",
                "active": true,
                "description": "Warwaick pounces onto the lowest health enemy, stunning and damaging them.",
                "manaCost": 150,
                "manaStart": 50,
                "abilityStats": [
                    "Damage": [150, 225, 300]
                ]
            ],
            "champStats": [
                "armor": 30,
                "attackDamage": 50,
                "attackSpeed": 0.6,
                "health": 650,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Yasuo
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Yasuo").setData([
            "key": "Yasuo",
            "name": "Yasuo",
            "cost": 5,
            "origins": ["Exile"],
            "classes": ["Blademaster"],
            "tier": 0,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "redbuff",
                "guardianangel",
                "morellonomicon"
            ],
            "ability": [
                "name": "Steel Tempest",
                "key": "YasuoQ1Wrapper",
                "active": true,
                "description": "Yasuo stabs forward dealing damage. On third cast, Yasuo launches a tornado dealing damage and knocking up enemies in a line.",
                "manaCost": 20,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [150, 350, 550],
                    "Range": [2],
                    "Empowered Range": [4],
                    "Knockup Duration": ["1.5s"]
                ]
            ],
            "champStats": [
                "armor": 35,
                "attackDamage": 75,
                "attackSpeed": 1,
                "health": 750,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Zed
        Firestore.firestore().fetchDocuments(from: set1, in: teamComp).document("Zed").setData([
            "key": "Zed",
            "name": "Zed",
            "cost": 2,
            "origins": ["Ninja"],
            "classes": ["Assassin"],
            "tier": 2,
            "patched": "no",
            "set": [1],
            "bestItems": [
                "rapidfirecannon",
                "infinityedge",
                "guardianangel"
            ],
            "ability": [
                "name": "Razor Shuriken",
                "key": "ZedQ",
                "active": true,
                "description": "Zed fires a shuriken in a line, damaging enemies it passes through.",
                "manaCost": 75,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [200, 350, 500],
                    "Range": [4]
                ]
            ],
            "champStats": [
                "armor": 25,
                "attackDamage": 65,
                "attackSpeed": 0.7,
                "health": 550,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                print("Set One All Done")
            }
        }
    }

    //MARK:- setTwoChamps
    @objc func setTwoChamps() {
        print("Adding Set Two Champions")

        //MARK: Aatrox
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Aatrox").setData([
            "key": "Aatrox",
            "name": "Aatrox",
            "cost": 3,
            "origins": ["Light"],
            "classes": ["Blademaster"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "hextechgunblade",
                "dragonsclaw",
                "guardianangel"
            ],
            "ability": [
                "name": "The Darkin Blade",
                "key": "AatroxQ",
                "active": true,
                "description": "Aatrox cleaves the area in front of him, dealing damage to enemies inside it.",
                "manaCost": 75,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [250, 500, 750]
                ]
            ],
            "champStats": [
                "armor": 35,
                "attackDamage": 65,
                "attackSpeed": 0.65,
                "health": 700,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Annie
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Annie").setData([
            "key": "Annie",
            "name": "Annie",
            "cost": 4,
            "origins": ["Inferno"],
            "classes": ["Summoner"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "seraphsembrace"
            ],
            "ability": [
                "name": "Summon Tibbers",
                "key": "AnnieR",
                "active": true,
                "description": "Annie summons Tibbers to fight alongside her dealing damage to enemies in the area.",
                "manaCost": 75,
                "manaStart": 0,
                "abilityStats": [
                    "Area Damage": [100, 200, 300],
                    "Tibber's Damage": [150, 300, 999],
                    "Tibber's Health": [0, 0, 0]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 45,
                "attackSpeed": 0.70,
                "health": 700,
                "magicResist": 20,
                "range": 3
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Ashe
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Ashe").setData([
            "key": "Ashe",
            "name": "Ashe - FIX",
            "cost": 4,
            "origins": ["Crystal"],
            "classes": ["Ranger"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "statikkshiv",
                "guinsoosrageblade",
                "statikkshiv"
            ],
            "ability": [
                "name": "Ranger's Focus",
                "key": "AsheQ",
                "active": true,
                "description": "For 5 seconds, Ashe gains 50% Attack Speed, and her basic attacks fire a flurry of arrows dealing physical damage.",
                "manaCost": 125,
                "manaStart": 0,
                "abilityStats": [
                    "Attack speed": ["50%", "75%", "100%"],
                    "Damage Per Arrow": ["50%", "85%", "120%"],
                    "Damage Total": ["250%", "420%", "600%"]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 65,
                "attackSpeed": 0.7,
                "health": 550,
                "magicResist": 20,
                "range": 4
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Azir
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Azir").setData([
            "key": "Azir",
            "name": "Azir - FIX",
            "cost": 3,
            "origins": ["Desert"],
            "classes": ["Summoner"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "guinsoosrageblade",
                "spearofshojin",
                "spearofshojin"
            ],
            "ability": [
                "name": "Arise",
                "key": "AzirW",
                "active": true,
                "description": "Azir summons a Sand Soldier for 6 seconds. When Azir attacks an enemy in a soldier's range, the soldier attacks as well.",
                "manaCost": 100,
                "manaStart": 75,
                "abilityStats": [
                    "Damage": [90, 180, 270]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 55,
                "attackSpeed": 0.8,
                "health": 600,
                "magicResist": 20,
                "range": 3
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Brand
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Brand").setData([
            "key": "Brand",
            "name": "Brand - FIX",
            "cost": 4,
            "origins": ["Inferno"],
            "classes": ["Mage"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "rabadansdeathcap",
                "guinsosrageblade",
                "spearofshojin"
            ],
            "ability": [
                "name": "Pyroclasm",
                "key": "BrandR",
                "active": true,
                "description": "Brand launches a bouncing fireball, damaging enemies hit.",
                "manaCost": 150,
                "manaStart": 50,
                "abilityStats": [
                    "Damage": [250, 450, 650],
                    "Bounces": [4, 6, 20]
                ]
            ],
            "champStats": [
                "armor": 25,
                "attackDamage": 60,
                "attackSpeed": 0.6,
                "health": 700,
                "magicResist": 20,
                "range": 3
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Braum
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Braum").setData([
            "key": "Braum",
            "name": "Braum",
            "cost": 2,
            "origins": ["Glacial"],
            "classes": ["Warden"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "thornmail",
                "thornmail",
                "warmogsarmor"
            ],
            "ability": [
                "name": "Unbreakable",
                "key": "BraumE",
                "active": true,
                "description": "Braum gains a barrier that reduces incoming damage.",
                "manaCost": 75,
                "manaStart": 0,
                "abilityStats": [
                    "Damage Reduction": ["70%", "80%", "90%"],
                    "Duration": ["4s"]
                ]
            ],
            "champStats": [
                "armor": 75,
                "attackDamage": 40,
                "attackSpeed": 0.6,
                "health": 650,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Diana
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Diana").setData([
            "key": "Diana",
            "name": "Diana - FIX",
            "cost": 2,
            "origins": ["Inferno"],
            "classes": ["Assassin"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "seraphsembrace"
            ],
            "ability": [
                "name": "Pale Cascade",
                "key": "DianaOrbs",
                "active": true,
                "description": "Diana creates 3 orbs that spin around her and explode upon contact with an enemy, dealing magic damage. Additionally, Diane gains a shield for 3 seconds.",
                "manaCost": 100,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [60, 100, 140],
                    "Shield": [150, 250, 350]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 50,
                "attackSpeed": 0.7,
                "health": 550,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Dr Mundo
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("DrMundo").setData([
            "key": "DrMundo",
            "name": "Dr Mundo",
            "cost": 3,
            "origins": ["Poison"],
            "classes": ["Berserker"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "warmogsarmor",
                "warmogsarmor",
                "guardianangel"
            ],
            "ability": [
                "name": "Adrenaline Rush",
                "key": "DrMundo_Passive",
                "active": true,
                "description": "Dr Mundo creates a toxic cloud around him that deals damage to nearby enemies and heals for a portion of the damage every second for 8 seconds.",
                "manaCost": 125,
                "manaStart": 75,
                "abilityStats": [
                    "Damage": [40, 110, 160],
                    "Heal Amount": ["100%", "150%", "200%"]
                ]
            ],
            "champStats": [
                "armor": 35,
                "attackDamage": 55,
                "attackSpeed": 0.6,
                "health": 750,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Ezreal
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Ezreal").setData([
            "key": "Ezreal",
            "name": "Ezreal - FIX",
            "cost": 3,
            "origins": ["Glacial"],
            "classes": ["Ranger"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "hush"
            ],
            "ability": [
                "name": "Mystic Shot",
                "key": "EzrealQ",
                "active": true,
                "description": "Ezreal fires a bolt of energy at the enemy with the lowest health, dealing damage and applying on-hit effects.",
                "manaCost": 40,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [0, 0, 0]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 65,
                "attackSpeed": 0.7,
                "health": 600,
                "magicResist": 20,
                "range": 3
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Ivern
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Ivern").setData([
            "key": "Ivern",
            "name": "Ivern - FIX",
            "cost": 1,
            "origins": ["Forest"],
            "classes": ["Druid"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "seraphsembrace"
            ],
            "ability": [
                "name": "Triggerseed",
                "key": "IvernE",
                "active": true,
                "description": "Ivern grants a shield to the ally with the lowest health.",
                "manaCost": 100,
                "manaStart": 50,
                "abilityStats": [
                    "Shield Amount": [200, 400, 600],
                    "Magic Damage": [40, 60, 160]
                ]
            ],
            "champStats": [
                "armor": 25,
                "attackDamage": 50,
                "attackSpeed": 0.6,
                "health": 600,
                "magicResist": 20,
                "range": 2
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Janna
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Janna").setData([
            "key": "Janna",
            "name": "Janna - FIX",
            "cost": 4,
            "origins": ["Widn"],
            "classes": ["Mystic"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "guardianangel"
            ],
            "ability": [
                "name": "Monsoon",
                "key": "ReapTheWhirlwind",
                "active": true,
                "description": "Janna channels winds which heal allies based on their maximum health and stun nearby enemies for 1 second.",
                "manaCost": 125,
                "manaStart": 75,
                "abilityStats": [
                    "Heal Amount": ["30%", "40%", "80%"]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 45,
                "attackSpeed": 0.7,
                "health": 650,
                "magicResist": 20,
                "range": 3
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Jax
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Jax").setData([
            "key": "Jax",
            "name": "Jax - FIX",
            "cost": 2,
            "origins": ["Light"],
            "classes": ["Berserker"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "titanichydra",
                "dragonsclaw",
                "phantomdancer"
            ],
            "ability": [
                "name": "Counter Strike",
                "key": "JaxCounterStrike",
                "active": true,
                "description": "Jax dodges all incoming attacks for 2 seconds, then strikes nearby enemies, stunning them for 1.5 seconds.",
                "manaCost": 125,
                "manaStart": 50,
                "abilityStats": [
                    "Damage": [150, 250, 350]
                ]
            ],
            "champStats": [
                "armor": 30,
                "attackDamage": 45,
                "attackSpeed": 0.8,
                "health": 650,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Kha'Zix
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Kha'Zix").setData([
            "key": "Khazix",
            "name": "Kha'Zix - FIX",
            "cost": 4,
            "origins": ["Desert"],
            "classes": ["Assassin"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "infintyedge",
                "rapidfirecannon",
                "spearofshojin"
            ],
            "ability": [
                "name": "Void Assault",
                "key": "KhazixR",
                "active": true,
                "description": "Kha'Zix goes stealth and attacks the enemy with the lowest health after a short delay. This attack is a critical hit and restores mana.",
                "manaCost": 65,
                "manaStart": 0,
                "abilityStats": [
                    "Delay": ["2s", "1.25s", "0.5s"],
                    "Mana Restored": [5, 10, 15]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 20,
                "attackSpeed": 0.6,
                "health": 500,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Kindred
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Kindred").setData([
            "key": "Kindred",
            "name": "Kindred - FIX",
            "cost": 3,
            "origins": ["Inferno", "Shadow"],
            "classes": ["Ranger"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "runnanshurricane",
                "giantslayer",
                "guinsoosrageblade"
            ],
            "ability": [
                "name": "Dance of Dread",
                "key": "KindredQ",
                "active": true,
                "description": "Wolf mauls Kindred's target, dealing magic damage and reducing healing by 80% to her target for 5 seconds, while Lamb leaps away from Kindred's target.",
                "manaCost": 35,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [150, 325, 500]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 55,
                "attackSpeed": 0.8,
                "health": 650,
                "magicResist": 20,
                "range": 3
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Kog'Maw
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Kog'Maw").setData([
            "key": "KogMaw",
            "name": "Kog'Maw - FIX",
            "cost": 1,
            "origins": ["Poison"],
            "classes": ["Predator"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "giantslayer"
            ],
            "ability": [
                "name": "Living Artillery",
                "key": "KogMawLivingArtillery",
                "active": true,
                "description": "Kog'Maw fires a living artillery shell at an enemy, dealing damage.",
                "manaCost": 45,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [125, 275, 425]
                ]
            ],
            "champStats": [
                "armor": 02,
                "attackDamage": 25,
                "attackSpeed": 0.65,
                "health": 500,
                "magicResist": 20,
                "range": 4
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: LeBlanc
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("LeBlanc").setData([
            "key": "Leblanc",
            "name": "LeBlanc - FIX",
            "cost": 2,
            "origins": ["Forest"],
            "classes": ["Assassin", "Mage"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "seraphsembrace",
                "ludensecho",
                "morellonomicon"
            ],
            "ability": [
                "name": "Ethereal Chains",
                "key": "LeblancE",
                "active": true,
                "description": "Leblanc flings an illusory chain toward a random enemy, dealing damage and stunning them after 1.5 seconds.",
                "manaCost": 80,
                "manaStart": 50,
                "abilityStats": [
                    "Damage": [200, 450, 700]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 55,
                "attackSpeed": 0.7,
                "health": 550,
                "magicResist": 20,
                "range": 2
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Lux
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Lux").setData([
            "key": "Lux",
            "name": "Lux - FIX",
            "cost": 7,
            "origins": ["Variable"],
            "classes": ["Avatar"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "seraphsembrace",
                "spearofshojin",
                "morellonomicon"
            ],
            "ability": [
                "name": "Final Spark",
                "key": "LuxMaliceCannon",
                "active": true,
                "description": "Lux fires a straight beam of light at enemies. If at least one enemy unit is killed, she restores 50 mana.",
                "manaCost": 100,
                "manaStart": 50,
                "abilityStats": [
                    "Damage": [500, 800, 1100]
                ]
            ],
            "champStats": [
                "armor": 25,
                "attackDamage": 65,
                "attackSpeed": 0.85,
                "health": 850,
                "magicResist": 20,
                "range": 4
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Malphite
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Malphite").setData([
            "key": "Malphite",
            "name": "Malphite - FIX",
            "cost": 4,
            "origins": ["Mountain"],
            "classes": ["Warden"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "dragonsclaw",
                "warmogsarmor",
                "guardianagel"
            ],
            "ability": [
                "name": "Unstoppable Force",
                "key": "UFSlash",
                "active": true,
                "description": "Malphite charges toward a random enemy, dealing damage and knocking all nearby enemies into the air and stunning them.",
                "manaCost": 150,
                "manaStart": 50,
                "abilityStats": [
                    "Damage": [125, 200, 275],
                    "Stun Duration": ["2s", "2.5s", "3s"]
                ]
            ],
            "champStats": [
                "armor": 50,
                "attackDamage": 60,
                "attackSpeed": 0.55,
                "health": 800,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Malzahar
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Malzahar").setData([
            "key": "Malzahar",
            "name": "Malzahar - FIX",
            "cost": 2,
            "origins": ["Shadow"],
            "classes": ["Summoner"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "seraphsembrace"
            ],
            "ability": [
                "name": "Void Swarm",
                "key": "MalzaharW",
                "active": true,
                "description": "Malzahar opens a dark gate summoning dark spirits to fight alongside him.",
                "manaCost": 125,
                "manaStart": 75,
                "abilityStats": [
                    "Number of Spirits": [2, 3, 4],
                    "Spirits Damage": [60, 100, 140]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 40,
                "attackSpeed": 0.65,
                "health": 550,
                "magicResist": 20,
                "range": 3
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Maokai
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Maokai").setData([
            "key": "Maokai",
            "name": "Maokai - FIX",
            "cost": 1,
            "origins": ["Forest"],
            "classes": ["Druid"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "dragonsclaw",
                "warmogsarmor",
                "phantomdancer"
            ],
            "ability": [
                "name": "Sap Magic",
                "key": "Maokai_Passive",
                "active": false,
                "description": "After taking damage from a spell, Maokai's next attack will heal him.",
                "manaCost": nil,
                "manaStart": nil,
                "abilityStats": [
                    "Heal Amount": [100, 200, 300]
                ]
            ],
            "champStats": [
                "armor": 35,
                "attackDamage": 55,
                "attackSpeed": 0.5,
                "health": 650,
                "magicResist": 02,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Master Yi
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("MasterYi").setData([
            "key": "MasterYi",
            "name": "Master Yi - FIX",
            "cost": 5,
            "origins": ["Shadow"],
            "classes": ["Blademaster", "Mystic"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "bloodthirster",
                "guinsoosrageblade",
                "guardianangel"
            ],
            "ability": [
                "name": "Meditate",
                "key": "Meditate",
                "active": true,
                "description": "Master Yi becomes channels for 1.5 seconds, becoming untargetable and recovering health. After that, attacks deal additional magic damage for 6 seconds.",
                "manaCost": 150,
                "manaStart": 100,
                "abilityStats": [
                    "Heal Amount": ["30%"],
                    "Duration": ["1s"],
                    "Attack Speed": ["+100%"],
                    "Extra Damage": [80, 120, 160]
                ]
            ],
            "champStats": [
                "armor": 35,
                "attackDamage": 70,
                "attackSpeed": 1.0,
                "health": 900,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Nami
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Nami").setData([
            "key": "Nami",
            "name": "Nami - FIX",
            "cost": 5,
            "origins": ["Ocean"],
            "classes": ["Mystic"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "seraphsembrace",
                "guardianangel",
                "spearofshojin"
            ],
            "ability": [
                "name": "Tidal Wave",
                "key": "NamiR",
                "active": true,
                "description": "Nami sends a massive wave toward a random enemy, damaging and knocking up enemies it passes through and granting allies it passes through bonus magic damage on hit.",
                "manaCost": 125,
                "manaStart": 50,
                "abilityStats": [
                    "Damage": [0, 0, 0],
                    "Knockup Duration": [0, 0, 0],
                    "Bonus Damage": [0, 0, 0]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 50,
                "attackSpeed": 0.75,
                "health": 800,
                "magicResist": 20,
                "range": 4
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Nasus
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Nasus").setData([
            "key": "Nasus",
            "name": "Nasus - FIX",
            "cost": 1,
            "origins": ["Light"],
            "classes": ["Warden"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "warmogsarmor",
                "warmogsarmor",
                "morellonomicon"
            ],
            "ability": [
                "name": "Fury of the Dawn",
                "key": "NasusR",
                "active": true,
                "description": "Nasus temporarily enrages, gaining bonus health and damaging adjacent enemies each second for the duration.",
                "manaCost": 100,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [0, 0, 0],
                    "Bonus Health": [0, 0, 0],
                    "Duration": [0, 0, 0]
                ]
            ],
            "champStats": [
                "armor": 40,
                "attackDamage": 50,
                "attackSpeed": 0.55,
                "health": 650,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Nautilus
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Nautilus").setData([
            "key": "Nautilus",
            "name": "Nautilus - FIX",
            "cost": 3,
            "origins": ["Ocean"],
            "classes": ["Warden"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "dragonsclaw",
                "warmogsarmor",
                "guardianangel"
            ],
            "ability": [
                "name": "Depth Charge",
                "key": "NautilusGrandLine",
                "active": true,
                "description": "Nautilus sends out a depth charge that seeks out the furthest enemy champion, knocking them up and stunning them. It also deals damage to all enemies it passes.",
                "manaCost": 125,
                "manaStart": 50,
                "abilityStats": [
                    "Damage": [100, 200, 300],
                    "Stun Duration": ["3s", "4s", "5s"]
                ]
            ],
            "champStats": [
                "armor": 40,
                "attackDamage": 55,
                "attackSpeed": 0.6,
                "health": 850,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Neeko
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Neeko").setData([
            "key": "Neeko",
            "name": "Neeko - FIX",
            "cost": 2,
            "origins": ["Forest"],
            "classes": ["Druid"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "serpahsembrace"
            ],
            "ability": [
                "name": "Blooming Burst",
                "key": "NeekoQ",
                "active": true,
                "description": "Neeko propels a seed at a random target. The seed will blossom 3 times, each time with a larger radius, dealing damage to enemies within.",
                "manaCost": 0,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [100, 200, 300]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 45,
                "attackSpeed": 00.7,
                "health": 500,
                "magicResist": 20,
                "range": 2
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Nocturne
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Nocturne").setData([
            "key": "Nocturne",
            "name": "Nocturne - FIX",
            "cost": 3,
            "origins": ["Steel"],
            "classes": ["Assassin"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "giantslayer"
            ],
            "ability": [
                "name": "Steel Blades",
                "key": "Nocturne_UmbraBlades",
                "active": false,
                "description": "Every third attack, Nocturne deals additional damage to enemies around him and heals for a portion of the damage.",
                "manaCost": nil,
                "manaStart": nil,
                "abilityStats": [
                    "Heal Amount": ["75%", "100%", "125%"]
                ]
            ],
            "champStats": [
                "armor": 25,
                "attackDamage": 60,
                "attackSpeed": 0.75,
                "health": 650,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Olaf
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Olaf").setData([
            "key": "Olaf",
            "name": "Olaf - FIX",
            "cost": 4,
            "origins": ["Glacial"],
            "classes": ["Berserke"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "titanichydra",
                "phantomdancer",
                "dragonsclaw"
            ],
            "ability": [
                "name": "Ragnarok",
                "key": "OlafRagnarok",
                "active": true,
                "description": "Olaf gains attack speed, lifesteal based on missing health, and immunity to crowd control for the rest of combat.",
                "manaCost": 100,
                "manaStart": 0,
                "abilityStats": [
                    "Attack Speed": ["75%", "100%", "125%"],
                    "Lifesteal": ["20%", "40%", "60%"]
                ]
            ],
            "champStats": [
                "armor": 30,
                "attackDamage": 70,
                "attackSpeed": 0.8,
                "health": 750,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Ornn
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Ornn").setData([
            "key": "Ornn",
            "name": "Ornn - FIX",
            "cost": 1,
            "origins": ["Electric"],
            "classes": ["Warden"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "dragonsclaw"
            ],
            "ability": [
                "name": "Electrifying Breath",
                "key": "OrnnW",
                "active": true,
                "description": "Ornn unleashes lightning bolts in a cone in front of him, dealing damage and increasing his critical strike chance by 20% for 4 seconds.",
                "manaCost": 75,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [100, 200, 300],
                    "Duration": ["4s"]
                ]
            ],
            "champStats": [
                "armor": 40,
                "attackDamage": 50,
                "attackSpeed": 0.55,
                "health": 650,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Qiyana
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Qiyana").setData([
            "key": "Qiyana",
            "name": "Qiyana - FIX",
            "cost": 3,
            "origins": ["Variable"],
            "classes": ["Assassin"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "infinityedge",
                "guardiangel",
                "bloodthirster"
            ],
            "ability": [
                "name": "Edge of Ixtal",
                "key": "QiyanaE",
                "active": true,
                "description": "Qiyana dashes to the side of her target and throws a blast of wind through them, damaging and stunning enemies it passes through. Qiyana's element will change every match between Forest, Inferno, Ocean, and Wind.",
                "manaCost": 100,
                "manaStart": 50,
                "abilityStats": [
                    "Damage": [0, 0, 0]
                ]
            ],
            "champStats": [
                "armor": 25,
                "attackDamage": 65,
                "attackSpeed": 0.7,
                "health": 650,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Rek'Sai
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Rek'Sai").setData([
            "key": "RekSai",
            "name": "Rek'Sai",
            "cost": 2,
            "origins": ["Steel"],
            "classes": ["Predator"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "giatslayer"
            ],
            "ability": [
                "name": "Furious Bite",
                "key": "RekSaiE",
                "active": true,
                "description": "Rek'Sai bites an enemy dealing true damage.",
                "manaCost": 75,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [200, 550, 900]
                ]
            ],
            "champStats": [
                "armor": 30,
                "attackDamage": 60,
                "attackSpeed": 0.7,
                "health": 650,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }


        //MARK: Renekton
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Renekton").setData([
            "key": "Renekton",
            "name": "Renekton - FIX",
            "cost": 1,
            "origins": ["Desert"],
            "classes": ["Berserker"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "titanichydra",
                "dragonsclaw",
                "phantomdancer"
            ],
            "ability": [
                "name": "Cull the Meek",
                "key": "RenektonCleave",
                "active": true,
                "description": "Renekton swings his blade, dealing damage to nearby enemies and restoring health.",
                "manaCost": 100,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [150, 275, 400],
                    "Health Restored": [150, 250, 350]
                ]
            ],
            "champStats": [
                "armor": 35,
                "attackDamage": 55,
                "attackSpeed": 0.6,
                "health": 600,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Singed
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Singed").setData([
            "key": "Singed",
            "name": "Singed - FIX",
            "cost": 4,
            "origins": ["Poison"],
            "classes": ["Alchemist"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "morellonomicon"
            ],
            "ability": [
                "name": "Poison Trail",
                "key": "PoisonTrail",
                "active": false,
                "description": "Singed leaves a poison cloud behind him damaging enemies in the area over 4 seconds.",
                "manaCost": nil,
                "manaStart": nil,
                "abilityStats": [
                    "Damage": [400, 800, 1200]
                ]
            ],
            "champStats": [
                "armor": 50,
                "attackDamage": 0,
                "attackSpeed": 0.001,
                "health": 1100,
                "magicResist": 100,
                "range": 0
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Sion
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Sion").setData([
            "key": "Sion",
            "name": "Sion - FIX",
            "cost": 3,
            "origins": ["Shadow"],
            "classes": ["Berseker"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "titanichydra",
                "phantomdancer",
                "dragonsclaw"
            ],
            "ability": [
                "name": "Decimating Smash",
                "key": "SionQ",
                "active": true,
                "description": "Sion smashes his axe into the ground after a short delay, dealing damage and knocking up enemies in the area.",
                "manaCost": 50,
                "manaStart": 150,
                "abilityStats": [
                    "Damage": [200, 400, 600]
                ]
            ],
            "champStats": [
                "armor": 30,
                "attackDamage": 25,
                "attackSpeed": 0.65,
                "health": 800,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Sivir
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Sivir").setData([
            "key": "Sivir",
            "name": "Sivir - FIX",
            "cost": 3,
            "origins": ["Desert"],
            "classes": ["Blademaster"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "guinsoosrageblade",
                "hush",
                "giantslayer"
            ],
            "ability": [
                "name": "Ricochet",
                "key": "SivirW",
                "active": true,
                "description": "For the next 5 seconds, Sivir's attacks will bounce up to 10 times to nearby enemies, dealing damage and applying on-hit effects.",
                "manaCost": 65,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": ["100%", "125%", "150%"]
                ]
            ],
            "champStats": [
                "armor": 25,
                "attackDamage": 25,
                "attackSpeed": 0.7,
                "health": 600,
                "magicResist": 20,
                "range": 3
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Skarner
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Skarner").setData([
            "key": "Skarner",
            "name": "Skarner - FIX",
            "cost": 2,
            "origins": ["Crystal"],
            "classes": ["Predator"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "giantslayer"
            ],
            "ability": [
                "name": "Crystalline Exoskeleton",
                "key": "SkarnerExoskeleton",
                "active": true,
                "description": "Skarner is shielded for damage for 8 seconds. While the shield persists, Skarner gains % attack speed.",
                "manaCost": 100,
                "manaStart": 0,
                "abilityStats": [
                    "Shield Amount": [150, 450, 750],
                    "Attack Speed": ["30%", "65%", "100%"]
                ]
            ],
            "champStats": [
                "armor": 30,
                "attackDamage": 25,
                "attackSpeed": 0.65,
                "health": 650,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Soraka
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Soraka").setData([
            "key": "Soraka",
            "name": "Soraka - FIX",
            "cost": 3,
            "origins": ["Light"],
            "classes": ["Mystic"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "serpahsembrace"
            ],
            "ability": [
                "name": "Equinox",
                "key": "SorakaE",
                "active": true,
                "description": "Soraka creates a zone at a random enemy's location, dealing magic damage and preventing mana from being restored to enemies inside.",
                "manaCost": 60,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [150, 300, 450],
                    "Duration": ["3s", "5s", "7s"]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 40,
                "attackSpeed": 0.65,
                "health": 600,
                "magicResist": 20,
                "range": 2
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Syndra
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Syndra").setData([
            "key": "Syndra",
            "name": "Syndra - FIX",
            "cost": 2,
            "origins": ["Ocean"],
            "classes": ["Mage"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "seraphsembrace"
            ],
            "ability": [
                "name": "Hydro Sphere",
                "key": "SyndraQ",
                "active": true,
                "description": "Syndra conjures a Hydro Sphere at a target location that damage enemies.",
                "manaCost": 80,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [0, 0, 0]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 40,
                "attackSpeed": 0.7,
                "health": 500,
                "magicResist": 20,
                "range": 3
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Taliyah
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Taliyah").setData([
            "key": "Taliyah",
            "name": "Taliyah - FIX",
            "cost": 1,
            "origins": ["Mountain"],
            "classes": ["Mage"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "seraphsembrace",
            ],
            "ability": [
                "name": "Seismic Shove",
                "key": "TaliyahWVC",
                "active": true,
                "description": "Taliyah causes the ground to rise under the enemy with the most Mana, dealing damage and either pushing or pulling them toward her.",
                "manaCost": 85,
                "manaStart": 50,
                "abilityStats": [
                    "Damage": [150, 325, 500]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 40,
                "attackSpeed": 0.65,
                "health": 500,
                "magicResist": 20,
                "range": 3
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Taric
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Taric").setData([
            "key": "Taric",
            "name": "Taric - FIX",
            "cost": 5,
            "origins": ["Crystal"],
            "classes": ["Warden"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "thornmail",
                "warmogsarmor",
                "dragonsclaw"
            ],
            "ability": [
                "name": "Cosmic Radiance",
                "key": "TaricR",
                "active": true,
                "description": "After a delay, Taric and all nearby allies become invulnerable for a few seconds.",
                "manaCost": 150,
                "manaStart": 50,
                "abilityStats": [
                    "Duration": ["0s", "0s", "0s"]
                ]
            ],
            "champStats": [
                "armor": 75,
                "attackDamage": 60,
                "attackSpeed": 0.65,
                "health": 950,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Thresh
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Thresh").setData([
            "key": "Thresh",
            "name": "Thresh - FIX",
            "cost": 2,
            "origins": ["Ocean"],
            "classes": ["Warden"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "dragonsclaw",
                "phantomdancer",
                "warmogsarmor"
            ],
            "ability": [
                "name": "Deep Sea Passage",
                "key": "ThreshW",
                "active": true,
                "description": "Thresh throws his lantern to the lowest-health ally, shielding them and nearby allies for a few seconds.",
                "manaCost": 125,
                "manaStart": 50,
                "abilityStats": [
                    "Shield Amount": [0, 0, 0],
                    "Duration": [0, 0, 0]
                ]
            ],
            "champStats": [
                "armor": 40,
                "attackDamage": 55,
                "attackSpeed": 0.55,
                "health": 700,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Twitch
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Twitch").setData([
            "key": "Twitch",
            "name": "Twitch - FIX",
            "cost": 4,
            "origins": ["Poison"],
            "classes": ["Ranger"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "runaanshurricane",
                "guinsoosrageblade",
                "statikkshiv"
            ],
            "ability": [
                "name": "Spray and Pray",
                "key": "TwitchFullAutomatic",
                "active": true,
                "description": "Twitch gains increased damage and unlimited range for 8 seconds.",
                "manaCost": 90,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": ["+100%", "+125%", "+150%"]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 60,
                "attackSpeed": 0.8,
                "health": 650,
                "magicResist": 20,
                "range": 4
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Varus
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Varus").setData([
            "key": "Varus",
            "name": "Varus",
            "cost": 2,
            "origins": ["Inferno"],
            "classes": ["Ranger"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "runnanshurricane",
                "guinsoosrageblade",
                "hush"
            ],
            "ability": [
                "name": "Piercing Arrow",
                "key": "VarusQ",
                "active": true,
                "description": "Varus charges and fires an arrow, dealing damage to all enemies in a line.",
                "manaCost": 100,
                "manaStart": 50,
                "abilityStats": [
                    "Damage": [300, 550, 800],
                    "Cast Time": ["1.5s"]
                ]
            ],
            "champStats": [
                "armor": 25,
                "attackDamage": 60,
                "attackSpeed": 0.75,
                "health": 550,
                "magicResist": 20,
                "range": 4
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Vayne
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Vayne").setData([
            "key": "Vayne",
            "name": "Vayne",
            "cost": 1,
            "origins": ["Light"],
            "classes": ["Ranger"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "runnanshurricane",
                "giantslayer",
                "guinsoosrageblade"
            ],
            "ability": [
                "name": "Silver Bolts",
                "key": "VayneSilveredBolts",
                "active": false,
                "description": "Vayne deals bonus true damage every third attack based on the enemy's maximum health.",
                "manaCost": nil,
                "manaStart": nil,
                "abilityStats": [
                    "Max HP Damage": ["8%", "12%", "16%"]
                ]
            ],
            "champStats": [
                "armor": 25,
                "attackDamage": 40,
                "attackSpeed": 0.75,
                "health": 500,
                "magicResist": 20,
                "range": 3
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Veigar
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Veigar").setData([
            "key": "Veigar",
            "name": "Veigar - FIX",
            "cost": 3,
            "origins": ["Shadow"],
            "classes": ["Mage"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "spearofshojin",
                "spearofshojin",
                "seraphsembrace"
            ],
            "ability": [
                "name": "Primordial Burst",
                "key": "VeigarR",
                "active": true,
                "description": "Veigar blasts an enemy with magical energy, dealing damage. This spell instantly kills if the enemy is a lower star level than Veigar.",
                "manaCost": 75,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [300, 600, 900]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 25,
                "attackSpeed": 0.6,
                "health": 500,
                "magicResist": 20,
                "range": 3
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Vladimir
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Vladimir").setData([
            "key": "Vladimir",
            "name": "Vladimir - FIX",
            "cost": 1,
            "origins": ["Ocean"],
            "classes": ["Mage"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "hextechgunblade"
            ],
            "ability": [
                "name": "Drain",
                "key": "Drain",
                "active": true,
                "description": "Vladimir damages a target enemy, healing himself for the damage dealt.",
                "manaCost": 75,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [0, 0, 0]
                ]
            ],
            "champStats": [
                "armor": 30,
                "attackDamage": 40,
                "attackSpeed": 0.65,
                "health": 550,
                "magicResist": 20,
                "range": 5
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Volibear
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Volibear").setData([
            "key": "Volibear",
            "name": "Volibear - FIX",
            "cost": 2,
            "origins": ["Glacial", "Electric"],
            "classes": ["Berserker"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "titanichydra",
                "dragonsclaw",
                "phantomdancer"
            ],
            "ability": [
                "name": "Frenzy",
                "key": "VolibearW",
                "active": true,
                "description": "Volibear bites an enemy. If the target has less than 35% health, it is killed instantly and Volibear fully restores his mana.",
                "manaCost": 75,
                "manaStart": 0,
                "abilityStats": [
                    "Damage": [200, 450, 700]
                ]
            ],
            "champStats": [
                "armor": 35,
                "attackDamage": 55,
                "attackSpeed": 0.7,
                "health": 650,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Warwick
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Warwick").setData([
            "key": "Warwick",
            "name": "Warwick",
            "cost": 1,
            "origins": ["Glacial"],
            "classes": ["Predator"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "giantslayer",
                "warmogsarmor",
                "titanichydra"
            ],
            "ability": [
                "name": "Infinite Duress",
                "key": "WarwickR",
                "active": true,
                "description": "Warwick pounces onto the lowest health enemy, stunning, damaging, and applying on-hit effects while healing himself.",
                "manaCost": 50,
                "manaStart": 150,
                "abilityStats": [
                    "Damage": [150, 225, 300],
                    "Hits": [3],
                    "Duration": ["1.5s"]
                ]
            ],
            "champStats": [
                "armor": 30,
                "attackDamage": 50,
                "attackSpeed": 0.6,
                "health": 650,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Yasuo
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Yasuo").setData([
            "key": "Yasuo",
            "name": "Yasuo - FIX",
            "cost": 2,
            "origins": ["Wind"],
            "classes": ["Blademaster"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "giantslayer"
            ],
            "ability": [
                "name": "Last Breath",
                "key": "YasuoR",
                "active": true,
                "description": "Yasuo teleports to the enemy with the most items, knocking them up in the air for 1 second and slashing them repeatedly.",
                "manaCost": 25,
                "manaStart": 0,
                "abilityStats": [
                    "Slashes": [3, 5, 7]
                ]
            ],
            "champStats": [
                "armor": 35,
                "attackDamage": 75,
                "attackSpeed": 1.0,
                "health": 750,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Yorick
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Yorick").setData([
            "key": "Yorick",
            "name": "Yorick - FIX",
            "cost": 4,
            "origins": ["Light"],
            "classes": ["Summoner"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "serpahsembrace",
                "guardianangel",
                "dragonsclaw"
            ],
            "ability": [
                "name": "Shepherd of Souls",
                "key": "YorickR",
                "active": true,
                "description": "Yorick blesses his allies with the lowest health, not including Light Walkers. When they die, they resurect as Light Walkers and benefits from the effects of the Light origin.",
                "manaCost": 75,
                "manaStart": 0,
                "abilityStats": [
                    "Ghouls Created": [3, 5, 10],
                    "Ghouls Health":  [1000, 1500, 2000],
                    "Ghouls Attack Damage":  [150, 250, 350]
                ]
            ],
            "champStats": [
                "armor": 35,
                "attackDamage": 65,
                "attackSpeed": 0.7,
                "health": 800,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Zed
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Zed").setData([
            "key": "Zed",
            "name": "Zed - FIX",
            "cost": 5,
            "origins": ["Electric"],
            "classes": ["Assassin", "Summoner"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "infinityedge",
                "rapidfirecannon",
                "guardianangel"
            ],
            "ability": [
                "name": "Living Shadow",
                "key": "ZedW",
                "active": true,
                "description": "Zed creates a clone identical to him behind his current target. This clone can also conjure up a flash, and inherits the items, attributes, and current life of Zed.",
                "manaCost": 150,
                "manaStart": 100,
                "abilityStats": [
                    "Damage": [0, 0, 0]
                ]
            ],
            "champStats": [
                "armor": 30,
                "attackDamage": 80,
                "attackSpeed": 0.9,
                "health": 850,
                "magicResist": 20,
                "range": 1
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        //MARK: Zyra
        Firestore.firestore().fetchDocuments(from: set2, in: teamComp).document("Zyra").setData([
            "key": "Zyra",
            "name": "Zyra - FIX",
            "cost": 1,
            "origins": ["Inferno"],
            "classes": ["Summoner"],
            "tier": 0,
            "patched": "no",
            "set": [2],
            "bestItems": [
                "seraphsembrace"
            ],
            "ability": [
                "name": "Rampant Growth",
                "key": "ZyraE",
                "active": true,
                "description": "Zyra summons two untargettable Flame Spitters on the corners of the arena.",
                "manaCost": 75,
                "manaStart": 0,
                "abilityStats": [
                    "Plants Summoned": [2, 3, 4],
                    "Plant Damage": [08, 100, 120]
                ]
            ],
            "champStats": [
                "armor": 20,
                "attackDamage": 40,
                "attackSpeed": 0.65,
                "health": 500,
                "magicResist": 20,
                "range": 3
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                print("Set Two All Done")
            }
        }
    }
}
