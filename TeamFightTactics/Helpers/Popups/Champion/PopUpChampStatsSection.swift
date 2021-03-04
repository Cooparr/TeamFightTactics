//
//  PopUpChampStatsSection.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 13/10/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class PopUpChampStatsSection: BaseView {
    
    //MARK:- Properties
    let champStatsStack = ChampStatsStack(stackDistrib: .equalCentering, colSpacing: 8, iconSize: 18, fontSize: 14, fontWeight: .semibold)
    
    
    //MARK:- Setup View
    override func setupView() {
        addSubview(champStatsStack)
        NSLayoutConstraint.activate([
            champStatsStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75),
            champStatsStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            champStatsStack.topAnchor.constraint(equalTo: topAnchor),
            champStatsStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    //MARK:- Configure Stats Section
    func configureStatsSection(champStat: ChampionStats) {
        champStatsStack.setStatLabels(for: champStat)
    }
}
