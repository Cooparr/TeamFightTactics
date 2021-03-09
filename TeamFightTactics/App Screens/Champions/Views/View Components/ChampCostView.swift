//
//  ChampCostView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 03/08/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class ChampCostView: GradientView {
    
    //MARK:- Properties
    let costLabel = BaseLabel(fontSize: 12, fontWeight: .bold)
    let costIcon = IconImageView(icon: StatIcon.gold)
    
    
    //MARK:- Configure Cost View
    func configureCostView(for cost: Cost) {
        setupView()
        
        costLabel.text = String(cost.rawValue)
        (costLabel.textColor, costIcon.tintColor) = setLabelAndIconThemeColor(for: cost)
        
        guard let layer = self.layer as? CAGradientLayer else { return }
        layer.colors = setGradientCostColor(for: cost)
    }
    
    
    
    //MARK:- Setup View
    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 2.0
        
        addSubviews(costLabel, costIcon)
        NSLayoutConstraint.activate([
            costIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            costIcon.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -5),
            costIcon.widthAnchor.constraint(equalToConstant: 10),
            
            costLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            costLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 6)
        ])
    }
    
    
    //MARK:- Get Cost Color
    fileprivate func setLabelAndIconThemeColor(for cost: Cost) -> (UIColor, UIColor) {
        switch cost {
        case .one, .two, .three, .four, .five:
            return (ThemeColor.platinum, ThemeColor.platinum)
        case .six, .seven:
            return (ThemeColor.charcoal, ThemeColor.charcoal)
        }
    }
    
    
    //MARK:- Get Cost Color
    fileprivate func setGradientCostColor(for cost: Cost) -> [CGColor] {
        switch cost {
        case .one:
            return [ChampCostColor.one, ChampCostColor.one]
        case .two:
            return [ChampCostColor.two, ChampCostColor.two]
        case .three:
            return [ChampCostColor.three, ChampCostColor.three]
        case .four:
            return [ChampCostColor.four, ChampCostColor.four]
        case .five:
            return [ChampCostColor.five, ChampCostColor.five]
        case .six, .seven:
            return CostViewGradientColor.rainbow
        }
    }
}