//
//  TabBarController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 22/07/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    // Properties
    // Root Data Arrays
    var rootChamps = [Champion]()
    var rootTeamComps = [TeamComposition]()
    var rootOrigins = [Trait]()
    var rootClasses = [Trait]()
    var rootDropRates = [DropRate]()
    var rootItems = [Item]()
    var rootPatchNotes = [PatchNote]()
    
    // TabBar ViewControllers
    let itemsController = ItemsController()
    let champController = ChampionsController()
    let teamCompController = TCViewController()
    let patchNotesController = PNController()
    let moreTabsController = MoreTabsController()
    
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        isFirstTimeLaunchingApp()
        implementUserCustomSettings()
    }
    
    
    //MARK: Setup Tab Bar
    fileprivate func setupTabBar() {
        viewControllers = [
            createTab(TabItem(tabTitle: "Items", tabImage: TabBarIcon.item, tabVC: itemsController)),
            createTab(TabItem(tabTitle: "Champions", tabImage: TabBarIcon.champ, tabVC: champController)),
            createTab(TabItem(tabTitle: "Team Comps", tabImage: TabBarIcon.teamComp, tabVC: teamCompController)),
            createTab(TabItem(tabTitle: "Patch Notes", tabImage: TabBarIcon.patchNotes, tabVC: patchNotesController)),
            createTab(TabItem(tabTitle: "More", tabImage: TabBarIcon.more, tabVC: moreTabsController))
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
    
    
    //MARK: Create Tab
    fileprivate func createTab(_ tabItem: TabItem) -> UINavigationController {
        let navigationController = NavBarController(rootViewController: tabItem.viewController)
        navigationController.tabBarItem.title = tabItem.title
        navigationController.tabBarItem.image = tabItem.image
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
            self.rootClasses = classes.sorted(by: {$0.tier.rawValue < $1.tier.rawValue})
            fetchDispatchGroup.leave()
        }
        
        fetchDispatchGroup.enter()
        service.fetchFirestoreData(from: set, in: FBCollection.origins) { (origins: [Trait]) in
            self.rootOrigins = origins.sorted(by: {$0.tier.rawValue < $1.tier.rawValue})
            fetchDispatchGroup.leave()
        }
        
        fetchDispatchGroup.enter()
        service.fetchFirestoreData(from: set, in: FBCollection.dropRates) { (dropRates: [DropRate]) in
            self.rootDropRates = dropRates
            fetchDispatchGroup.leave()
        }
        
        fetchDispatchGroup.enter()
        service.fetchFirestoreData(from: set, in: FBCollection.items) { (items: [Item]) in
            self.rootItems = items
            fetchDispatchGroup.leave()
        }
        
        fetchDispatchGroup.enter()
        service.fetchFirestoreData(from: set, in: FBCollection.patchNotes) { (patchNotes: [PatchNote]) in
            self.rootPatchNotes = patchNotes.sorted(by: {$0.version > $1.version})
            fetchDispatchGroup.leave()
        }
        
        fetchDispatchGroup.notify(queue: .main) {
            self.champController.allChampions = self.rootChamps
            
            self.teamCompController.allChampions = self.rootChamps
            self.teamCompController.allTeamComps = self.rootTeamComps
            self.teamCompController.allClasses = self.rootClasses
            self.teamCompController.allOrigins = self.rootOrigins
            
            self.itemsController.allItems = self.rootItems
            
            self.patchNotesController.allPatchNotes = self.rootPatchNotes
            
            self.moreTabsController.allDropRates = self.rootDropRates
            self.moreTabsController.allClasses = self.rootClasses
            self.moreTabsController.allOrigins = self.rootOrigins
        }
    }
}
