//
//  TCDetailTraitInfo.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 30/04/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCDetailTraitInfo: UIView {
    
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
        stack.alignment = .leading
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
        return lbl
    }()
    
    let synergyCount: UILabel = {
        let size: CGFloat = 20
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lbl.heightAnchor.constraint(equalToConstant: size),
            lbl.widthAnchor.constraint(equalToConstant: size)
        ])
        
        lbl.font = .systemFont(ofSize: 14, weight: .regular)
        lbl.textAlignment = .center
        lbl.backgroundColor = ThemeColor.richBlack
        lbl.layer.cornerRadius = size / 2
        lbl.layer.masksToBounds = true
        lbl.layer.borderWidth = 1
        return lbl
    }()
    
    let synergyValue: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14, weight: .regular)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTraitInfo()
        
        let padding: CGFloat = 8
        setupSynergyBadge(padding)
        setupTraitStackViews(padding)
    }
    
    
    //MARK: Setup Trait Info
    fileprivate func setupTraitInfo() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ThemeColor.charcoal
        layer.cornerRadius = 5
    }

    
    //MARK: Setup Synergy Badge
    fileprivate func setupSynergyBadge(_ padding: CGFloat) {
        addSubview(synergyBadge)
        NSLayoutConstraint.activate([
            synergyBadge.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            synergyBadge.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
    }
    
    
    //MARK: Setup Trait Stack Views
    fileprivate func setupTraitStackViews(_ padding: CGFloat) {
        addSubview(traitVertStack)
        traitVertStack.addArrangedSubview(synergyEffect)
        traitVertStack.addArrangedSubview(traitBonusStack)
        NSLayoutConstraint.activate([
            traitVertStack.topAnchor.constraint(equalTo: synergyBadge.bottomAnchor, constant: 8),
            traitVertStack.leadingAnchor.constraint(equalTo: synergyBadge.leadingAnchor, constant: 8),
            traitVertStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            traitVertStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
        traitBonusStack.addArrangedSubview(synergyCount)
        traitBonusStack.addArrangedSubview(synergyValue)
        NSLayoutConstraint.activate([
            traitBonusStack.leadingAnchor.constraint(equalTo: traitVertStack.leadingAnchor),
            traitBonusStack.trailingAnchor.constraint(equalTo: traitVertStack.trailingAnchor)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
