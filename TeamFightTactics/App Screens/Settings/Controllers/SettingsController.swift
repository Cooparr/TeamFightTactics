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
    private let settingsView = SettingsView(tamic: true, backgroundColor: ThemeColor.richBlack)
    
    
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
        setupNavBar(navTitle: TabTitle.settings, showSettingsButton: false)
        configueSkinsAndScreenSleepButton()
        configureDefaultTabButton()
        configureDefaultSetButton()
    }
    
    
    //MARK: Configure Tab Button
    private func configureDefaultTabButton() {
        switch Tab(rawValue: SettingsManager.getDefaultTab()) {
        case .items:
            settingsView.defaultTabButton.setTitle(TabTitle.items.rawValue, for: .normal)
        case .champions:
            settingsView.defaultTabButton.setTitle(TabTitle.champs.rawValue, for: .normal)
        case .teamComps:
            settingsView.defaultTabButton.setTitle(TabTitle.teamComps.rawValue, for: .normal)
        case .patchNotes:
            settingsView.defaultTabButton.setTitle(TabTitle.patchNotes.rawValue, for: .normal)
        default:
            break
        }
    }
    
    
    //MARK: Configure Set Selector Button
    private func configureDefaultSetButton() {
        switch SettingsManager.getDisplayedSet() {
        case .one:
            settingsView.setSelector.selectedSegmentIndex = 0
        case .two:
            settingsView.setSelector.selectedSegmentIndex = 1
        case .three:
            settingsView.setSelector.selectedSegmentIndex = 2
        case .four:
            settingsView.setSelector.selectedSegmentIndex = 3
        case .four_5:
            settingsView.setSelector.selectedSegmentIndex = 4
        case .five:
            settingsView.setSelector.selectedSegmentIndex = 5
        case .latest:
            settingsView.setSelector.selectedSegmentIndex = 6
        }
    }
    
    
    //MARK: Configure Use Skin & Screen Sleep Button
    private func configueSkinsAndScreenSleepButton() {
        settingsView.setSkinsSwitch.isOn = SettingsManager.shouldUseSetSkins()
        settingsView.screenSleepSwitch.isOn = SettingsManager.shouldAllowScreenSleep()
    }
    
    
    //MARK: Fetch Set Data
    @objc func fetchSetData(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            SettingsManager.setDisplayedSet(to: .one)
        case 1:
            SettingsManager.setDisplayedSet(to: .two)
        case 2:
            SettingsManager.setDisplayedSet(to: .three)
        case 3:
            SettingsManager.setDisplayedSet(to: .four)
        case 4:
            SettingsManager.setDisplayedSet(to: .four_5)
        case 5:
            SettingsManager.setDisplayedSet(to: .five)
        case 6:
            SettingsManager.setDisplayedSet(to: .latest)
        default:
            break
        }
    }
    
    
    //MARK: Default Tab Button Action
    @objc func defaultTabTapped(_ sender: UIButton) {
        sender.shakeAnimation()
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: TabTitle.items.rawValue, style: .default, handler: tabAction))
        actionSheet.addAction(UIAlertAction(title: TabTitle.champs.rawValue, style: .default, handler: tabAction))
        actionSheet.addAction(UIAlertAction(title: TabTitle.teamComps.rawValue, style: .default, handler: tabAction))
        actionSheet.addAction(UIAlertAction(title: TabTitle.patchNotes.rawValue, style: .default, handler: tabAction))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        actionSheet.view.tintColor = ThemeColor.platinum
        
        present(actionSheet, animated: true)
    }
    
    
    fileprivate func tabAction(action: UIAlertAction) {
        settingsView.defaultTabButton.setTitle(action.title, for: .normal)
        
        switch action.title {
        case TabTitle.items.rawValue:
            SettingsManager.setDefaultTab(to: .items)
        case TabTitle.champs.rawValue:
            SettingsManager.setDefaultTab(to: .champions)
        case TabTitle.teamComps.rawValue:
            SettingsManager.setDefaultTab(to: .teamComps)
        case TabTitle.patchNotes.rawValue:
            SettingsManager.setDefaultTab(to: .patchNotes)
        default:
            break
        }
    }
    
    
    //MARK: Enable / Disable Set Skins
    @objc func toggleSetSkins(_ sender: UISwitch) {
        SettingsManager.setShouldUseSetSkins(sender.isOn)
    }
    
    
    //MARK: Enable / Disable Screen Sleep
    @objc func toggleScreenSleep(_ sender: UISwitch) {
        switch sender.isOn {
        case true:
            UIApplication.shared.isIdleTimerDisabled = false
            SettingsManager.setShouldAllowScreenSleep(true)
        case false:
            UIApplication.shared.isIdleTimerDisabled = true
            SettingsManager.setShouldAllowScreenSleep(false)
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
