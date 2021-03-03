//
//  DisplayDetailedTeamCompView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 02/03/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class DisplayDetailedTeamCompView: BaseView {
    
    //MARK: Properties
    let synergiesStackView = BaseStack(axis: .vertical, spacing: 8)
    let champImgViewStacks = ChampImagesStackView(axis: .vertical, spacing: 20)
    
    
    //MARK: Override Setup View
    override func setupView() {
        setupChampImageStack()
        setupSynergiesStack()
    }
    
    
    //MARK: Setup Champ Image Stack
    fileprivate func setupChampImageStack() {
        addSubview(champImgViewStacks)
        NSLayoutConstraint.activate([
            champImgViewStacks.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            champImgViewStacks.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            champImgViewStacks.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    
    //MARK: Setup Synergies Stack
    fileprivate func setupSynergiesStack() {
        addSubview(synergiesStackView)
        NSLayoutConstraint.activate([
            synergiesStackView.topAnchor.constraint(equalTo: champImgViewStacks.bottomAnchor, constant: 30),
            synergiesStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            synergiesStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
}
