//
//  Constants.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 24/02/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

//MARK: Set Numbers
enum TFTSet: Int {
    case one    = 1
    case two    = 2
    case three  = 3
    case four   = 4
    
    //MARK: TFT Patch Numbers
    enum TFTSetString: String {
        case setOne     = "Set One"
        case setTwo     = "Set Two"
        case setThree   = "Set Three"
        case setFour    = "Set Four"
    }
    
    //MARK: TFT Patch Numbers
    enum PatchNumber: String {
        case setOne     = "9.21"
        case setTwo     = "10.5"
        case setThree   = "10.18"
        case setFour    = "10.22"
    }
    
    //MARK: Get Set Number as String
    func getSetAsString() -> TFTSetString {
        switch self {
        case .one:
            return .setOne
        case .two:
            return .setTwo
        case .three:
            return .setThree
        case .four:
            return .setFour
        }
    }
    
    
    //MARK: Get Patch Number
    func getPatchNumber() -> PatchNumber {
        switch self {
        case .one:
            return .setOne
        case .two:
            return .setTwo
        case .three:
            return .setThree
        case .four:
            return .setFour
        }
    }
}


//MARK: User Defaults Keys
enum UDKey {
    static let launchKey    = "FirstTimeLaunch"
    static let sleepKey     = "AllowScreenSleep"
    static let skinsKey     = "SetSkins"
    static let setKey       = "FetchedSet"
    static let tabKey       = "DefaultTab"
    static let displayedSet = "displayedSet"
}

enum LastUpdateKey: String {
    case items      = "itemsLastUpdate"
    case champs     = "champsLastUpdate"
    case teamComps  = "teamCompsLastUpdate"
    case patchNotes = "patchNotesLastUpdate"
    case traits     = "traitsLastUpdate"
    case classes    = "classesLastUpdate"
    case origins    = "originsLastUpdate"
    case dropRates  = "dropRatesLastUpdate"
    case galaxies   = "galaxiesLastUpdate"
}


//MARK: Tab Index Numbers
enum Tab: Int {
    case items      = 0
    case champions  = 1
    case teamComps  = 2
    case patchNotes = 3
    case more       = 4
}


//MARK: Tab Bar Titles
enum TabTitle: String {
    case items          = "Items"
    case champs         = "Champions"
    case teamComps      = "Team Comps"
    case patchNotes     = "Patch Notes"
    case traits         = "Traits"
    case more           = "More"
    case dropRates      = "Drop Rates"
    case galaxies       = "Galaxies"
    case settings       = "Settings"
    case createTeamComp = "Create Team Comp"
}


//MARK: Menu Bar Titles
enum MenuBarTitle: String {
    case base       = "Base"
    case combined   = "Combined"
    case classes    = "Classes"
    case origins    = "Origins"
    case meta       = "Meta"
    case custom     = "My Comps"
}


//MARK: Tab Bar Icons
enum TabIcon {
    static let item         = UIImage(named: "Item")
    static let champ        = UIImage(named: "Champ")
    static let teamComp     = UIImage(named: "TeamComp")
    static let patchNotes   = UIImage(named: "PatchNotes")
    static let traits       = UIImage(named: "Traits")
    static let dropRate     = UIImage(named: "DropRate")
    static let more         = UIImage(named: "More")
    static let galaxies     = UIImage(named: "Galaxies")
}


//MARK: Stat Icons
enum StatIcon {
    static let armor            = UIImage(named: "armor")
    static let attackDamage     = UIImage(named: "attackDamage")
    static let attackSpeed      = UIImage(named: "attackSpeed")
    static let gold             = UIImage(named: "Gold")
    static let health           = UIImage(named: "health")
    static let magicResist      = UIImage(named: "magicResist")
    static let mana             = UIImage(named: "mana")
    static let range            = UIImage(named: "range")
    static let abilityPower     = UIImage(named: "abilityPower")
    static let critChance       = UIImage(named: "critChance")
    static let dodgeChance      = UIImage(named: "dodgeChance")
}


//MARK: Tier Ribbons
enum TierRibbon {
    static let two      = UIImage(named: "RibbonTier2")
    static let three    = UIImage(named: "RibbonTier3")
    static let four     = UIImage(named: "RibbonTier4")
    static let five     = UIImage(named: "RibbonTier5")
    static let seven    = UIImage(named: "RibbonTier7")
}


//MARK: SF Symbol
enum SFSymbol {
    
    //MARK: Nav Bar Icons
    enum NavIcon {
        static private let navConfig    = UIImage.SymbolConfiguration(weight: .semibold)
        static let settings             = UIImage(systemName: "gear", withConfiguration: navConfig)
        static let addTeamComp          = UIImage(systemName: "plus.square", withConfiguration: navConfig)
    }
    
    //MARK: Tier Icon
    enum TierIcon {
        static private let tierConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        static let sTier    = UIImage(systemName: "s.circle.fill", withConfiguration: tierConfig)
        static let aTier    = UIImage(systemName: "a.circle.fill", withConfiguration: tierConfig)
        static let bTier    = UIImage(systemName: "b.circle.fill", withConfiguration: tierConfig)
        static let cTier    = UIImage(systemName: "c.circle.fill", withConfiguration: tierConfig)
        static let dTier    = UIImage(systemName: "d.circle.fill", withConfiguration: tierConfig)
        static let eTier    = UIImage(systemName: "e.circle.fill", withConfiguration: tierConfig)
    }
    
    //MARK: Cost Icon
    enum CostIcon {
        static private let costConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        static let oneCost      = UIImage(systemName: "1.circle.fill", withConfiguration: costConfig)
        static let twoCost      = UIImage(systemName: "2.circle.fill", withConfiguration: costConfig)
        static let threeCost    = UIImage(systemName: "3.circle.fill", withConfiguration: costConfig)
        static let fourCost     = UIImage(systemName: "4.circle.fill", withConfiguration: costConfig)
        static let fiveCost     = UIImage(systemName: "5.circle.fill", withConfiguration: costConfig)
        static let sixCost      = UIImage(systemName: "6.circle.fill", withConfiguration: costConfig)
        static let sevenCost    = UIImage(systemName: "7.circle.fill", withConfiguration: costConfig)
    }
    
    
    //MARK: Other Icons
    enum OtherIcons {
        static private let plusConfig   = UIImage.SymbolConfiguration(pointSize: 11, weight: .semibold)
        static let plus                 = UIImage(systemName: "plus", withConfiguration: plusConfig)
    }
}


//MARK: Tier Ribbons
enum PlaceholderImage {
    static let champ = UIImage(named: "placeholder")
}
