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
                    
                
                    print("-----")
                    print("name: ", champ.name)
                    print("champ origin: ", champ.origins)
                    print("champ class: ", champ.classes)
                    print("ability name: ", champ.ability.name)
                    print("ability description: ", champ.ability.abilityDescription)
                    print("mana cost: ", champ.ability.manaCost)
                    print("mana start: ", champ.ability.manaStart)
                    print("ability type: ", champ.ability.type)
                    print("items: ", champ.bestItems)
                    print("ability stats: ", champ.ability.abilityStats)
                    print("new ability stats: ", champ.ability.newAbStat)

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
//        FirestoreManager.champs.document("Aatrox").setData([
//            "name": "Aatrox",
//            "origins": ["Demon"],
//            "classes": ["Blademaster"],
//            "cost": 3,
//            "ability": [
//                "name": "The Darkin Blade",
//                "description": "Aatrox cleaves the area in front of him, dealing damage to enemies inside it.",
//                "type": "Active",
//                "manaCost": 75,
//                "manaStart": 0,
//                "abilityStats": [
//                    "damage": [300, 600, 900]
//                ]
//            ],
//            "champStats": [
//                "attackDamage": 65,
//                "attackSpeed": 0.65,
//                "range": 1,
//                "health": 700,
//                "armor": 25,
//                "magicResist": 20
//            ],
//            "bestItems": [
//                "hextechgunblade",
//                "spearofshojin",
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
