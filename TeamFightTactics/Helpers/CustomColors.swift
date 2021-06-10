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
    static let richBlack            = UIColor(bundleName: "RichBlack")
    static let charcoal             = UIColor(bundleName: "Charcoal")
    static let independence         = UIColor(bundleName: "Independence")
    static let romanSilver          = UIColor(bundleName: "RomanSilver")
    static let platinum             = UIColor(bundleName: "Platinum")
    
    enum Highlighted {
        static let richBlack        = UIColor(bundleName: "HL-RichBlack")
        static let charcoal         = UIColor(bundleName: "HL-Charcoal")
    }
}


//MARK: Stat Icon Colors
enum StatIconColor {
    static let abilityPower         = UIColor(bundleName: "AbilityPower")
    static let armor                = UIColor(bundleName: "Armor")
    static let attDamage            = UIColor(bundleName: "AttackDamage")
    static let attSpeed             = UIColor(bundleName: "AttackSpeed")
    static let critChance           = UIColor(bundleName: "CriticalChance")
    static let dodgeChance          = UIColor(bundleName: "DodgeChance")
    static let health               = UIColor(bundleName: "Health")
    static let magicResist          = UIColor(bundleName: "MagicResist")
    static let mana                 = UIColor(bundleName: "Mana")
    static let range                = UIColor(bundleName: "Range")
}


//MARK: Champ Cost Colors
enum ChampCostColor {
    static let one                  = UIColor(bundleName: "One").cgColor
    static let two                  = UIColor(bundleName: "Two").cgColor
    static let three                = UIColor(bundleName: "Three").cgColor
    static let four                 = UIColor(bundleName: "Four").cgColor
    static let five                 = UIColor(bundleName: "Five").cgColor
}


//MARK: Champ Cost Rainbow Colors
enum ChampCostRainbowColor {
    private static let purple       = UIColor(bundleName: "RB-Purple").cgColor
    private static let blue         = UIColor(bundleName: "RB-Blue").cgColor
    private static let lime         = UIColor(bundleName: "RB-Lime").cgColor
    private static let orange       = UIColor(bundleName: "RB-Orange").cgColor
    private static let pink         = UIColor(bundleName: "RB-Pink").cgColor
    static let rainbow              = [purple, blue, lime, orange, pink]
}


//MARK: Cost View Gradient Colors
enum CostViewGradientColor {
    private static let leftColor    = UIColor(bundleName: "LeftColor").cgColor
    private static let rightColor   = UIColor(bundleName: "RightColor").cgColor
    static let rainbow              = [leftColor, rightColor]
}


//MARK: Tier Rating Colors
enum TierRatingColor {
    static let sTier                = UIColor(bundleName: "STier")
    static let aTier                = UIColor(bundleName: "ATier")
    static let bTier                = UIColor(bundleName: "BTier")
    static let cTier                = UIColor(bundleName: "CTier")
    static let dTier                = UIColor(bundleName: "DTier")
    static let noTier               = UIColor(bundleName: "NoTier")
}


//MARK: Trait Rating Colors
enum TraitRatingColor {
    static let chosen               = UIColor(bundleName: "Chosen")
    static let gold                 = UIColor(bundleName: "Gold")
    static let silver               = UIColor(bundleName: "Silver")
    static let bronze               = UIColor(bundleName: "Bronze")
    static let unranked             = UIColor(bundleName: "Unranked")
    static let rainbow              = ChampCostRainbowColor.rainbow
}
