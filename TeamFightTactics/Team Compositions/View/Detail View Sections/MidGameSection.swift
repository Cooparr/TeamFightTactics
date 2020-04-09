//
//  MidGameSection.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 09/04/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class MidGameSection: UIView {
    
    //MARK: Properties
    let midGameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Mid Game"
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return lbl
    }()
    
    let midGameStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.spacing = 8
        return stackView
    }()
    
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSection()
        setupLabelConstraints()
        setupStackViewConstraints()
    }
    
    
    //MARK: Setup Section
    fileprivate func setupSection() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = CustomColor.richBlack
    }
    
    
    //MARK: Setup Label Constraints
    fileprivate func setupLabelConstraints() {
        addSubview(midGameLabel)
        NSLayoutConstraint.activate([
            midGameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            midGameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
    }
    
    
    //MARK: Setup Stack Constraints
    fileprivate func setupStackViewConstraints() {
        addSubview(midGameStack)
        NSLayoutConstraint.activate([
            midGameStack.topAnchor.constraint(equalTo: midGameLabel.bottomAnchor, constant: 6),
            midGameStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            midGameStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
