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
        configueSkinsAndScreenSleepButton()
        configureDefaultTabButton()
        configureDefaultSetButton()
    }
    
    
    //MARK: Configure Tab Button
    fileprivate func configureDefaultTabButton() {
        switch Tab(rawValue: defaults.integer(forKey: UDKey.tabKey)) {
        case .items:
            settingsView.defaultTabButton.setTitle(TabTitle.items, for: .normal)
        case .champions:
            settingsView.defaultTabButton.setTitle(TabTitle.champs, for: .normal)
        case .teamComps:
            settingsView.defaultTabButton.setTitle(TabTitle.teamComps, for: .normal)
        case .patchNotes:
            settingsView.defaultTabButton.setTitle(TabTitle.patchNotes, for: .normal)
        default:
            break
        }
    }
    
    
    //MARK: Configure Set Selector Button
    fileprivate func configureDefaultSetButton() {
        switch TFTSet(rawValue: defaults.integer(forKey: UDKey.setKey)) {
        case .one:
            settingsView.setSelector.selectedSegmentIndex = 0
        case .two:
            settingsView.setSelector.selectedSegmentIndex = 1
        case .three:
            settingsView.setSelector.selectedSegmentIndex = 2
        case .four:
            settingsView.setSelector.selectedSegmentIndex = 3
        default:
            break
        }
    }
    
    
    //MARK: Configure Use Skin & Screen Sleep Button
    fileprivate func configueSkinsAndScreenSleepButton() {
        settingsView.setSkinsSwitch.isOn = defaults.bool(forKey: UDKey.skinsKey)
        settingsView.screenSleepSwitch.isOn = defaults.bool(forKey: UDKey.sleepKey)
    }
    
    
    //MARK: Fetch Set Data
    @objc func fetchSetData(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            defaults.set(TFTSet.one.rawValue, forKey: UDKey.setKey)
        case 1:
            defaults.set(TFTSet.two.rawValue, forKey: UDKey.setKey)
        case 2:
            defaults.set(TFTSet.three.rawValue, forKey: UDKey.setKey)
        case 3:
            defaults.set(TFTSet.four.rawValue, forKey: UDKey.setKey)
        default:
            break
        }
    }
    
    
    //MARK: Default Tab Button Action
    @objc func defaultTabTapped(_ sender: UIButton) {
        sender.shakeAnimation()
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: TabTitle.items, style: .default, handler: tabAction))
        actionSheet.addAction(UIAlertAction(title: TabTitle.champs, style: .default, handler: tabAction))
        actionSheet.addAction(UIAlertAction(title: TabTitle.teamComps, style: .default, handler: tabAction))
        actionSheet.addAction(UIAlertAction(title: TabTitle.patchNotes, style: .default, handler: tabAction))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        actionSheet.view.tintColor = ThemeColor.platinum
        
        present(actionSheet, animated: true)
    }
    
    
    fileprivate func tabAction(action: UIAlertAction) {
        settingsView.defaultTabButton.setTitle(action.title, for: .normal)
        
        switch action.title {
        case TabTitle.items:
            defaults.set(Tab.items.rawValue, forKey: UDKey.tabKey)
        case TabTitle.champs:
            defaults.set(Tab.champions.rawValue, forKey: UDKey.tabKey)
        case TabTitle.teamComps:
            defaults.set(Tab.teamComps.rawValue, forKey: UDKey.tabKey)
        case TabTitle.patchNotes:
            defaults.set(Tab.patchNotes.rawValue, forKey: UDKey.tabKey)
        default:
            break
        }
    }
    
    
    //MARK: Enable / Disable Set Skins
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
