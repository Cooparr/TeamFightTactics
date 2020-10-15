//
//  TCTraitsView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 01/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCTraitsView: BaseView {
    
    //MARK:- Properties
    let synergiesStackView = BaseStack(axis: .vertical, spacing: 8)
    let traitsLabel: BaseLabel = {
        let lbl = BaseLabel(fontSize: 20, fontWeight: .regular, lblText: "Synergies")
        lbl.textAlignment = .center
        return lbl
    }()

    
    //MARK:- Setup View
    override func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ThemeColor.richBlack
    }
    
    
    //MARK: Setup Subviews
    override func setupSubviews() {
        setupTraitsLabelConstraints()
        setupSynergiesStackViewConstraints()
    }
    
    
    //MARK: Setup Traits Label Constraints
    fileprivate func setupTraitsLabelConstraints() {
        addSubview(traitsLabel)
        NSLayoutConstraint.activate([
            traitsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            traitsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            traitsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    
    //MARK: Setup Synergies Stack View
    fileprivate func setupSynergiesStackViewConstraints() {
        addSubview(synergiesStackView)
        NSLayoutConstraint.activate([
            synergiesStackView.topAnchor.constraint(equalTo: traitsLabel.bottomAnchor, constant: 10),
            synergiesStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            synergiesStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            synergiesStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
