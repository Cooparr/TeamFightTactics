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
    lazy private var traitsSectionView: TCTraitsView = TCTraitsView()
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
                let traitInfo = TCDetailTraitInfo()
                setTraitSynergyBadge(traitInfo, trait, syn)
                setTraitEffectLabel(trait, traitInfo)
                setTileBonusLabels(trait, syn, traitInfo)
                traitsSectionView.synergiesStackView.addArrangedSubview(traitInfo)
            }
        }
    }
    
    
    //MARK: Set Tile Synergy Badge
    fileprivate func setTraitSynergyBadge(_ traitInfo: TCDetailTraitInfo, _ trait: Trait, _ syn: TCSynergy) {
        traitInfo.synergyBadge.synergyIcon.image = UIImage(named: "\(trait.name)")
        traitInfo.synergyBadge.synergyNameLabel.text = trait.name
        traitInfo.synergyBadge.backgroundColor = syn.rank.setRankColor(syn.chosen)
    }
    
    
    //MARK: Set Tile Effect Label
    fileprivate func setTraitEffectLabel(_ trait: Trait, _ traitInfo: TCDetailTraitInfo) {
        if trait.effect == nil {
            traitInfo.synergyEffect.isHidden = true
        }
        traitInfo.synergyEffect.text = trait.effect
    }
    
    
    //MARK: Set Tile Bonus Labels
    fileprivate func setTileBonusLabels(_ trait: Trait, _ syn: TCSynergy, _ traitInfo: TCDetailTraitInfo) {
        if let bonus = trait.bonuses.reversed().first(where: { $0.count <= syn.count }) {
            traitInfo.synergyCount.text = "\(bonus.count)"
            traitInfo.synergyCount.layer.borderColor = syn.rank.setRankColor(syn.chosen).cgColor
            traitInfo.synergyValue.text = "\(bonus.value)"
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
