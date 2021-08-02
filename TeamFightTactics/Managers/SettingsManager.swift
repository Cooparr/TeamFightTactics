//
//  SettingsManager.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 27/07/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import Foundation

enum SettingsManager {
    
    //MARK: User Default Keys
    enum UDKey: String {
        case shouldAllowScreenSleep
        case shouldUseSetSkins
        case currentlyFetchedSet
        case defaultTabToOpen
        case currentlyDisplayedSet
        case currentPatchForSet
    }
    
    //MARK: Register Defaults
    static func registerDefaults() {
        UserDefaults.standard.register(defaults: [
            "shouldAllowScreenSleep"    : false,
            "shouldUseSetSkins"         : true,
            "defaultTabToOpen"          : Tab.teamComps.rawValue,
            "currentlyDisplayedSet"     : TFTSet.latest.rawValue,
            "currentPatchForSet"        : "Latest"
        ])
    }
    
    
    //MARK: Get / Set Current Patch Version
    static func getCurrentPatchVersion() -> String {
        SettingsManager.stringValue(.currentPatchForSet)
    }
    
    static func setCurrentPatchVersion(to patchNumber: String) {
        SettingsManager[.currentPatchForSet] = patchNumber
    }
    
    
    //MARK: Get / Set Currently Displayed Set
    static func getDisplayedSet() -> TFTSet {
        return TFTSet(rawValue: SettingsManager.doubleValue(.currentlyDisplayedSet)) ?? .latest
    }
    
    static func setDisplayedSet(to set: TFTSet) {
        SettingsManager[.currentlyDisplayedSet] = set.rawValue
    }
    
    
    //MARK: Get / Set Currently Displayed Set
    static func getDefaultTab() -> Int {
        return SettingsManager.intValue(.defaultTabToOpen)
    }
    
    static func setDefaultTab(to tab: Tab) {
        SettingsManager[.defaultTabToOpen] = tab.rawValue
    }
    
    
    //MARK: Get / Set Allow Screen Sleep
    static func shouldAllowScreenSleep() -> Bool {
        return SettingsManager.boolValue(.shouldAllowScreenSleep)
    }
    
    static func setShouldAllowScreenSleep(_ bool: Bool) {
        SettingsManager[.shouldAllowScreenSleep] = bool
    }
    
    
    //MARK: Get / Set Use Set Skins
    static func shouldUseSetSkins() -> Bool {
        return SettingsManager.boolValue(.shouldUseSetSkins)
    }
    
    static func setShouldUseSetSkins(_ bool: Bool) {
        SettingsManager[.shouldUseSetSkins] = bool
    }
    
}


extension SettingsManager {
    private static subscript(_ key: UDKey) -> Any? {
        get {
            return UserDefaults.standard.value(forKey: key.rawValue)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: key.rawValue)
        }
    }
    
    private static func boolValue(_ udKey: UDKey) -> Bool {
        return SettingsManager[udKey] as! Bool
    }
    
    private static func stringValue(_ udKey: UDKey) -> String {
        return SettingsManager[udKey] as! String
    }
    
    private static func intValue(_ udKey: UDKey) -> Int {
        return SettingsManager[udKey] as! Int
    }
    
    private static func doubleValue(_ udKey: UDKey) -> Double {
        return SettingsManager[udKey] as! Double
    }
}
