//
//  TCDetailTraitInfo.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 30/04/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCDetailTraitInfo: BaseView {
    
    //MARK: StackViews
    let traitVertStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .leading
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    let traitBonusStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()
    
    //MARK: Label & ImageViews
    let synergyBadge = TCDetailSynergyBadge()
    let synergyEffect: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14, weight: .regular)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textColor = ThemeColor.platinum
        return lbl
    }()
    
    let synergyCount: UILabel = {
        let lbl = UILabel()
        lbl.makeCircular(size: 20)
        lbl.font = .systemFont(ofSize: 14, weight: .regular)
        lbl.backgroundColor = ThemeColor.richBlack
        lbl.layer.borderWidth = 1
        lbl.textColor = ThemeColor.platinum
        return lbl
    }()
    
    let synergyValue: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14, weight: .regular)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textColor = ThemeColor.platinum
        return lbl
    }()
    
    
    //MARK:- Setup View
    override func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ThemeColor.charcoal
        layer.cornerRadius = 5
    }
    
    
    //MARK: Setup Subviews
    override func setupSubviews() {
        let padding: CGFloat = 8
        setupSynergyBadge(padding)
        setupTraitStackViews(padding)
        setupTraitBonusStack()
    }
    
    
    //MARK: Setup Synergy Badge
    fileprivate func setupSynergyBadge(_ padding: CGFloat) {
        addSubview(synergyBadge)
        NSLayoutConstraint.activate([
            synergyBadge.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            synergyBadge.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding)
        ])
    }
    
    
    //MARK: Setup Trait Stack Views
    fileprivate func setupTraitStackViews(_ padding: CGFloat) {
        addSubview(traitVertStack)
        traitVertStack.addArrangedSubview(synergyEffect)
        traitVertStack.addArrangedSubview(traitBonusStack)
        NSLayoutConstraint.activate([
            traitVertStack.topAnchor.constraint(equalTo: synergyBadge.bottomAnchor, constant: padding),
            traitVertStack.leadingAnchor.constraint(equalTo: synergyBadge.leadingAnchor, constant: padding),
            traitVertStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            traitVertStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
    }
    
    //MARK: Setup Trait Bonus Stack
    fileprivate func setupTraitBonusStack() {
        traitBonusStack.addArrangedSubview(synergyCount)
        traitBonusStack.addArrangedSubview(synergyValue)
        NSLayoutConstraint.activate([
            traitBonusStack.leadingAnchor.constraint(equalTo: traitVertStack.leadingAnchor),
            traitBonusStack.trailingAnchor.constraint(equalTo: traitVertStack.trailingAnchor)
        ])
    }
}
