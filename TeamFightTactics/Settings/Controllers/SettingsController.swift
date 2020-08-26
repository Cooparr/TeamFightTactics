//
//  SettingsController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 17/02/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit
import StoreKit

class SettingsController: UIViewController {

    //MARK:- Properties
    private let settingsView = SettingsView()
    let defaults = UserDefaults.standard
    
    
    //MARK:- Override Init
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }

    
    //MARK:- Load View
    override func loadView() {
        self.view = settingsView
    }
    
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setSettingsButtons()
    }
    
    
    //MARK: Set Settings Buttons
    fileprivate func setSettingsButtons() {
        if let defaultTab = defaults.object(forKey: UDKey.tabKey) as? Int {
            switch defaultTab {
            case Tab.items:
                settingsView.defaultTabButton.setTitle("Items", for: .normal)
            case Tab.champions:
                settingsView.defaultTabButton.setTitle("Champions", for: .normal)
            case Tab.teamComps:
                settingsView.defaultTabButton.setTitle("Team Compositions", for: .normal)
            case Tab.patchNotes:
                settingsView.defaultTabButton.setTitle("Patch Notes", for: .normal)
            default:
                break
            }
        }
        
        
        if let fetchedSet = defaults.object(forKey: UDKey.setKey) as? String {
            switch fetchedSet {
            case TFTSet.one:
                settingsView.setSelector.selectedSegmentIndex = 0
            case TFTSet.two:
                settingsView.setSelector.selectedSegmentIndex = 1
            case TFTSet.three:
                settingsView.setSelector.selectedSegmentIndex = 2
            default:
                break
            }
        }
        
        
        if let setSkins = defaults.object(forKey: UDKey.skinsKey) as? Bool {
            settingsView.setSkinsSwitch.isOn = setSkins
        }
        
        
        if let allowSleep = defaults.object(forKey: UDKey.sleepKey) as? Bool {
            settingsView.screenSleepSwitch.isOn = allowSleep
        }
    }
    
    
    //MARK: Fetch Set Data
    @objc func fetchSetData(_ sender: UISegmentedControl) {
        guard let tabCont = self.tabBarController as? TabBarController else { return }
        
        switch sender.selectedSegmentIndex {
        case 0:
            defaults.set(TFTSet.one, forKey: UDKey.setKey)
            tabCont.fetchData(from: TFTSet.one)
        case 1:
            defaults.set(TFTSet.two, forKey: UDKey.setKey)
            tabCont.fetchData(from: TFTSet.two)
        case 2:
            defaults.set(TFTSet.three, forKey: UDKey.setKey)
            tabCont.fetchData(from: TFTSet.three)
        default:
            break
        }
    }
    
    
    //MARK: Default Tab Button Action
    @objc func defaultTabTapped(_ sender: UIButton) {
        sender.shakeAnimation()
        
        let actionSheet = UIAlertController(title: "Select Default Tab", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Items", style: .default, handler: tabAction))
        actionSheet.addAction(UIAlertAction(title: "Champions", style: .default, handler: tabAction))
        actionSheet.addAction(UIAlertAction(title: "Team Compositions", style: .default, handler: tabAction))
        actionSheet.addAction(UIAlertAction(title: "Patch Notes", style: .default, handler: tabAction))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(actionSheet, animated: true)
    }
    
    
    func tabAction(action: UIAlertAction) {
        settingsView.defaultTabButton.setTitle(action.title, for: .normal)
        
        switch action.title {
        case "Items":
            defaults.set(Tab.items, forKey: UDKey.tabKey)
        case "Champions":
            defaults.set(Tab.champions, forKey: UDKey.tabKey)
        case "Team Compositions":
            defaults.set(Tab.teamComps, forKey: UDKey.tabKey)
        case "Patch Notes":
            defaults.set(Tab.patchNotes, forKey: UDKey.tabKey)
        default:
            break
        }
    }
    
    
    //MARK: Enable / Disable Screen Sleep
    @objc func toggleSetSkins(_ sender: UISwitch) {
        switch sender.isOn {
        case true:
            defaults.set(true, forKey: UDKey.skinsKey)
        case false:
            defaults.set(false, forKey: UDKey.skinsKey)
        }
    }
    
    
    //MARK: Enable / Disable Screen Sleep
    @objc func toggleScreenSleep(_ sender: UISwitch) {
        switch sender.isOn {
        case true:
            UIApplication.shared.isIdleTimerDisabled = false
            defaults.set(true, forKey: UDKey.sleepKey)
        case false:
            UIApplication.shared.isIdleTimerDisabled = true
            defaults.set(false, forKey: UDKey.sleepKey)
        }
    }
    
    
    //MARK: Rating Button Action
    @objc func ratingTapped(_ sender: UIButton) {
        sender.shakeAnimation()
        SKStoreReviewController.requestReview()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
