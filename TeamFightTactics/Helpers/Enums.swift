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
            imageView.layer.borderColor = ChampCostColor.oneCost
        case .two:
            imageView.layer.borderColor = ChampCostColor.twoCost
        case .three:
            imageView.layer.borderColor = ChampCostColor.threeCost
        case .four:
            imageView.layer.borderColor = ChampCostColor.fourCost
        case .five:
            imageView.layer.borderColor = ChampCostColor.fiveCost
        case .six, .seven:
            imageView.layer.borderWidth = 0
            
            let gradient = CAGradientLayer()
            gradient.frame =  CGRect(origin: CGPoint.zero, size: imageView.layer.frame.size)
            gradient.cornerRadius = 2.0
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 1, y: 1)
            gradient.colors = [ChampCostRainbowColor.purple,
                               ChampCostRainbowColor.blue,
                               ChampCostRainbowColor.lime,
                               ChampCostRainbowColor.orange,
                               ChampCostRainbowColor.pink]
            
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
            costView.layer.backgroundColor = ChampCostColor.oneCost
        case .two:
            costView.layer.backgroundColor = ChampCostColor.twoCost
        case .three:
            costView.layer.backgroundColor = ChampCostColor.threeCost
        case .four:
            costView.layer.backgroundColor = ChampCostColor.fourCost
        case .five:
            costView.layer.backgroundColor = ChampCostColor.fiveCost
        case .six, .seven:
            icon.tintColor = ThemeColor.charcoal
            label.textColor = ThemeColor.charcoal
            
            let gradient = CAGradientLayer()
            gradient.frame =  CGRect(origin: CGPoint.zero, size: costView.layer.frame.size)
            gradient.cornerRadius = 2.0
            gradient.startPoint = CGPoint(x: 0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1, y: 0.5)
            gradient.colors = [CostViewGradientColor.leftColor, CostViewGradientColor.rightColor]
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
            tierLabel.backgroundColor = TierRatingColor.sTier
        case .aTier:
            tierLabel.text = "A Tier"
            tierLabel.backgroundColor = TierRatingColor.aTier
        case .bTier:
            tierLabel.text = "B Tier"
            tierLabel.backgroundColor = TierRatingColor.bTier
        case .cTier:
            tierLabel.text = "C Tier"
            tierLabel.backgroundColor = TierRatingColor.cTier
        case .dTier:
            tierLabel.text = "D Tier"
            tierLabel.backgroundColor = TierRatingColor.dTier
        default:
            tierLabel.text = "E Tier"
            tierLabel.backgroundColor = TierRatingColor.eTier
        }
    }    
}


//MARK:- DropRateTier
enum DropRateTier: String {
    case one = "Tier 1"
    case two = "Tier 2"
    case three = "Tier 3"
    case four = "Tier 4"
    case five = "Tier 5"
    
    init(fromRawValue: String) {
        self = DropRateTier(rawValue: fromRawValue) ?? DropRateTier(fromRawValue: "Error")
    }
    
    func setBackgroundColor(for label: UILabel) {
        switch self {
        case .one:
            label.backgroundColor = UIColor(cgColor: ChampCostColor.oneCost)
        case .two:
            label.backgroundColor = UIColor(cgColor: ChampCostColor.twoCost)
        case .three:
            label.backgroundColor = UIColor(cgColor: ChampCostColor.threeCost)
        case .four:
            label.backgroundColor = UIColor(cgColor: ChampCostColor.fourCost)
        case .five:
            label.backgroundColor = UIColor(cgColor: ChampCostColor.fiveCost)
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
            return TraitRatingColor.gold
        case .silver:
            return TraitRatingColor.silver
        case .bronze:
            return TraitRatingColor.bronze
        default:
            return ErrorColor.error
        }
    }
}
