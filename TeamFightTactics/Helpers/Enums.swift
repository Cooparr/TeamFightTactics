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
enum Cost: Int, Decodable {
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
    func setChampCostBorderColor(imgViewLayer: CALayer) {
        switch self {
        case .one:
            imgViewLayer.borderColor = ChampCostColor.oneCost
        case .two:
            imgViewLayer.borderColor = ChampCostColor.twoCost
        case .three:
            imgViewLayer.borderColor = ChampCostColor.threeCost
        case .four:
            imgViewLayer.borderColor = ChampCostColor.fourCost
        case .five:
            imgViewLayer.borderColor = ChampCostColor.fiveCost
        case .six, .seven:
            imgViewLayer.borderWidth = 0
            
            let gradient = CAGradientLayer()
            gradient.frame =  CGRect(origin: CGPoint.zero, size: imgViewLayer.frame.size)
            gradient.cornerRadius = 2.0
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 1, y: 1)
            gradient.colors = ChampCostRainbowColor.rainbow
            
            let shape = CAShapeLayer()
            shape.path = UIBezierPath(rect: imgViewLayer.bounds).cgPath
            shape.lineWidth = 2
            shape.strokeColor = UIColor.black.cgColor
            shape.fillColor = UIColor.clear.cgColor
            
            gradient.mask = shape
            imgViewLayer.addSublayer(gradient)
        }
    }
}


//MARK:- TierRating
enum TierRating: Int, Decodable {
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
enum DropRateTier: String, Decodable {
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
enum SynergyRank: Int, Decodable {
    case gold = 0
    case silver
    case bronze
    case other
    
    init(fromRawValue: Int) {
        self = SynergyRank(rawValue: fromRawValue) ?? .other
    }
    
    func setRankColor() -> UIColor {
        switch self {
        case .gold:
            return TraitRatingColor.gold
        case .silver:
            return TraitRatingColor.silver
        case .bronze:
            return TraitRatingColor.bronze
        case .other:
            return TraitRatingColor.other
        }
    }
}


//MARK:- SynergyRank
enum StatType: String, Decodable {
    
    case attDmg = "ad"
    case attSpd = "as"
    case armor = "ar"
    case health = "hp"
    case abilityPower = "ap"
    case magicResist = "mr"
    case critChance = "cr"
    case dodgeChance = "dg"
    case mana = "mana"
    case range = "rg"
    
    init?(rawString: String) {
        switch rawString {
        case "ad": self = .attDmg
        case "as": self = .attSpd
        case "ar": self = .armor
        case "hp": self = .health
        case "ap": self = .abilityPower
        case "mr": self = .magicResist
        case "cr": self = .critChance
        case "dg": self = .dodgeChance
        case "mana": self = .mana
        case "rg": self = .range
        default: return nil
        }
    }
}
