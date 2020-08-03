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
    let healthStat = StatView(statWidth: 55, iconSize: 15, fontSize: 12, fontWeight: .bold)
    let armorStat = StatView(statWidth: 55, iconSize: 15, fontSize: 12, fontWeight: .bold)
    let magicResistStat = StatView(statWidth: 55, iconSize: 15, fontSize: 12, fontWeight: .bold)
    let attackDamageStat = StatView(statWidth: 55, iconSize: 15, fontSize: 12, fontWeight: .bold)
    let attackSpeedStat = StatView(statWidth: 55, iconSize: 15, fontSize: 12, fontWeight: .bold)
    let rangeStat = StatView(statWidth: 55, iconSize: 15, fontSize: 12, fontWeight: .bold)
    
    lazy var statsTopRow: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [healthStat, armorStat, magicResistStat])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 4
        return stack
    }()
    
    lazy var statsBotRow: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [attackDamageStat, attackSpeedStat, rangeStat])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 4
        return stack
    }()
    
    
    //MARK:- Setup Stack
    override func setupStack() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        spacing = 4
        configureStatIcons()
    }
    
    
    //MARK:- Setup Arranged Subviews
    override func setupArrangedSubviews() {
        addArrangedSubview(statsTopRow)
        addArrangedSubview(statsBotRow)
    }
    
    
    //MARK:- Configure Stat Icons
    fileprivate func configureStatIcons() {
        healthStat.updateStatIcon(statType: .health)
        armorStat.updateStatIcon(statType: .armor)
        magicResistStat.updateStatIcon(statType: .magicResist)
        attackDamageStat.updateStatIcon(statType: .attDmg)
        attackSpeedStat.updateStatIcon(statType: .attSpd)
        rangeStat.updateStatIcon(statType: .range)
    }
    
    
    //MARK:- Set Stat Labels
    func setStatLabels(for champStat: ChampionStats) {
        healthStat.statLabel.text = String(champStat.health)
        armorStat.statLabel.text = String(champStat.armor)
        magicResistStat.statLabel.text = String(champStat.magicResist)
        attackDamageStat.statLabel.text = String(champStat.attackDamage)
        attackSpeedStat.statLabel.text = String(champStat.attackSpeed)
        rangeStat.statLabel.text = String(champStat.range)
    }
}
