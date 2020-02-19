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
    let sleepKey = "AllowScreenSleep"
    
    
    //MARK:- Override Init
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print("Settings: ✌️")

        hidesBottomBarWhenPushed = true
        settingsView.screenSleepToggle.isOn = defaults.object(forKey: sleepKey) as? Bool ?? true
    }

    
    //MARK:- Load View
    override func loadView() {
        self.view = settingsView
    }
    
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetup()
        setSelectedSetSegment()
    }
    
    
    //MARK: Navigation Bar Code
    fileprivate func navigationBarSetup() {
        navigationItem.title = "Settings"
    }
    
    
    //MARK: Set Selected Segment
    fileprivate func setSelectedSetSegment() {
        if let tabCont = self.tabBarController as? TabBarController {
            settingsView.setSelector.selectedSegmentIndex = tabCont.fetchedSet
        }
    }
    
    
    //MARK: Fetch Set Data
    @objc func fetchSetData(_ sender: UISegmentedControl) {
        guard let tabCont = self.tabBarController as? TabBarController else { return }
        
        switch sender.selectedSegmentIndex {
        case 0:
            tabCont.fetchData(from: "Set1")
            tabCont.fetchedSet = 0
        case 1:
            tabCont.fetchData(from: "Set2")
            tabCont.fetchedSet = 1
        case 2:
            tabCont.fetchData(from: "Set3")
            tabCont.fetchedSet = 2
        default:
            break
        }
    }
    
    
    //MARK: Enable / Disable Screen Sleep
    @objc func toggleScreenSleep(_ sender: UISwitch) {
        switch sender.isOn {
        case true:
            UIApplication.shared.isIdleTimerDisabled = false
            defaults.set(true, forKey: sleepKey)
        case false:
            UIApplication.shared.isIdleTimerDisabled = true
            defaults.set(false, forKey: sleepKey)
        }
    }
    
    
    deinit {
        print("Settings: 👋")
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
