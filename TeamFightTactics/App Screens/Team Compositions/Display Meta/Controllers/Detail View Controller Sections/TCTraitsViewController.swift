//
//  TCTraitsViewController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 28/04/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCTraitsViewController: UIViewController {
    
    //MARK: Properties
    lazy private var traitsSectionView = TCTraitsView(backgroundColor: ThemeColor.richBlack)
    let traitObjs: [Trait]
    let synergies: [TCSynergy]

    
    //MARK:- Init
    init(_ traitObjs: [Trait], _ synergies: [TCSynergy]) {
        self.traitObjs = traitObjs
        self.synergies = synergies
        super.init(nibName: nil, bundle: nil)
    }
    
    
    //MARK:- Load View
    override func loadView() {
        super.loadView()
        self.view = self.traitsSectionView
    }
    
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        createTraitTilesForStackView()
    }
    
    
    //MARK:- Creat Trait Tile
    fileprivate func createTraitTilesForStackView() {
        for syn in synergies {
            for trait in traitObjs where trait.name.contains(syn.name) {
                let trait = Trait(name: syn.name, effect: trait.effect, tier: trait.tier, bonuses: trait.bonuses, count: syn.count, rank: syn.rank, isChosen: syn.isChosen ?? false)
                let traitInfo = TCDetailTraitInfo(with: trait)
                traitsSectionView.synergiesStackView.addArrangedSubview(traitInfo)
            }
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
