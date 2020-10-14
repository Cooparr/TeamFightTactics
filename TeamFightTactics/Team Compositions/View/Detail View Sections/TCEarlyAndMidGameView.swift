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
    let teamCompTier: BaseLabel = {
        let lbl = BaseLabel(fontSize: 15, fontWeight: .semibold, fontColor: ThemeColor.richBlack)
        lbl.textAlignment = .center
        lbl.clipsToBounds = true
        lbl.layer.cornerRadius = 10.0
        lbl.layer.maskedCorners = [.layerMinXMaxYCorner]
        return lbl
    }()
    
    let horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 10
        return stack
    }()
    
    let earlyContainer = BaseView(backgroundColor: ThemeColor.charcoal, cornerRadius: 5.0)
    let earlyVertStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 6
        return stack
    }()
    
    let earlyGameLabel: BaseLabel = {
        let lbl = BaseLabel(fontSize: 16, fontWeight: .regular, lblText: "Early Game")
        lbl.textAlignment = .center
        return lbl
    }()
    
    let earlyGameStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.spacing = 6
        stackView.axis = .horizontal
        return stackView
    }()
    
    let midContainer = BaseView(backgroundColor: ThemeColor.charcoal, cornerRadius: 5.0)
    let midVertStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 6
        return stack
    }()
    
    let midGameLabel: BaseLabel = {
        let lbl = BaseLabel(fontSize: 16, fontWeight: .regular,lblText: "Mid Game")
        lbl.textAlignment = .center
        return lbl
    }()
    
    let midGameStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.spacing = 6
        stackView.axis = .horizontal
        return stackView
    }()
    
    
    //MARK: Setup View
    override func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ThemeColor.richBlack
    }
    
    
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
        addSubview(teamCompTier)
        NSLayoutConstraint.activate([
            teamCompTier.widthAnchor.constraint(equalToConstant: 100),
            teamCompTier.heightAnchor.constraint(equalToConstant: 20),
            teamCompTier.topAnchor.constraint(equalTo: topAnchor),
            teamCompTier.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    
    //MARK: Setup Horizontal Stack
    fileprivate func setupHorizontalStack() {
        addSubview(horizontalStack)
        horizontalStack.addArrangedSubviews(earlyContainer, midContainer)
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: teamCompTier.bottomAnchor, constant: 10),
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
