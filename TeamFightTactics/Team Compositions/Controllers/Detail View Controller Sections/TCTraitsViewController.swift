//
//  TCTraitsViewController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 28/04/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCTraitsViewController: UIViewController {
    
    lazy private var traitsSectionView: TCTraitsView = TCTraitsView()

    //MARK: Properties
    let classObjs: [Trait]
    let originObjs: [Trait]
    let synergies: [TeamCompositionSynergies]

    
    //MARK:- Init
    init(_ classObjs: [Trait], _ originObjs: [Trait], _ synergies: [TeamCompositionSynergies]) {
        self.classObjs = classObjs
        self.originObjs = originObjs
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
        for trait in classObjs + originObjs {
            for syn in synergies where syn.name.contains(trait.name) {
                let traitInfo = TCDetailTraitInfo()
                setTraitSynergyBadge(traitInfo, trait, syn)
                setTraitEffectLabel(trait, traitInfo)
                setTileBonusLabels(trait, syn, traitInfo)
                traitsSectionView.synergiesStackView.addArrangedSubview(traitInfo)
            }
        }
    }
    
    
    //MARK: Set Tile Synergy Badge
    fileprivate func setTraitSynergyBadge(_ traitInfo: TCDetailTraitInfo, _ trait: Trait, _ syn: TeamCompositionSynergies) {
        traitInfo.synergyBadge.synergyIcon.image = UIImage(named: "\(trait.name)")
        traitInfo.synergyBadge.synergyNameLabel.text = trait.name
        traitInfo.synergyBadge.backgroundColor = syn.rank.setBadgeColor()
    }
    
    
    //MARK: Set Tile Effect Label
    fileprivate func setTraitEffectLabel(_ trait: Trait, _ traitInfo: TCDetailTraitInfo) {
        if trait.effect == nil {
            traitInfo.synergyEffect.isHidden = true
        }
        traitInfo.synergyEffect.text = trait.effect
    }
    
    
    //MARK: Set Tile Bonus Labels
    fileprivate func setTileBonusLabels(_ trait: Trait, _ syn: TeamCompositionSynergies, _ traitInfo: TCDetailTraitInfo) {
        if let bonus = trait.bonus.reversed().first(where: { $0.count <= syn.count }) {
            traitInfo.synergyCount.text = "\(bonus.count)"
            traitInfo.synergyCount.layer.borderColor = syn.rank.setBadgeColor().cgColor
            traitInfo.synergyValue.text = "\(bonus.value)"
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
