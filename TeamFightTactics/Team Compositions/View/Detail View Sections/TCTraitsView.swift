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
    let traitsLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Synergies"
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        lbl.textAlignment = .center
        lbl.textColor = ThemeColor.platinum
        return lbl
    }()
    
    let synergiesStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        return stack
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
