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
    var rootOrigins = [Trait]()
    var rootClasses = [Trait]()
    
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
        tabBar.barTintColor = ThemeColor.charcoal
        tabBar.tintColor = ThemeColor.platinum
        tabBar.unselectedItemTintColor = ThemeColor.romanSilver
        tabBar.isTranslucent = false
    }
    
    
    //MARK: Is First Time Launching?
    fileprivate func isFirstTimeLaunchingApp() {
        let defaults = UserDefaults.standard
        let isFirstLaunch = !defaults.bool(forKey: UDKey.launchKey)
        if isFirstLaunch  {
            defaults.set(true, forKey: UDKey.launchKey)
            defaults.set(Tab.teamComps, forKey: UDKey.tabKey)
            defaults.set(TFTSet.three, forKey: UDKey.setKey)
            defaults.set(true, forKey: UDKey.skinsKey)
            defaults.set(false, forKey: UDKey.sleepKey)
        }
    }
    
    
    //MARK: Implement Custom User Settings
    fileprivate func implementUserCustomSettings() {
        let defaults = UserDefaults.standard
        
        let desiredTab = defaults.integer(forKey: UDKey.tabKey)
        self.selectedIndex = desiredTab

        if let desiredSet = defaults.string(forKey: UDKey.setKey) {
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
        service.fetchFirestoreData(from: set, in: FBCollection.champions) { (champions: [Champion]) in
            self.rootChamps = champions.sorted(by: {$0.cost.rawValue > $1.cost.rawValue})
            fetchDispatchGroup.leave()
        }

        fetchDispatchGroup.enter()
        service.fetchFirestoreData(from: set, in: FBCollection.teamComps) { (teamComps: [TeamComposition]) in
            self.rootTeamComps = teamComps.sorted(by: {$0.tier.rawValue < $1.tier.rawValue})
            fetchDispatchGroup.leave()
        }
        
        fetchDispatchGroup.enter()
        service.fetchFirestoreData(from: set, in: FBCollection.classes) { (classes: [Trait]) in
            self.rootClasses = classes
            fetchDispatchGroup.leave()
        }
        
        fetchDispatchGroup.enter()
        service.fetchFirestoreData(from: set, in: FBCollection.origins) { (origins: [Trait]) in
            self.rootOrigins = origins
            fetchDispatchGroup.leave()
        }
        
        
        fetchDispatchGroup.notify(queue: .main) {
            self.champController.allChampions = self.rootChamps
            
            self.teamCompController.allChampions = self.rootChamps
            self.teamCompController.allTeamComps = self.rootTeamComps
            self.teamCompController.allClasses = self.rootClasses
            self.teamCompController.allOrigins = self.rootOrigins
        }
    }
}
