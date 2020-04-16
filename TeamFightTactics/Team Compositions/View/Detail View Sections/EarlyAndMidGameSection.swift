//
//  EarlyGameSection.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 09/04/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class EarlyAndMidGameSection: UIView {

    //MARK: Properties
    let teamCompTier: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = CustomColor.richBlack
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        lbl.textAlignment = .center
        lbl.clipsToBounds = true
        lbl.layer.cornerRadius = 10.0
        lbl.layer.maskedCorners = [.layerMinXMaxYCorner]
        return lbl
    }()
    
    let earlyGameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Early Game"
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        lbl.textAlignment = .center
        return lbl
    }()
    
    let earlyGameStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let midGameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Mid Game"
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        lbl.textAlignment = .center
        return lbl
    }()
    
    let midGameStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSection()
        setupTierLabelConstraints()
        setupEarlyLabelConstraints()
        setupEarlyStackViewConstraints()
        setupMidLabelConstraints()
        setupMidStackViewConstraints()
    }
    
    
    //MARK: Setup Section
    fileprivate func setupSection() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = CustomColor.richBlack
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
    
    
    //MARK: Setup Early Label Constraints
    fileprivate func setupEarlyLabelConstraints() {
        addSubview(earlyGameLabel)
        NSLayoutConstraint.activate([
            earlyGameLabel.topAnchor.constraint(equalTo: teamCompTier.bottomAnchor, constant: 10),
            earlyGameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            earlyGameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3)
        ])
    }
    
    
    //MARK: Setup Early Stack Constraints
    fileprivate func setupEarlyStackViewConstraints() {
        addSubview(earlyGameStack)
        NSLayoutConstraint.activate([
            earlyGameStack.topAnchor.constraint(equalTo: earlyGameLabel.bottomAnchor, constant: 6),
            earlyGameStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            earlyGameStack.centerXAnchor.constraint(equalTo: earlyGameLabel.centerXAnchor),
            earlyGameStack.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    
    //MARK: Setup Mid Label Constraints
    fileprivate func setupMidLabelConstraints() {
        addSubview(midGameLabel)
        NSLayoutConstraint.activate([
            midGameLabel.topAnchor.constraint(equalTo: earlyGameLabel.topAnchor),
            midGameLabel.leadingAnchor.constraint(equalTo: earlyGameLabel.trailingAnchor, constant: 10),
            midGameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6)
        ])
    }
    
    
    //MARK: Setup Mid Stack Constraints
    fileprivate func setupMidStackViewConstraints() {
        addSubview(midGameStack)
        NSLayoutConstraint.activate([
            midGameStack.topAnchor.constraint(equalTo: midGameLabel.bottomAnchor, constant: 6),
            midGameStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            midGameStack.centerXAnchor.constraint(equalTo: midGameLabel.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
