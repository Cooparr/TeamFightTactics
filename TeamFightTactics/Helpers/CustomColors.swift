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
    static let richBlack    = UIColor(red: 4, green: 21, blue: 31)
    static let charcoal     = UIColor(red: 27, green: 33, blue: 44)
    static let independence = UIColor(red: 50, green: 80, blue: 107)
    static let romanSilver  = UIColor(red: 139, green: 140, blue: 154)
    static let platinum     = UIColor(red: 234, green: 232, blue: 233)
    
    enum Highlighted {
        static let richBlack    = UIColor(red: 19, green: 36, blue: 46)
        static let charcoal     = UIColor(red: 42, green: 48, blue: 59)
    }
}


//MARK: Stat Icon Colors
enum StatIconColor {
    static let health           = UIColor(red: 75, green: 150, blue: 98)
    static let armor            = UIColor(red: 223, green: 119, blue: 97)
    static let magicResist      = UIColor(red: 196, green: 146, blue: 205)
    static let attDamage        = UIColor(red: 179, green: 128, blue: 85)
    static let attSpeed         = UIColor(red: 235, green: 197, blue: 102)
    static let range            = UIColor(red: 142, green: 160, blue: 179)
    static let mana             = UIColor(red: 96, green: 192, blue: 238)
    static let abilityPower     = UIColor(red: 179, green: 252, blue: 246)
    static let critChance       = UIColor(red: 206, green: 59, blue: 68)
    static let dodgeChance      = UIColor(red: 236, green: 218, blue: 151)
}


//MARK: Champ Cost Colors
enum ChampCostColor {
    static let one      = UIColor(red: 33, green: 48, blue: 66).cgColor
    static let two      = UIColor(red: 21, green: 104, blue: 49).cgColor
    static let three    = UIColor(red: 19, green: 64, blue: 124).cgColor
    static let four     = UIColor(red: 137, green: 48, blue: 136).cgColor
    static let five     = UIColor(red: 184, green: 157, blue: 39).cgColor
}


//MARK: Champ Cost Rainbow Colors
enum ChampCostRainbowColor {
    private static let purple   = UIColor(red: 184, green: 39, blue: 252).cgColor
    private static let blue     = UIColor(red: 44, green: 144, blue: 252).cgColor
    private static let lime     = UIColor(red: 184, green: 253, blue: 51).cgColor
    private static let orange   = UIColor(red: 254, green: 200, blue: 55).cgColor
    private static let pink     = UIColor(red: 253, green: 24, blue: 146).cgColor
    static let rainbow          = [purple, blue, lime, orange, pink]
}


//MARK: Cost View Gradient Colors
enum CostViewGradientColor {
    private static let leftColor    = UIColor(red: 230, green: 219, blue: 54).cgColor
    private static let rightColor   = UIColor(red: 254, green: 138, blue: 87).cgColor
    static let rainbow              = [leftColor, rightColor]
}


//MARK: Tier Rating Colors
enum TierRatingColor {
    static let sTier        = UIColor(red: 255, green: 127, blue: 127)
    static let aTier        = UIColor(red: 255, green: 191, blue: 126)
    static let bTier        = UIColor(red: 254, green: 223, blue: 127)
    static let cTier        = UIColor(red: 255, green: 255, blue: 127)
    static let dTier        = UIColor(red: 191, green: 255, blue: 127)
    static let noTier     = UIColor(red: 127, green: 255, blue: 127)
}


//MARK: Trait Rating Colors
enum TraitRatingColor {
    static let chosen   = UIColor(red: 183, green: 102, blue: 208)
    static let gold     = UIColor(red: 223, green: 181, blue: 0)
    static let silver   = UIColor(red: 140, green: 160, blue: 179)
    static let bronze   = UIColor(red: 158, green: 93, blue: 63)
    static let other    = UIColor(red: 19, green: 64, blue: 124)
    static let rainbow  = ChampCostRainbowColor.rainbow
}
