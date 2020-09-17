//
//  TCEndGameView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 04/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCEndGameView: BaseView {
    
    //MARK: Properties
    var endGameImages = [TCChampImage]()
    let endGameLabel: BaseLabel = {
        let lbl = BaseLabel(fontSize: 20, fontWeight: .regular)
        lbl.text = "End Game"
        lbl.textAlignment = .center
        return lbl
    }()
    
    let champImageStacks: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        for _ in 1...2 {
            let rowStack = UIStackView()
            rowStack.translatesAutoresizingMaskIntoConstraints = false
            rowStack.alignment = .top
            rowStack.distribution = .equalSpacing
            stack.addArrangedSubview(rowStack)
        }
        return stack
    }()
    
    
    //MARK:- Setup View
    override func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ThemeColor.richBlack
    }
    
    
    //MARK: Setup Subviews
    override func setupSubviews() {
        setupLabelConstraints()
        setupChampImageStackConstraints()
    }
    
    
    //MARK: Setup Label Constraints
    fileprivate func setupLabelConstraints() {
        addSubview(endGameLabel)
        NSLayoutConstraint.activate([
            endGameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            endGameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            endGameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    
    //MARK: Setup End Game Constraints
    fileprivate func setupChampImageStackConstraints() {
        addSubview(champImageStacks)
        NSLayoutConstraint.activate([
            champImageStacks.topAnchor.constraint(equalTo: endGameLabel.bottomAnchor, constant: 6),
            champImageStacks.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            champImageStacks.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            champImageStacks.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
