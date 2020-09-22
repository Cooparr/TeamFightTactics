//
//  ChampCostView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 03/08/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class ChampCostView: BaseView {
    
    //MARK:- Properties
    let costLabel = BaseLabel(fontSize: 12, fontWeight: .bold)
    let costIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = StatIcon.gold
        imgView.tintColor = ThemeColor.platinum
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    
    //MARK:- Setup View
    override func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 2.0
    }
    
    
    //MARK:- Setup Subviews
    override func setupSubviews() {
        addSubviews(costLabel, costIcon)
        NSLayoutConstraint.activate([
            costIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            costIcon.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -5),
            costIcon.widthAnchor.constraint(equalToConstant: 10),
            
            costLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            costLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 6)
        ])
    }
    
    
    //MARK:- Configure Cost View
    func configureCostView(for cost: Champion.Cost) {
        costLabel.text = String(cost.rawValue)
        setCostViewBackground(for: cost, icon: costIcon, label: costLabel)
    }
    
    
    //MARK:- Set Cost View Background
    fileprivate func setCostViewBackground(for cost: Champion.Cost, icon: UIImageView, label: UILabel) {
        switch cost {
        case .one:
            layer.backgroundColor = ChampCostColor.oneCost
        case .two:
            layer.backgroundColor = ChampCostColor.twoCost
        case .three:
            layer.backgroundColor = ChampCostColor.threeCost
        case .four:
            layer.backgroundColor = ChampCostColor.fourCost
        case .five:
            layer.backgroundColor = ChampCostColor.fiveCost
        case .six, .seven:
            icon.tintColor = ThemeColor.charcoal
            label.textColor = ThemeColor.charcoal
            
            let gradient = CAGradientLayer()
            gradient.frame =  CGRect(origin: CGPoint.zero, size: layer.frame.size)
            gradient.cornerRadius = 2.0
            gradient.startPoint = CGPoint(x: 0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1, y: 0.5)
            gradient.colors = CostViewGradientColor.rainbow
            gradient.name = "gradientLayer"
            
            let shape = CAShapeLayer()
            shape.lineWidth = 4
            shape.path = UIBezierPath(rect: layer.bounds).cgPath
            shape.strokeColor = UIColor.black.cgColor
            
            gradient.mask = shape
            layer.insertSublayer(gradient, at: 0)
        }
    }
}
