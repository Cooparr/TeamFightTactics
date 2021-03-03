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
    let champImageStacks = ChampImagesStackView(axis: .vertical, spacing: 20)
    let endGameLabel: BaseLabel = {
        let lbl = BaseLabel(fontSize: 20, fontWeight: .regular, lblText: "End Game")
        lbl.textAlignment = .center
        return lbl
    }()

    
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
