//
//  Enums.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 13/11/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import Foundation
import UIKit

//MARK:- Cost
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
    
    //MARK: Set Champ Image Border
    func setChampImageBorder(for imageView: UIImageView) {
        switch self {
        case .one:
            imageView.layer.borderColor = CustomColor.oneCost
        case .two:
            imageView.layer.borderColor = CustomColor.twoCost
        case .three:
            imageView.layer.borderColor = CustomColor.threeCost
        case .four:
            imageView.layer.borderColor = CustomColor.fourCost
        case .five:
            imageView.layer.borderColor = CustomColor.fiveCost
        case .six, .seven:
            imageView.layer.borderWidth = 0
            
            let gradient = CAGradientLayer()
            gradient.frame =  CGRect(origin: CGPoint.zero, size: imageView.layer.frame.size)
            gradient.cornerRadius = 2.0
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 1, y: 1)
            gradient.colors = [CustomColor.purple, CustomColor.blue, CustomColor.lime, CustomColor.orange, CustomColor.pink]
            
            let shape = CAShapeLayer()
            shape.lineWidth = 4
            shape.path = UIBezierPath(rect: imageView.layer.bounds).cgPath
            shape.strokeColor = UIColor.black.cgColor
            shape.fillColor = UIColor.clear.cgColor
            
            gradient.mask = shape
            imageView.layer.insertSublayer(gradient, at: 0)
        }
    }
    
    
    //MARK: Set Champ Cost View
    func setChampCostView(for costView: UIView, icon: UIImageView, label: UILabel) {
        switch self {
        case .one:
            costView.layer.backgroundColor = CustomColor.oneCost
        case .two:
            costView.layer.backgroundColor = CustomColor.twoCost
        case .three:
            costView.layer.backgroundColor = CustomColor.threeCost
        case .four:
            costView.layer.backgroundColor = CustomColor.fourCost
        case .five:
            costView.layer.backgroundColor = CustomColor.fiveCost
        case .six, .seven:
            icon.tintColor = CustomColor.charcoal
            label.textColor = CustomColor.charcoal
            
            let gradient = CAGradientLayer()
            gradient.frame =  CGRect(origin: CGPoint.zero, size: costView.layer.frame.size)
            gradient.cornerRadius = 2.0
            gradient.startPoint = CGPoint(x: 0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1, y: 0.5)
            gradient.colors = [CustomColor.gradientLeftColor, CustomColor.gradientRightColor]
            gradient.name = "gradientLayer"
            
            let shape = CAShapeLayer()
            shape.lineWidth = 4
            shape.path = UIBezierPath(rect: costView.layer.bounds).cgPath
            shape.strokeColor = UIColor.black.cgColor
            
            gradient.mask = shape
            costView.layer.insertSublayer(gradient, at: 0)
        }
    }
}


//MARK:- TierRating
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


//MARK:- SynergyRank
enum SynergyRank: Int, Equatable {
    case gold = 0
    case silver
    case bronze
    case error
    
    init(fromRawValue: Int) {
        self = SynergyRank(rawValue: fromRawValue) ?? .error
    }
    
    func setBadgeColor() -> UIColor {
        switch self {
        case .gold:
            return CustomColor.goldSynergy
        case .silver:
            return CustomColor.silverSynergy
        case .bronze:
            return CustomColor.bronzeSynergy
        default:
            return CustomColor.error
        }
    }
}
