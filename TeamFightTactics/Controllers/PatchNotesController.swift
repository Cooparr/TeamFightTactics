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

        view.addSubview(nothingButton)
        nothingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nothingButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        nothingButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        loadData()
    }
    
    
    // Firestore Implementation Testing
    fileprivate func loadData() {
        FirestoreManager.champs.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents:", err)
            } else if let querySnapshot = querySnapshot {
                for document in querySnapshot.documents {
                    let champ = FirestoreChampion(data: document.data())
                    
                    print("\n-----\n")
                    print("name: ", champ.name)
                    print("cost: ", champ.cost)
                    print("origins: ", champ.origins)
                    print("classes: ", champ.classes)
                    print("tier: ", champ.tier)
                    print("patched: ", champ.patched)
                    print("best items: ", champ.bestItems)
                    print("\nability name: ", champ.ability.name)
                    print("ability active: ", champ.ability.active)
                    print("ability description: ", champ.ability.abilityDescription)
                    print("ability stats: ", champ.ability.abilityStat)
                    print("mana cost: ", champ.ability.manaCost)
                    print("mana start: ", champ.ability.manaStart)
                    print("\nattackDamage: ", champ.stats.attackDamage)
                    print("attackSpeed: ", champ.stats.attackSpeed)
                    print("range: ", champ.stats.range)
                    print("health: ", champ.stats.health)
                    print("armor: ", champ.stats.armor)
                    print("magicResist: ", champ.stats.magicResist)
                }
            }
        }
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
        
        // Aatrox
        FirestoreManager.champs.document("Aatrox").setData([
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
        
        // Ahri
        FirestoreManager.champs.document("Ahri").setData([
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
        
        // Akali
        FirestoreManager.champs.document("Akali").setData([
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
        
        // Anivia
        FirestoreManager.champs.document("Anivia").setData([
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
        
        // Ashe
        FirestoreManager.champs.document("Ashe").setData([
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
    }
}
