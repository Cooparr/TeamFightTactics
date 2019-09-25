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
                    "Storm Duration": [6]
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
            "tier": 1,
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
                    "Stun Duration": [1, 1.5, 2]
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
                    "Channel Duration": [0.35]
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
            "tier": 2,
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
                    "Stun Duration": [2.5]
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
                    "Damage Reduction": [70, 80, 90],
                    "Duration": [4]
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
                    "Root Duration": [4, 5, 6]
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
                    "Knockup Duration": [1.5, 1.75, 2],
                    "AoE Radius": [3],
                    "Delay": [1.5]
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
                    "Delay": [1.5]
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
            "tier": 1,
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
                    "Buff Duration": [8],
                    "Attack Damage Multiplier": [150, 200, 250]
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
    }
}
