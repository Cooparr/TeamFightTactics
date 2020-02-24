//
//  SettingsController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 17/02/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

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
        navigationBarSetup()
        setSettingsButtons()
    }
    
    
    //MARK: Navigation Bar Code
    fileprivate func navigationBarSetup() {
        navigationItem.title = "Settings"
    }
    
    
    //MARK: Set Settings Buttons
    fileprivate func setSettingsButtons() {
        if let allowSleep = defaults.object(forKey: Constants.sleepKey) as? Bool {
            settingsView.screenSleepToggle.isOn = allowSleep
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
    
    
    deinit {
        print("Settings: 👋")
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
