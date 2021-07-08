//
//  EarlyGameSection.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 09/04/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCEarlyAndMidGameView: BaseView {

    //MARK: Properties
    let tierFlair = CellFlair()
    
    let horizontalStack = BaseStack(axis: .horizontal, distribution: .fillProportionally, spacing: 10)
    let earlyContainer = BaseView(backgroundColor: ThemeColor.charcoal, cornerRadius: 5.0)
    let earlyVertStack = BaseStack(axis: .vertical, alignment: .center, spacing: 6)
    let earlyGameStack = BaseStack(axis: .horizontal, alignment: .center, spacing: 6)
    let earlyGameLabel: BaseLabel = {
        let lbl = BaseLabel(fontSize: 16, fontWeight: .regular, lblText: "Early Game")
        lbl.textAlignment = .center
        return lbl
    }()

    let midContainer = BaseView(backgroundColor: ThemeColor.charcoal, cornerRadius: 5.0)
    let midVertStack = BaseStack(axis: .vertical, spacing: 6)
    let midGameStack = BaseStack(axis: .horizontal, alignment: .center, spacing: 6)
    let midGameLabel: BaseLabel = {
        let lbl = BaseLabel(fontSize: 16, fontWeight: .regular,lblText: "Mid Game")
        lbl.textAlignment = .center
        return lbl
    }()
    
    
    //MARK: Setup Subviews
    override func setupSubviews() {
        let padding: CGFloat = 6
        setupTierLabelConstraints()
        setupHorizontalStack()
        setupEarlyContainer(padding)
        setupMidContainer(padding)
    }
    
    
    //MARK: Tier Label Constraints
    fileprivate func setupTierLabelConstraints() {
        addSubview(tierFlair)
        tierFlair.constrainCellFlair(to: self, width: 100, height: 20)
    }
    
    
    //MARK: Setup Horizontal Stack
    fileprivate func setupHorizontalStack() {
        addSubview(horizontalStack)
        horizontalStack.addArrangedSubviews(earlyContainer, midContainer)
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: tierFlair.bottomAnchor, constant: 10),
            horizontalStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            horizontalStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    //MARK: Setup Early Container
    fileprivate func setupEarlyContainer(_ padding: CGFloat) {
        earlyContainer.addSubview(earlyVertStack)
        earlyVertStack.addArrangedSubviews(earlyGameLabel, earlyGameStack)
        NSLayoutConstraint.activate([
            earlyContainer.widthAnchor.constraint(greaterThanOrEqualToConstant: 132),
            
            earlyGameLabel.topAnchor.constraint(equalTo: earlyContainer.topAnchor, constant: padding),
            earlyGameLabel.leadingAnchor.constraint(equalTo: earlyContainer.leadingAnchor, constant: padding),
            earlyGameLabel.trailingAnchor.constraint(equalTo: earlyContainer.trailingAnchor, constant: -padding),
            
            earlyGameStack.bottomAnchor.constraint(equalTo: earlyContainer.bottomAnchor, constant: -padding)
        ])
    }
    
    
    //MARK: Setup Mid Container
    fileprivate func setupMidContainer(_ padding: CGFloat) {
        midContainer.addSubview(midVertStack)
        midVertStack.addArrangedSubviews(midGameLabel, midGameStack)
        NSLayoutConstraint.activate([
            midGameLabel.topAnchor.constraint(equalTo: midContainer.topAnchor, constant: padding),
            
            midGameStack.leadingAnchor.constraint(equalTo: midContainer.leadingAnchor, constant: padding),
            midGameStack.trailingAnchor.constraint(equalTo: midContainer.trailingAnchor, constant: -padding),
            midGameStack.bottomAnchor.constraint(equalTo: midContainer.bottomAnchor, constant: -padding)
        ])
    }
}
