//
//  ChampStatsStack.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 03/08/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class ChampStatsStack: BaseStack {

    //MARK:- Properties
    let healthStat: StatView
    let armorStat: StatView
    let magicResistStat: StatView
    let attDmgStat: StatView
    let attSpdStat: StatView
    let rangeStat: StatView
    
    let statsColOne = BaseStack(axis: .vertical)
    let statsColTwo = BaseStack(axis: .vertical)
    let statsColThree = BaseStack(axis: .vertical)
    
    //MARK:- Init
    init(stackDistrib: UIStackView.Distribution, colSpacing: CGFloat = 0, iconSize: CGFloat = 15, fontSize: CGFloat = 12, fontWeight: UIFont.Weight = .bold) {
        self.healthStat = StatView(iconSize: iconSize, fontSize: fontSize, fontWeight: fontWeight)
        self.armorStat = StatView(iconSize: iconSize, fontSize: fontSize, fontWeight: fontWeight)
        self.magicResistStat = StatView(iconSize: iconSize, fontSize: fontSize, fontWeight: fontWeight)
        self.attDmgStat = StatView(iconSize: iconSize, fontSize: fontSize, fontWeight: fontWeight)
        self.attSpdStat = StatView(iconSize: iconSize, fontSize: fontSize, fontWeight: fontWeight)
        self.rangeStat = StatView(iconSize: iconSize, fontSize: fontSize, fontWeight: fontWeight)
        
        super.init(frame: .zero)
        axis = .horizontal
        distribution = stackDistrib
        configureStatIcons()
        addArrangedSubviews(statsColOne, statsColTwo, statsColThree)
        setupColumns(colSpacing)
    }
    
    
    //MARK:- Setup Columns Subviews
    fileprivate func setupColumns(_ colSpacing: CGFloat) {
        statsColOne.spacing = colSpacing
        statsColTwo.spacing = colSpacing
        statsColThree.spacing = colSpacing
        statsColOne.addArrangedSubviews(healthStat, attDmgStat)
        statsColTwo.addArrangedSubviews(armorStat, attSpdStat)
        statsColThree.addArrangedSubviews(magicResistStat, rangeStat)
    }
    
    
    //MARK:- Configure Stat Icons
    fileprivate func configureStatIcons() {
        healthStat.updateStatIcon(statType: .health)
        armorStat.updateStatIcon(statType: .armor)
        magicResistStat.updateStatIcon(statType: .magicResist)
        attDmgStat.updateStatIcon(statType: .attDmg)
        attSpdStat.updateStatIcon(statType: .attSpd)
        rangeStat.updateStatIcon(statType: .range)
    }
    
    
    //MARK:- Set Stat Labels
    func setStatLabels(for champStat: ChampionStats) {
        healthStat.statLabel.text = String(champStat.health)
        armorStat.statLabel.text = String(champStat.armor)
        magicResistStat.statLabel.text = String(champStat.magicResist)
        attDmgStat.statLabel.text = String(champStat.attackDamage)
        attSpdStat.statLabel.text = String(champStat.attackSpeed)
        rangeStat.statLabel.text = String(champStat.range)
    }
    
    
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
