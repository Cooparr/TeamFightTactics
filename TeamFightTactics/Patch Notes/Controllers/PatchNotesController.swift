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
        
        // Change this to true, when wanting to add TeamComps to Database.
        btn.isEnabled = true
        return btn
    }()

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
}
