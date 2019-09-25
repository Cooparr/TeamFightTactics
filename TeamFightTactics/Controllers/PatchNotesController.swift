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

        view.addSubview(addToDatabase)
        addToDatabase.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addToDatabase.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        addToDatabase.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    let addToDatabase: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Nothing to see.. yet", for: .normal)
        btn.backgroundColor = CustomColor.romanSilver
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 1
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        btn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        // Change this to true, when wanting to add Champs to Database.
        btn.isEnabled = false
        return btn
    }()
    
    
    @objc func buttonTapped() {
        print(123)
        
        //MARK: Aatrox
        FirestoreManager.champs.document("Aatrox").setData([
            "key": "Aatrox",
            "name": "Aatrox",
            "cost": 3,
            "origins": ["Demon"],
            "classes": ["Blademaster"],
            "tier": 2,
            "patched": "no",
            "bestItems": [
                "hextechgunblade",
                "spearofshojin",
                "guardianangel"
            ],
            "ability": [
                "name": "The Darkin Blade",
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
        FirestoreManager.champs.document("Ahri").setData([
            "key": "Ahri",
            "name": "Ahri",
            "cost": 2,
            "origins": ["Wild"],
            "classes": ["Sorcerer"],
            "tier": 2,
            "patched": "no",
            "bestItems": [
                "statikkshiv",
                "guinsoosrageblade",
                "ludensecho"
            ],
            "ability": [
                "name": "Spirit Orb",
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
        FirestoreManager.champs.document("Akali").setData([
            "key": "Akali",
            "name": "Akali",
            "cost": 4,
            "origins": ["Ninja"],
            "classes": ["Assassin"],
            "tier": 2,
            "patched": "no",
            "bestItems": [
                "phantomdancer",
                "seraphsembrace",
                "rabadonsdeathcap"
            ],
            "ability": [
                "name": "Five Point Strike",
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
        FirestoreManager.champs.document("Anivia").setData([
            "key": "Anivia",
            "name": "Anivia",
            "cost": 5,
            "origins": ["Glacial"],
            "classes": ["Elementalist"],
            "tier": 2,
            "patched": "no",
            "bestItems": [
                "seraphsembrace",
                "rabadonsdeathcap",
                "morellonomicon"
            ],
            "ability": [
                "name": "Glacial Storm",
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
        FirestoreManager.champs.document("Ashe").setData([
            "key": "Ashe",
            "name": "Ashe",
            "cost": 3,
            "origins": ["Glacial"],
            "classes": ["Ranger"],
            "tier": 2,
            "patched": "no",
            "bestItems": [
                "statikkshiv",
                "guinsoosrageblade",
                "spearofshojin"
            ],
            "ability": [
                "name": "Enchanted Crystal Arrow",
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
        FirestoreManager.champs.document("AurelionSol").setData([
            "key": "AurelionSol",
            "name": "Aurelion Sol",
            "cost": 4,
            "origins": ["Dragon"],
            "classes": ["Sorcerer"],
            "tier": 1,
            "patched": "no",
            "bestItems": [
                "rapidfirecannon",
                "spearofshojin",
                "morellonomicon"
            ],
            "ability": [
                "name": "Voice of Light",
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
        FirestoreManager.champs.document("Blitzcrank").setData([
            "key": "Blitzcrank",
            "name": "Blitzcrank",
            "cost": 2,
            "origins": ["Robot"],
            "classes": ["Brawler"],
            "tier": 1,
            "patched": "no",
            "bestItems": [
                "spearofshojin",
                "ludensecho",
                "rabadonsdeathcap"
            ],
            "ability": [
                "name": "Rocket Grab",
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
        FirestoreManager.champs.document("Brand").setData([
            "key": "Brand",
            "name": "Brand",
            "cost": 4,
            "origins": ["Demon"],
            "classes": ["Elementalist"],
            "tier": 1,
            "patched": "no",
            "bestItems": [
                "morellonomicon",
                "spearofshojin",
                "hextechgunblade"
            ],
            "ability": [
                "name": "Pyroclasm",
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
        FirestoreManager.champs.document("Braum").setData([
            "key": "Braum",
            "name": "Braum",
            "cost": 2,
            "origins": ["Glacial"],
            "classes": ["Guardian"],
            "tier": 3,
            "patched": "no",
            "bestItems": [
                "thornmail",
                "warmogsarmor",
                "dragonsclaw"
            ],
            "ability": [
                "name": "Unbreakable",
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
        FirestoreManager.champs.document("Camille").setData([
            "key": "Camille",
            "name": "Camille",
            "cost": 1,
            "origins": ["Hextech"],
            "classes": ["Blademaster"],
            "tier": 5,
            "patched": "no",
            "bestItems": [
                "spearofshojin",
                "titanichydra",
                "guardianangel"
            ],
            "ability": [
                "name": "The Hextech Ultimatum",
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
        FirestoreManager.champs.document("Cho'gath").setData([
            "key": "Chogath",
            "name": "Cho'Gath",
            "cost": 4,
            "origins": ["Void"],
            "classes": ["Brawler"],
            "tier": 1,
            "patched": "no",
            "bestItems": [
                "morellonomicon",
                "hextechgunblade",
                "yuumi"
            ],
            "ability": [
                "name": "Rupture",
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
        FirestoreManager.champs.document("Darius").setData([
            "key": "Darius",
            "name": "Darius",
            "cost": 1,
            "origins": ["Imperial"],
            "classes": ["Knight"],
            "tier": 3,
            "patched": "no",
            "bestItems": [
                "dragonsclaw",
                "warmogsarmor",
                "phantomdancer"
            ],
            "ability": [
                "name": "Decimate",
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
        FirestoreManager.champs.document("Draven").setData([
            "key": "Draven",
            "name": "Draven",
            "cost": 4,
            "origins": ["Imperial"],
            "classes": ["Blademaster"],
            "tier": 0,
            "patched": "no",
            "bestItems": [
                "bloodthirster",
                "rapidfirecannon",
                "guardianangel"
            ],
            "ability": [
                "name": "Spinning Axes",
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
        FirestoreManager.champs.document("Elise").setData([
            "key": "Elise",
            "name": "Elise",
            "cost": 1,
            "origins": ["Demon"],
            "classes": ["Shapeshifter"],
            "tier": 5,
            "patched": "no",
            "bestItems": [
                "guinsoosrageblade",
                "thornmail",
                "warmogsarmor"
            ],
            "ability": [
                "name": "Spider Form",
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
        FirestoreManager.champs.document("Evelynn").setData([
            "key": "Evelynn",
            "name": "Evelynn",
            "cost": 3,
            "origins": ["Demon"],
            "classes": ["Assassin"],
            "tier": 2,
            "patched": "no",
            "bestItems": [
                "spearofshojin",
                "hextechgunblade",
                "guardianangel"
            ],
            "ability": [
                "name": "LAst Caress",
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
        FirestoreManager.champs.document("Fiora").setData([
            "key": "Fiora",
            "name": "Fiora",
            "cost": 1,
            "origins": ["Noble"],
            "classes": ["Blademaster"],
            "tier": 3,
            "patched": "no",
            "bestItems": [
                "titanichydra",
                "spearofshojin",
                "statikkshiv"
            ],
            "ability": [
                "name": "Riposte",
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
        FirestoreManager.champs.document("Gangplank").setData([
            "key": "Gangplank",
            "name": "Gangplank",
            "cost": 3,
            "origins": ["Pirate"],
            "classes": ["Gunslinger", "Blademaster"],
            "tier": 3,
            "patched": "no",
            "bestItems": [
                "redbuff",
                "seraphsembrace",
                "guardianangel"
            ],
            "ability": [
                "name": "Powder Kegs",
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
        FirestoreManager.champs.document("Garen").setData([
            "key": "Garen",
            "name": "Garen",
            "cost": 1,
            "origins": ["Noble"],
            "classes": ["Knight"],
            "tier": 3,
            "patched": "no",
            "bestItems": [
                "morellonomicon",
                "thornmail",
                "warmogsarmor"
            ],
            "ability": [
                "name": "Judgement",
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
        FirestoreManager.champs.document("Gnar").setData([
            "key": "Gnar",
            "name": "Gnar",
            "cost": 4,
            "origins": ["Wild", "Yordle"],
            "classes": ["Shapeshifter"],
            "tier": 0,
            "patched": "no",
            "bestItems": [
                "guardianangel",
                "warmogsarmor",
                "dragonsclaw"
            ],
            "ability": [
                "name": "GNAR!",
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
        FirestoreManager.champs.document("Graves").setData([
            "key": "Graves",
            "name": "Graves",
            "cost": 1,
            "origins": ["Pirate"],
            "classes": ["Gunslinger"],
            "tier": 3,
            "patched": "no",
            "bestItems": [
                "redbuff",
                "rapidfirecannon",
                "rapidfirecannon"
            ],
            "ability": [
                "name": "Buckshot",
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
        FirestoreManager.champs.document("Jayce").setData([
            "key": "Jayce",
            "name": "Jayce",
            "cost": 2,
            "origins": ["Hextech"],
            "classes": ["Shapeshifter"],
            "tier": 4,
            "patched": "no",
            "bestItems": [
                "statikkshiv",
                "guinsoosrageblade",
                "hush"
            ],
            "ability": [
                "name": "Mecury Cannon",
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
        FirestoreManager.champs.document("Jinx").setData([
            "key": "Jinx",
            "name": "Jinx",
            "cost": 4,
            "origins": ["Hextech"],
            "classes": ["Gunslinger"],
            "tier": 3,
            "patched": "no",
            "bestItems": [
                "rapidfirecannon",
                "bloodthirster",
                "redbuff"
            ],
            "ability": [
                "name": "Get Excited!",
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
        FirestoreManager.champs.document("Kai'sa").setData([
            "key": "Kaisa",
            "name": "Kai'Sa",
            "cost": 5,
            "origins": ["Void"],
            "classes": ["Assassin", "Ranger"],
            "tier": 3,
            "patched": "no",
            "bestItems": [
                "statikkshiv",
                "rapidfirecannon",
                "guardianangel"
            ],
            "ability": [
                "name": "Killer Instinct",
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
        FirestoreManager.champs.document("Karthus").setData([
            "key": "Karthus",
            "name": "Karthus",
            "cost": 5,
            "origins": ["Phantom"],
            "classes": ["Sorcerer"],
            "tier": 1,
            "patched": "no",
            "bestItems": [
                "morellonomicon",
                "rabadonsdeathcap",
                "seraphsembrace"
            ],
            "ability": [
                "name": "Requiem",
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
        
        
        
        
    }
}
