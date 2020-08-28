//
//  Constants.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 24/02/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

//MARK: TFT Patch Numbers
enum PatchNumber {
    static let setOne = "9.21"
    static let setTwo = "10.5"
    static let setThree = "10.12"
}


//MARK: Set Numbers
enum TFTSet: Int {
    case one = 1
    case two = 2
    case three = 3
}


//MARK: User Defaults Keys
enum UDKey {
    static let launchKey = "FirstTimeLaunch"
    static let sleepKey = "AllowScreenSleep"
    static let skinsKey = "SetSkins"
    static let setKey = "FetchedSet"
    static let tabKey = "DefaultTab"
    static let hasSetChanged = "SetChange"
    static let displayedSet = "displayedSet"
}

enum LastUpdateKey: String {
    case items = "itemsLastUpdate"
    case champs = "champsLastUpdate"
    case teamComps = "teamCompsLastUpdate"
    case patchNotes = "patchNotesLastUpdate"
    case traits = "traitsLastUpdate"
    case classes = "classesLastUpdate"
    case origins = "originsLastUpdate"
    case dropRates = "dropRatesLastUpdate"
}


//MARK: Tab Index Numbers
enum Tab: Int {
    case items = 0
    case champions = 1
    case teamComps = 2
    case patchNotes = 3
    case more = 4
}


//MARK: Tab Bar Icons
enum TabTitle {
    static let items = "Items"
    static let champs = "Champions"
    static let teamComps = "Team Comps"
    static let patchNotes = "Patch Notes"
    static let traits = "Traits"
    static let more = "More"
    static let dropRates = "Drop Rates"
}

//MARK: Tab Bar Icons
enum TabIcon {
    static let item = UIImage(named: "Item")!
    static let champ = UIImage(named: "Champ")!
    static let teamComp = UIImage(named: "TeamComp")!
    static let patchNotes = UIImage(named: "PatchNotes")!
    static let traits = UIImage(named: "Traits")!
    static let dropRate = UIImage(named: "DropRate")!
    static let more = UIImage(named: "More")!
}


//MARK: Tab Bar Icons
enum StatIcon {
    static let armor = UIImage(named: "armor")!
    static let attackDamage = UIImage(named: "attackDamage")!
    static let attackSpeed = UIImage(named: "attackSpeed")!
    static let gold = UIImage(named: "Gold")!
    static let health = UIImage(named: "health")!
    static let magicResist = UIImage(named: "magicResist")!
    static let mana = UIImage(named: "mana")!
    static let range = UIImage(named: "range")!
    static let abilityPower = UIImage(named: "abilityPower")!
    static let critChance = UIImage(named: "critChance")!
    static let dodgeChance = UIImage(named: "dodgeChance")!
}
