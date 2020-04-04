//
//  TabBarController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 22/07/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit
import SDWebImage

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    // Properties
    // Root Data Arrays
    var rootChamps = [Champion]()
    var rootTeamComps = [TeamComposition]()
    
    // TabBar ViewControllers
    let champController = ChampionsController()
    let teamCompController = TCViewController()
    let itemsController = ItemsController()
    let patchNotesController = PatchNotesController()
    
    
    //MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        isFirstTimeLaunchingApp()
        implementUserCustomSettings()
    }
    
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    //MARK: Setup Tab Bar
    fileprivate func setupTabBar() {
        viewControllers = [
            createTabBarItem(tabBarTitle: "Items", tabBarImage: "ItemTabBar", viewController: itemsController),
            createTabBarItem(tabBarTitle: "Champions", tabBarImage: "ChampionTabBar", viewController: champController),
            createTabBarItem(tabBarTitle: "Tier List", tabBarImage: "TeamCompTabBar", viewController: teamCompController),
            createTabBarItem(tabBarTitle: "Patch Notes", tabBarImage: "ChampionTabBar", viewController: patchNotesController)
        ]
        
        // Tab Bar Colors
        tabBar.barTintColor = CustomColor.charcoal
        tabBar.tintColor = CustomColor.platinum
        tabBar.unselectedItemTintColor = CustomColor.romanSilver
        tabBar.isTranslucent = false
    }
    
    
    //MARK: Is First Time Launching?
    fileprivate func isFirstTimeLaunchingApp() {
        let defaults = UserDefaults.standard
        let isFirstLaunch = !defaults.bool(forKey: Constants.launchKey)
        if isFirstLaunch  {
            defaults.set(true, forKey: Constants.launchKey)
            defaults.set(Constants.teamCompTabNum, forKey: Constants.tabKey)
            defaults.set(Constants.setThree, forKey: Constants.setKey)
            defaults.set(true, forKey: Constants.skinsKey)
            defaults.set(false, forKey: Constants.sleepKey)
        }
    }
    
    
    //MARK: Implement Custom User Settings
    fileprivate func implementUserCustomSettings() {
        let defaults = UserDefaults.standard
        
        let desiredTab = defaults.integer(forKey: Constants.tabKey)
        self.selectedIndex = desiredTab

        if let desiredSet = defaults.string(forKey: Constants.setKey) {
            fetchData(from: desiredSet)
        }
    }
    
    
    //MARK: Create Tab Bar Item
    fileprivate func createTabBarItem(tabBarTitle: String, tabBarImage: String, viewController: UIViewController) -> UINavigationController {
        let navigationController = NavBarController(rootViewController: viewController)
        navigationController.tabBarItem.title = tabBarTitle
        navigationController.tabBarItem.image = UIImage(named: tabBarImage)
        return navigationController
    }
    
    
    //MARK: Fetch Data
    func fetchData(from set: String) {
        let fetchDispatchGroup = DispatchGroup()
        let service = FirestoreManager()

        fetchDispatchGroup.enter()
        service.fetchFirestoreData(from: set, in: "Champions") { (champions: [Champion]) in
            self.rootChamps = champions.sorted(by: {$0.cost.rawValue > $1.cost.rawValue})
            fetchDispatchGroup.leave()
        }

        fetchDispatchGroup.enter()
        service.fetchFirestoreData(from: set, in: "TeamCompositions") { (teamComps: [TeamComposition]) in
            self.rootTeamComps = teamComps.sorted(by: {$0.tier.rawValue < $1.tier.rawValue})
            fetchDispatchGroup.leave()
        }
        
        fetchDispatchGroup.notify(queue: .main) {
            self.champController.allChampions = self.rootChamps
            self.teamCompController.allChampions = self.rootChamps
            self.teamCompController.allTeamComps = self.rootTeamComps
        }
    }
}
