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
    static let setThree = "10.11"
}


//MARK: Set Strings - Also used for Firebase Document ID
enum TFTSet {
    static let one = "Set1"
    static let two = "Set2"
    static let three = "Set3"
}


//MARK: Firebase Collections
enum FBCollection {
    static let items = "Items"
    static let champions = "Champions"
    static let teamComps = "TeamCompositions"
    static let classes = "Classes"
    static let origins = "Origins"
    static let dropRates = "DropRates"
}


//MARK: User Defaults Keys
enum UDKey {
    static let launchKey = "FirstTimeLaunch"
    static let sleepKey = "AllowScreenSleep"
    static let skinsKey = "SetSkins"
    static let setKey = "FetchedSet"
    static let tabKey = "DefaultTab"
}


//MARK: Tab Index Numbers
enum Tab {
    static let items = 0
    static let champions = 1
    static let teamComps = 2
    static let patchNotes = 3
    static let more = 4
}


//MARK: Tab Bar Icons
enum TabBarIcon {
    static let item = UIImage(named: "Item")!
    static let champ = UIImage(named: "Champ")!
    static let teamComp = UIImage(named: "TeamComp")!
    static let more = UIImage(named: "More")!
}


//MARK: Reuse Identifiers
enum ReuseId {
    static let itemPageCell = "itemId"
    static let champCell = "champId"
    static let teamCompCell = "teamCompId"
    static let moreCell = "moreId"
    static let dropRateCell = "dropRateId"
    static let menuCell = "menuId"
    static let traitPageCell = "traitId"
    static let traitCell = "infoId"
}
