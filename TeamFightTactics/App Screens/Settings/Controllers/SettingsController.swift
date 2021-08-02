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
        configureDefaultTabButton()
        settingsView.setSkinsSwitch.isOn = SettingsManager.shouldUseSetSkins()
        settingsView.screenSleepSwitch.isOn = SettingsManager.shouldAllowScreenSleep()
        settingsView.setSelectorButton.setTitle("\(SettingsManager.getDisplayedSet().rawValue)", for: .normal)
    }
    
    
    //MARK:- Configure Tab Button
    private func configureDefaultTabButton() {
        guard let tabChoice = Tab(rawValue: SettingsManager.getDefaultTab()) else { return }
        switch tabChoice {
        case .items:
            settingsView.defaultTabButton.setTitle(TabTitle.items.rawValue, for: .normal)
        case .champions:
            settingsView.defaultTabButton.setTitle(TabTitle.champs.rawValue, for: .normal)
        case .teamComps:
            settingsView.defaultTabButton.setTitle(TabTitle.teamComps.rawValue, for: .normal)
        case .patchNotes:
            settingsView.defaultTabButton.setTitle(TabTitle.patchNotes.rawValue, for: .normal)
        case .more:
            break // Dont want to offer 'More' tab as an option.
        }
    }
    
    
    //MARK: Default Tab Tapped
    @objc func defaultTabTapped(_ sender: UIButton) {
        sender.shakeAnimation()
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        TabTitle.allCases.forEach {
            switch $0 {
            case .items, .champs, .teamComps, .patchNotes:
                actionSheet.addAction(UIAlertAction(title: $0.rawValue, style: .default, handler: defaultTabAction))
            case .traits, .more, .dropRates, .galaxies, .settings, .createTeamComp:
                break
            }
        }
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        actionSheet.view.tintColor = ThemeColor.platinum
        present(actionSheet, animated: true)
    }
    
    
    //MARK: Default Tab Action
    private func defaultTabAction(action: UIAlertAction) {
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
    
    
    //MARK:- Set Selector Button Tapped
    @objc func setSelectorTapped(_ sender: UIButton) {
        sender.shakeAnimation()
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        TFTSet.allCases.forEach { actionSheet.addAction(UIAlertAction(title: "\($0.rawValue)", style: .default, handler: setSelectorAction)) }
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        actionSheet.view.tintColor = ThemeColor.platinum
        present(actionSheet, animated: true)
        
    }
    
    //MARK: Set Selector Action
    private func setSelectorAction(action: UIAlertAction) {
        guard
            let actionTitle = action.title,
            let double = Double(actionTitle),
            let setNum = TFTSet(rawValue: double)
        else { return }
        
        settingsView.setSelectorButton.setTitle(actionTitle, for: .normal)
        SettingsManager.setDisplayedSet(to: setNum)
    }
    
    
    //MARK:- Enable / Disable Set Skins
    @objc func toggleSetSkins(_ sender: UISwitch) {
        SettingsManager.setShouldUseSetSkins(sender.isOn)
    }
    
    
    //MARK:- Enable / Disable Screen Sleep
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
    
    
    //MARK:- Rating Button Action
    @objc func ratingTapped(_ sender: UIButton) {
        sender.shakeAnimation()
        SKStoreReviewController.requestReview()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
