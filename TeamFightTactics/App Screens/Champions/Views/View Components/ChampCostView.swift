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
    private(set) var costViewTint = ThemeColor.platinum
    private let costLabel = BaseLabel(fontSize: 12, fontWeight: .bold)
    private let costIcon = IconImageView(icon: StatIcon.gold)
    
    
    //MARK:- Override Init
    override init(gradientDirection: GradientView.GradientDirection) {
        super.init(gradientDirection: gradientDirection)
        setupView()
    }
    
    
    //MARK:- Configure Cost View
    func configureCostView(for cost: Cost) {
        costViewTint = cost == .seven ? ThemeColor.charcoal : ThemeColor.platinum
        costLabel.text = String(cost.rawValue)
        costLabel.textColor = costViewTint
        costIcon.tintColor = costViewTint
        setCostViewGradientColor(for: cost)
    }
    
    
    //MARK:- Setup View
    private func setupView() {
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
    
    
    //MARK:- Set Cost View Color
    private func setCostViewGradientColor(for cost: Cost) {
        switch cost {
        case .one, .two, .three, .four, .five, .six:
            updateGradientColors(for: cost)
        case .seven:
            guard let layer = self.layer as? CAGradientLayer else { return }
            layer.colors = CostViewGradientColor.rainbow
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
