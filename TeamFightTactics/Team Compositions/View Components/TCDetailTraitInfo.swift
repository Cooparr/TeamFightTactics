//
//  TCDetailTraitInfo.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 30/04/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCDetailTraitInfo: BaseView {
    
    //MARK: Properties
    let trait: Trait
    
    let traitVertStack = BaseStack(axis: .vertical, alignment: .leading, spacing: 8)
    let traitBonusStack = BaseStack(axis: .horizontal, alignment: .center, spacing: 8)
    
    let synergyBadge = TCDetailSynergyBadge(cornerRadius: 4)
    let synergyEffect = BaseLabel(fontSize: 14, fontWeight: .regular, multiLine: true)
    let synergyValue = BaseLabel(fontSize: 14, fontWeight: .regular, multiLine: true)
    let synergyCount: UILabel = {
        let lbl = UILabel()
        lbl.makeCircular(size: 20)
        lbl.font = .systemFont(ofSize: 14, weight: .regular)
        lbl.backgroundColor = ThemeColor.richBlack
        lbl.layer.borderWidth = 1
        lbl.textColor = ThemeColor.platinum
        return lbl
    }()
    
    
    //MARK: Required Init
    required init(with trait: Trait) {
        self.trait = trait
        super.init(frame: .zero)
        setTraitSynergyBadge()
        setTraitEffectLabel()
        setTileBonusLabels()
    }
    
    
    override func setupView() {
        backgroundColor = ThemeColor.charcoal
        layer.cornerRadius = 5.0
        let padding: CGFloat = 8
        constrainSynergyBadge(padding)
        constrainTraitStackViews(padding)
        constrainTraitBonusStack()
    }
    
    
    //MARK: Set Tile Synergy Badge
    func setTraitSynergyBadge() {
        synergyBadge.synergyIcon.image = UIImage(named: "\(trait.name)")
        synergyBadge.synergyNameLabel.text = trait.name
        synergyBadge.backgroundColor = trait.rank.setRankColor(trait.isChosen)
    }
    
    
    //MARK: Set Tile Effect Label
    func setTraitEffectLabel() {
        if trait.effect == nil {
            synergyEffect.isHidden = true
        }
        synergyEffect.text = trait.effect
    }
    
    
    //MARK: Set Tile Bonus Labels
    func setTileBonusLabels() {
        if let bonus = trait.bonuses.reversed().first(where: { $0.count <= trait.count }) {
            synergyCount.text = "\(bonus.count)"
            synergyCount.layer.borderColor = trait.rank.setRankColor(trait.isChosen).cgColor
            synergyValue.text = "\(bonus.value)"
        }
    }
    
    
    //MARK: Setup Synergy Badge
    fileprivate func constrainSynergyBadge(_ padding: CGFloat) {
        addSubview(synergyBadge)
        NSLayoutConstraint.activate([
            synergyBadge.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            synergyBadge.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding)
        ])
    }
    
    
    //MARK: Setup Trait Stack Views
    fileprivate func constrainTraitStackViews(_ padding: CGFloat) {
        addSubview(traitVertStack)
        traitVertStack.addArrangedSubviews(synergyEffect, traitBonusStack)
        NSLayoutConstraint.activate([
            traitVertStack.topAnchor.constraint(equalTo: synergyBadge.bottomAnchor, constant: padding),
            traitVertStack.leadingAnchor.constraint(equalTo: synergyBadge.leadingAnchor, constant: padding),
            traitVertStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            traitVertStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
    }
    
    //MARK: Setup Trait Bonus Stack
    fileprivate func constrainTraitBonusStack() {
        traitBonusStack.addArrangedSubviews(synergyCount, synergyValue)
        NSLayoutConstraint.activate([
            traitBonusStack.leadingAnchor.constraint(equalTo: traitVertStack.leadingAnchor),
            traitBonusStack.trailingAnchor.constraint(equalTo: traitVertStack.trailingAnchor)
        ])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
