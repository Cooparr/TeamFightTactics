//
//  CustomColors.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 05/08/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit



//MARK: Coolors Theme Colors
enum ThemeColor {
    static let richBlack = UIColor(red: 4/255, green: 21/255, blue: 31/255, alpha: 1)
    static let charcoal = UIColor(red: 27/255, green: 33/255, blue: 44/255, alpha: 1)
    static let independence = UIColor(red: 50/255, green: 80/255, blue: 107/255, alpha: 1)
    static let romanSilver = UIColor(red: 139/255, green: 140/255, blue: 154/255, alpha: 1)
    static let platinum = UIColor(red: 234/255, green: 232/255, blue: 233/255, alpha: 1)
}


//MARK: Stat Icon Colors
enum StatIconColor {
    static let health = UIColor(red: 75/255, green: 150/255, blue: 98/255, alpha: 1)
    static let armor = UIColor(red: 223/255, green: 119/255, blue: 97/255, alpha: 1)
    static let magicResist = UIColor(red: 196/255, green: 146/255, blue: 205/255, alpha: 1)
    static let attDamage = UIColor(red: 179/255, green: 128/255, blue: 85/255, alpha: 1)
    static let attSpeed = UIColor(red: 235/255, green: 197/255, blue: 102/255, alpha: 1)
    static let range = UIColor(red: 142/255, green: 160/255, blue: 179/255, alpha: 1)
    static let mana = UIColor(red: 96/255, green: 192/255, blue: 238/255, alpha: 1)
    static let abilityPower = UIColor(red: 179/255, green: 252/255, blue: 246/255, alpha: 1)
    static let critChance = UIColor(red: 206/255, green: 59/255, blue: 68/255, alpha: 1)
    static let dodgeChance = UIColor(red: 236/255, green: 218/255, blue: 151/255, alpha: 1)
}


//MARK: Champ Cost Colors
enum ChampCostColor {
    static let oneCost = UIColor(red: 33/255, green: 48/255, blue: 66/255, alpha: 1).cgColor
    static let twoCost = UIColor(red: 21/255, green: 104/255, blue: 49/255, alpha: 1).cgColor
    static let threeCost = UIColor(red: 19/255, green: 64/255, blue: 124/255, alpha: 1).cgColor
    static let fourCost = UIColor(red: 137/255, green: 48/255, blue: 136/255, alpha: 1).cgColor
    static let fiveCost = UIColor(red: 184/255, green: 157/255, blue: 39/255, alpha: 1).cgColor
}


//MARK: Champ Cost Rainbow Colors
enum ChampCostRainbowColor {
    private static let purple = UIColor(red: 184/255, green: 39/255, blue: 252/255, alpha: 1).cgColor
    private static let blue = UIColor(red: 44/255, green: 144/255, blue: 252/255, alpha: 1).cgColor
    private static let lime = UIColor(red: 184/255, green: 253/255, blue: 51/255, alpha: 1).cgColor
    private static let orange = UIColor(red: 254/255, green: 200/255, blue: 55/255, alpha: 1).cgColor
    private static let pink = UIColor(red: 253/255, green: 24/255, blue: 146/255, alpha: 1).cgColor
    static let rainbow = [purple, blue, lime, orange, pink]
}


//MARK: Cost View Gradient Colors
enum CostViewGradientColor {
    static let leftColor = UIColor(red: 230/255, green: 219/255, blue: 54/255, alpha: 1).cgColor
    static let rightColor = UIColor(red: 254/255, green: 138/255, blue: 87/255, alpha: 1).cgColor
}


//MARK: Tier Rating Colors
enum TierRatingColor {
    static let sTier = UIColor(red: 255/255, green: 127/255, blue: 127/255, alpha: 1)
    static let aTier = UIColor(red: 255/255, green: 191/255, blue: 126/255, alpha: 1)
    static let bTier = UIColor(red: 254/255, green: 223/255, blue: 127/255, alpha: 1)
    static let cTier = UIColor(red: 255/255, green: 255/255, blue: 127/255, alpha: 1)
    static let dTier = UIColor(red: 191/255, green: 255/255, blue: 127/255, alpha: 1)
    static let eTier = UIColor(red: 127/255, green: 255/255, blue: 127/255, alpha: 1)
}


//MARK: Trait Rating Colors
enum TraitRatingColor {
    static let gold = UIColor(red: 223/255, green: 181/255, blue: 0/255, alpha: 1)
    static let silver = UIColor(red: 140/255, green: 160/255, blue: 179/255, alpha: 1)
    static let bronze = UIColor(red: 158/255, green: 93/255, blue: 63/255, alpha: 1)
    static let other = UIColor(red: 19/255, green: 64/255, blue: 124/255, alpha: 1)
}


//MARK: Error Color
enum ErrorColor {
    static let error = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)
}
