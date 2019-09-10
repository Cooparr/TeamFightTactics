//
//  PatchNotesController.swift
//  TeamFightTactics
//
//  Created by Alex Cooper on 24/07/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class PatchNotesController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = CustomColor.charcoal
        navigationItem.title = "Patch Notes"
        
        
        FirestoreManager.champs.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
        
        
        view.addSubview(nothingButton)
        nothingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nothingButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        nothingButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    let nothingButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Nothing to see.. yet", for: .normal)
        btn.backgroundColor = CustomColor.romanSilver
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 1
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        btn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return btn
    }()
    
    
    @objc func buttonTapped() {
        print(123)
//        FirestoreManager.champs.document("Aatrox").setData([
//            "id": "266",
//            "key": "Aatrox",
//            "name": "Aatrox",
//            "origin": ["Demon"],
//            "class": ["Blademaster"],
//            "cost": 3,
//            "ability": [
//                "name": "The Darkin Blade",
//                "description": "Aatrox cleaves the area in front of him, dealing damage to enemies inside it.",
//                "type": "Active",
//                "manaCost": 75,
//                "manaStart": 0,
//                "stats": [[ "type": "Damage", "value": "300 / 600 / 900" ]]
//            ],
//            "stats": [
//                "offense": [
//                    "damage": 65,
//                    "attackSpeed": 0.65,
//                    "dps": 42,
//                    "range": 1
//                ],
//                "defense": [
//                    "health": 700,
//                    "armor": 25,
//                    "magicResist": 20
//                ]
//            ],
//            "items": [
//                "morellonomicon",
//                "rabadonsdeathcap",
//                "guardianangel"
//            ]
//        ]) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//            }
//        }
//
//
//
//        FirestoreManager.champs.document("Ahri").setData([
//            "id": "103",
//            "key": "Ahri",
//            "name": "Ahri",
//            "cost": 2,
//            "origin": ["Wild"],
//            "class": ["Sorcerer"],
//            "ability": [
//                "name": "Spirit Orb",
//                "description": "Ahri fires an orb in a line that returns to her, damaging enemies it passes through.",
//                "type": "Active",
//                "manaCost": 75,
//                "manaStart": 0,
//                "stats": [[ "type": "Damage", "value": "100 / 200 / 300" ]]
//            ],
//            "stats": [
//                "offense": [
//                    "damage": 50,
//                    "attackSpeed": 0.55,
//                    "dps": 28,
//                    "range": 3
//                ],
//                "defense": [
//                    "health": 450,
//                    "armor": 20,
//                    "magicResist": 20
//                ]
//            ],
//            "items": [
//                "morellonomicon",
//                "guinsoosrageblade",
//                "rabadonsdeathcap"
//            ]
//        ]) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//            }
//        }
//
//
//
//        FirestoreManager.champs.document("Akali").setData([
//            "id": "84",
//            "key": "Akali",
//            "name": "Akali",
//            "cost": 4,
//            "origin": ["Ninja"],
//            "class": ["Assassin"],
//            "ability": [
//                "name": "Five Point Strike",
//                "description": "Akali throws shurikens in front of her, dealing damage.",
//                "type": "Active",
//                "manaCost": 25,
//                "manaStart": 0,
//                "stats": [[ "type": "Damage", "value": "150 / 275 / 400" ]]
//            ],
//            "stats": [
//                "offense": [
//                    "damage": 80,
//                    "attackSpeed": 0.7,
//                    "dps": 53,
//                    "range": 1
//                ],
//                "defense": [
//                    "health": 650,
//                    "armor": 20,
//                    "magicResist": 20
//                ]
//            ],
//            "items": [
//                "phantomdancer",
//                "seraphsembrace",
//                "rabadonsdeathcap"
//            ]
//        ]) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//            }
//        }
//
//
//        FirestoreManager.champs.document("Anivia").setData([
//            "id": "34",
//            "key": "Anivia",
//            "name": "Anivia",
//            "origin": ["Glacial"],
//            "class": ["Elementalist"],
//            "cost": 5,
//            "ability": [
//                "name": "Glacial Storm",
//                "description": "Anivia channels a large hailstorm, damaging enemies inside of it.",
//                "type": "Active",
//                "manaCost": 100,
//                "manaStart": 0,
//                "stats": [
//                    [ "type": "Damage", "value": "700 / 950 / 1200" ],
//                    [ "type": "Attack Speed Slow", "value": "50 / 70 / 90" ],
//                    [ "type": "Storm Duration", "value": "8s" ]
//                ]
//            ],
//            "stats": [
//                "offense": [
//                    "damage": 40,
//                    "attackSpeed": 0.6,
//                    "dps": 24,
//                    "range": 3
//                ],
//                "defense": [
//                    "health": 700,
//                    "armor": 20,
//                    "magicResist": 20
//                ]
//            ],
//            "items": [
//                "seraphsembrace",
//                "rabadonsdeathcap",
//                "morellonomicon"
//            ]
//        ]) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//            }
//        }
//
//
//        FirestoreManager.champs.document("Ashe").setData([
//            "id": "22",
//            "key": "Ashe",
//            "name": "Ashe",
//            "origin": ["Glacial"],
//            "class": ["Ranger"],
//            "cost": 3,
//            "ability": [
//                "name": "Enchanted Crystal Arrow",
//                "description": "Ashe fires an arrow that travels across the map, damages, and stuns (stun duration based on each hex traveled).",
//                "type": "Active",
//                "manaCost": 100,
//                "manaStart": 0,
//                "stats": [
//                    [ "type": "Damage", "value": "700 / 950 / 1200" ],
//                    [ "type": "Stun Duration (per hex traveled)", "value": "1s / 1.5s / 2s" ]
//                ]
//            ],
//            "stats": [
//                "offense": [
//                    "damage": 65,
//                    "attackSpeed": 0.7,
//                    "dps": 42,
//                    "range": 4
//                ],
//                "defense": [
//                    "health": 550,
//                    "armor": 20,
//                    "magicResist": 20
//                ]
//            ],
//            "items": [
//                "statikkshiv",
//                "runaanshurricane",
//                "guinsoosrageblade"
//            ]
//        ]) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//            }
//        }
//
//
//        FirestoreManager.champs.document("AurelionSol").setData([
//            "id": "136",
//            "key": "AurelionSol",
//            "name": "Aurelion Sol",
//            "origin": ["Dragon"],
//            "class": ["Sorcerer"],
//            "cost": 4,
//            "ability": [
//                "name": "Voice of Light",
//                "description": "Aurelion Sol breathes a large blast of fire in a line, dealing damage to enemies.",
//                "type": "Active",
//                "manaCost": 125,
//                "manaStart": 0,
//                "stats": [
//                    [ "type": "Damage", "value": "250 / 500 / 750" ],
//                    [ "type": "Channel Duration", "value": "0.35s" ]
//                ]
//            ],
//            "stats": [
//                "offense": [
//                    "damage": 40,
//                    "attackSpeed": 0.6,
//                    "dps": 24,
//                    "range": 3
//                ],
//                "defense": [
//                    "health": 650,
//                    "armor": 20,
//                    "magicResist": 20
//                ]
//            ],
//            "items": [
//                "rapidfirecannon",
//                "rabadonsdeathcap",
//                "morellonomicon"
//            ]
//        ]) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//            }
//        }
//
//
//        FirestoreManager.champs.document("Blitzcrank").setData([
//            "id": "53",
//            "key": "Blitzcrank",
//            "name": "Blitzcrank",
//            "origin": ["Robot"],
//            "class": ["Brawler"],
//            "cost": 2,
//            "ability": [
//                "name": "Rocket Grab",
//                "description": "Blitzcrank pulls the furthest enemy to him.",
//                "type": "Active",
//                "manaCost": 125,
//                "manaStart": 0,
//                "stats": [
//                    [ "type": "Damage", "value": "100 / 350 / 800" ],
//                    [ "type": "Stun Duration", "value": "2.5s" ]
//                ]
//            ],
//            "stats": [
//                "offense": [
//                    "damage": 50,
//                    "attackSpeed": 0.5,
//                    "dps": 25,
//                    "range": 1
//                ],
//                "defense": [
//                    "health": 600,
//                    "armor": 35,
//                    "magicResist": 20
//                ]
//            ],
//            "items": [
//                "thornmail",
//                "warmogsarmor",
//                "dragonsclaw"
//            ]
//        ]) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//            }
//        }
//
//
//        FirestoreManager.champs.document("Brand").setData([
//            "id": "63",
//            "key": "Brand",
//            "name": "Brand",
//            "origin": ["Demon"],
//            "class": ["Elementalist"],
//            "cost": 4,
//            "ability": [
//                "name": "Pyroclasm",
//                "description": "Brand launches a bouncing fireball, damaging enemies hit.",
//                "type": "Active",
//                "manaCost": 150,
//                "manaStart": 50,
//                "stats": [
//                    [ "type": "Damage", "value": "250 / 450 / 650" ],
//                    [ "type": "Bounces", "value": "4 / 4 / 6" ]
//                ]
//            ],
//            "stats": [
//                "offense": [
//                    "damage": 60,
//                    "attackSpeed": 0.6,
//                    "dps": 36,
//                    "range": 3
//                ],
//                "defense": [
//                    "health": 700,
//                    "armor": 25,
//                    "magicResist": 20
//                ]
//            ],
//            "items": [
//                "guinsoosrageblade",
//                "morellonomicon",
//                "hextechgunblade"
//            ]
//        ]) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//            }
//        }
//
//
//        FirestoreManager.champs.document("Braum").setData([
//            "id": "201",
//            "key": "Braum",
//            "name": "Braum",
//            "origin": ["Glacial"],
//            "class": ["Guardian"],
//            "cost": 2,
//            "ability": [
//                "name": "Unbreakable",
//                "description": "Braum creates a barrier that blocks all incoming damage.",
//                "type": "Active",
//                "manaCost": 50,
//                "manaStart": 0,
//                "stats": [
//                    [ "type": "Damage Reduction", "value": "70% / 80% / 90%" ],
//                    [ "type": "Duration", "value": "4s" ]
//                ]
//            ],
//            "stats": [
//                "offense": [
//                    "damage": 40,
//                    "attackSpeed": 0.6,
//                    "dps": 24,
//                    "range": 1
//                ],
//                "defense": [
//                    "health": 650,
//                    "armor": 75,
//                    "magicResist": 20
//                ]
//            ],
//            "items": [
//                "thornmail",
//                "warmogsarmor",
//                "dragonsclaw"
//            ]
//        ]) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//            }
//        }
//
//
//        FirestoreManager.champs.document("Camille").setData([
//            "id": "164",
//            "key": "Camille",
//            "name": "Camille",
//            "origin": ["Hextech"],
//            "class": ["Blademaster"],
//            "cost": 1,
//            "ability": [
//                "name": "The Hextech Ultimatum",
//                "description": "Camille singles out an enemy, dealing magic damage and rooting them for few seconds. Camille's allies in range will prioritize attacking that enemy.",
//                "type": "Active",
//                "manaCost": 150,
//                "manaStart": 0,
//                "stats": [
//                    [ "type": "Damage", "value": "200 / 325 / 450" ],
//                    [ "type": "Root Duration", "value": "4s / 5s / 6s" ]
//                ]
//            ],
//            "stats": [
//                "offense": [
//                    "damage": 50,
//                    "attackSpeed": 0.6,
//                    "dps": 30,
//                    "range": 1
//                ],
//                "defense": [
//                    "health": 550,
//                    "armor": 25,
//                    "magicResist": 20
//                ]
//            ],
//            "items": [
//                "spearofshojin",
//                "titanichydra",
//                "guardianangel"
//            ]
//        ]) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//            }
//        }
//
//
//        FirestoreManager.champs.document("Chogath").setData([
//            "id": "31",
//            "key": "Chogath",
//            "name": "Cho'Gath",
//            "origin": ["Void"],
//            "class": ["Brawler"],
//            "cost": 4,
//            "ability": [
//                "name": "Rupture",
//                "description": "Cho'gath ruptures an area, stunning and damaging enemies inside of it.",
//                "type": "Active",
//                "manaCost": 150,
//                "manaStart": 50,
//                "stats": [
//                    [ "type": "Damage", "value": "175 / 350 / 525" ],
//                    [ "type": "Knockup Duration", "value": "1.5s / 1.75s / 2s" ],
//                    [ "type": "AoE Radius", "value": "3 hexes" ],
//                    [ "type": "Delay", "value": "1.5s" ]
//                ]
//            ],
//            "stats": [
//                "offense": [
//                    "damage": 70,
//                    "attackSpeed": 0.6,
//                    "dps": 39,
//                    "range": 1
//                ],
//                "defense": [
//                    "health": 1000,
//                    "armor": 20,
//                    "magicResist": 20
//                ]
//            ],
//            "items": [
//                "rabadonsdeathcap",
//                "morellonomicon",
//                "seraphsembrace"
//            ]
//        ]) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//            }
//        }
//
//
//        FirestoreManager.champs.document("Darius").setData([
//            "id": "122",
//            "key": "Darius",
//            "name": "Darius",
//            "origin": ["Imperial"],
//            "class": ["Knight"],
//            "cost": 1,
//            "ability": [
//                "name": "Decimate",
//                "description": "Darius swings his axe, damaging nearby enemies and healing himself based off his missing health.",
//                "type": "Active",
//                "manaCost": 100,
//                "manaStart": 0,
//                "stats": [
//                    [ "type": "Damage", "value": "150 / 225 / 300" ],
//                    [ "type": "Heal", "value": "100 / 150 / 200" ],
//                    [ "type": "Delay", "value": "1.5" ]
//                ]
//            ],
//            "stats": [
//                "offense": [
//                    "damage": 50,
//                    "attackSpeed": 0.5,
//                    "dps": 25,
//                    "range": 1
//                ],
//                "defense": [
//                    "health": 600,
//                    "armor": 40,
//                    "magicResist": 20
//                ]
//            ],
//            "items": [
//                "thornmail",
//                "warmogsarmor",
//                "dragonsclaw"
//            ]
//        ]) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//            }
//        }
//
//
//        FirestoreManager.champs.document("Elise").setData([
//            "id": "60",
//            "key": "Elise",
//            "name": "Elise",
//            "origin": ["Demon"],
//            "class": ["Shapeshifter"],
//            "cost": 1,
//            "ability": [
//                "name": "Spider Form",
//                "description": "Elise fires a cocoon stunning the nearest enemy and transforms, summoning 2 Spiderlings.",
//                "type": "Active",
//                "manaCost": 100,
//                "manaStart": 0,
//                "stats": [
//                    [ "type": "Life Steal", "value": "60% / 90% / 120%" ],
//                    [ "type": "Number of Spiderlings", "value": "1 / 2 / 4" ],
//                    [ "type": "Spiderling Attack Damage", "value": "50" ],
//                    [ "type": "Spiderling Attack Speed", "value": "0.7" ],
//                    [ "type": "Spiderling Health", "value": "500" ]
//                ]
//            ],
//            "stats": [
//                "offense": [
//                    "damage": 45,
//                    "attackSpeed": 0.6,
//                    "dps": 40,
//                    "range": 2
//                ],
//                "defense": [
//                    "health": 500,
//                    "armor": 20,
//                    "magicResist": 20
//                ]
//            ],
//            "items": [
//                "guinsoosrageblade",
//                "thornmail",
//                "warmogsarmor"
//            ]
//        ]) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//            }
//        }
//
//
//
//        FirestoreManager.champs.document("Draven").setData([
//            "id": "119",
//            "key": "Draven",
//            "name": "Draven",
//            "origin": ["Imperial"],
//            "class": ["Blademaster"],
//            "cost": 4,
//            "ability": [
//                "name": "Spinning Axes",
//                "description": "Draven gains bonus on-hit damage and Attack Speed. Stacks up to two times.",
//                "type": "Passive",
//                "manaCost": nil,
//                "manaStart": nil,
//                "stats": [
//                    [ "type": "Buff Duration", "value": "8s" ],
//                    [ "type": "Attack Damage Multiplier", "value": "150% / 200% / 250%" ]
//                ]
//            ],
//            "stats": [
//                "offense": [
//                    "damage": 70,
//                    "attackSpeed": 0.75,
//                    "dps": 49,
//                    "range": 3
//                ],
//                "defense": [
//                    "health": 650,
//                    "armor": 25,
//                    "magicResist": 20
//                ]
//            ],
//            "items": [
//                "bloodthirster",
//                "rapidfirecannon",
//                "guardianangel"
//            ]
//        ]) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//            }
//        }
    }
}
