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
        print("Settings: ✌️")

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
        if let defaultTab = defaults.object(forKey: Constants.tabKey) as? Int {
            switch defaultTab {
            case Constants.itemsTabNum:
                settingsView.defaultTabButton.setTitle("Items", for: .normal)
            case Constants.championsTabNum:
                settingsView.defaultTabButton.setTitle("Champions", for: .normal)
            case Constants.teamCompTabNum:
                settingsView.defaultTabButton.setTitle("Team Compositions", for: .normal)
            case Constants.patchNotesNum:
                settingsView.defaultTabButton.setTitle("Patch Notes", for: .normal)
            default:
                break
            }
        }
        
        
        if let fetchedSet = defaults.object(forKey: Constants.setKey) as? String {
            switch fetchedSet {
            case Constants.setOne:
                settingsView.setSelector.selectedSegmentIndex = 0
            case Constants.setTwo:
                settingsView.setSelector.selectedSegmentIndex = 1
            case Constants.setThree:
                settingsView.setSelector.selectedSegmentIndex = 2
            default:
                break
            }
        }
        
        
        if let setSkins = defaults.object(forKey: Constants.skinsKey) as? Bool {
            settingsView.setSkinsSwitch.isOn = setSkins
        }
        
        
        if let allowSleep = defaults.object(forKey: Constants.sleepKey) as? Bool {
            settingsView.screenSleepSwitch.isOn = allowSleep
        }
    }
    
    
    //MARK: Fetch Set Data
    @objc func fetchSetData(_ sender: UISegmentedControl) {
        guard let tabCont = self.tabBarController as? TabBarController else { return }
        
        switch sender.selectedSegmentIndex {
        case 0:
            defaults.set(Constants.setOne, forKey: Constants.setKey)
            tabCont.fetchData(from: Constants.setOne)
        case 1:
            defaults.set(Constants.setTwo, forKey: Constants.setKey)
            tabCont.fetchData(from: Constants.setTwo)
        case 2:
            defaults.set(Constants.setThree, forKey: Constants.setKey)
            tabCont.fetchData(from: Constants.setThree)
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
            defaults.set(Constants.itemsTabNum, forKey: Constants.tabKey)
        case "Champions":
            defaults.set(Constants.championsTabNum, forKey: Constants.tabKey)
        case "Team Compositions":
            defaults.set(Constants.teamCompTabNum, forKey: Constants.tabKey)
        case "Patch Notes":
            defaults.set(Constants.patchNotesNum, forKey: Constants.tabKey)
        default:
            break
        }
    }
    
    
    //MARK: Enable / Disable Screen Sleep
    @objc func toggleSetSkins(_ sender: UISwitch) {
        switch sender.isOn {
        case true:
            defaults.set(true, forKey: Constants.skinsKey)
        case false:
            defaults.set(false, forKey: Constants.skinsKey)
        }
    }
    
    
    //MARK: Enable / Disable Screen Sleep
    @objc func toggleScreenSleep(_ sender: UISwitch) {
        switch sender.isOn {
        case true:
            UIApplication.shared.isIdleTimerDisabled = false
            defaults.set(true, forKey: Constants.sleepKey)
        case false:
            UIApplication.shared.isIdleTimerDisabled = true
            defaults.set(false, forKey: Constants.sleepKey)
        }
    }
    
    
    //MARK: Rating Button Action
    @objc func ratingTapped(_ sender: UIButton) {
        sender.shakeAnimation()
        SKStoreReviewController.requestReview()
    }
    
    
    deinit {
        print("Settings: 👋")
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
