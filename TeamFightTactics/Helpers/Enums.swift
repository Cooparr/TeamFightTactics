//
//  Enums.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 13/11/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import Foundation
import UIKit

enum Cost: Int {
    case one = 1
    case two
    case three
    case four
    case five
    case six
    case seven
    
    init(fromRawValue: Int) {
        self = Cost(rawValue: fromRawValue) ?? .seven
    }
    
    func setCostBorder(for view: UIView){
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: view.layer.frame.size)
        gradient.cornerRadius = 2.0
        
        let shape = CAShapeLayer()
        shape.lineWidth = 4
        shape.path = UIBezierPath(rect: view.layer.bounds).cgPath
        shape.strokeColor = UIColor.black.cgColor
        
        switch view {
        case is UIImageView:
            view.layer.sublayers = nil
            switch self {
            case .one:
                view.layer.borderColor = CustomColor.oneCost
            case .two:
                view.layer.borderColor = CustomColor.twoCost
            case .three:
                view.layer.borderColor = CustomColor.threeCost
            case .four:
                view.layer.borderColor = CustomColor.fourCost
            case .five:
                view.layer.borderColor = CustomColor.fiveCost
            case .six, .seven:
                gradient.startPoint = CGPoint(x: 0, y: 0)
                gradient.endPoint = CGPoint(x: 1, y: 1)
                gradient.colors = [CustomColor.purple, CustomColor.blue, CustomColor.lime, CustomColor.orange, CustomColor.pink]
                shape.fillColor = UIColor.clear.cgColor
                view.layer.borderWidth = 0
            }
                        
        default:
            switch self {
            case .one:
                view.layer.backgroundColor = CustomColor.oneCost
            case .two:
                view.layer.backgroundColor = CustomColor.twoCost
            case .three:
                view.layer.backgroundColor = CustomColor.threeCost
            case .four:
                view.layer.backgroundColor = CustomColor.fourCost
            case .five:
                view.layer.backgroundColor = CustomColor.fiveCost
            case .six, .seven:
                gradient.startPoint = CGPoint(x: 0, y: 0.5)
                gradient.endPoint = CGPoint(x: 1, y: 0.5)
                gradient.colors = [CustomColor.gradientLeftColor, CustomColor.gradientRightColor]
            }
        }
        
        gradient.mask = shape
        view.layer.insertSublayer(gradient, at: 0)
    }
}


enum TierRating: Int {
    case sTier = 0
    case aTier
    case bTier
    case cTier
    case dTier
    case errorTier
    
    init(fromRawValue: Int) {
        self = TierRating(rawValue: fromRawValue) ?? .errorTier
    }
    
    func setTierTextAndColor(for tierLabel: UILabel) {
        switch self {
        case .sTier:
            tierLabel.text = "S Tier"
            tierLabel.backgroundColor = CustomColor.sTier
        case .aTier:
            tierLabel.text = "A Tier"
            tierLabel.backgroundColor = CustomColor.aTier
        case .bTier:
            tierLabel.text = "B Tier"
            tierLabel.backgroundColor = CustomColor.bTier
        case .cTier:
            tierLabel.text = "C Tier"
            tierLabel.backgroundColor = CustomColor.cTier
        case .dTier:
            tierLabel.text = "D Tier"
            tierLabel.backgroundColor = CustomColor.dTier
        default:
            tierLabel.text = "E Tier"
            tierLabel.backgroundColor = CustomColor.eTier
        }
    }    
}


enum SynergyRank: Int {
    case gold = 0
    case silver
    case bronze
    case error
}
