//
//  TabBarController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 22/07/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    // Root Data Arrays
    var rootChamps = [Champion]()
    var rootTeamComps = [TeamComposition]()
    
    // TabBar ViewControllers
    let champController = ChampionsController()
    let teamCompController = TCViewController()
    let itemsController = ItemsController()
    let patchNotesController = PatchNotesController()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        let service = FirestoreManager()
        
        service.fetchFirestoreData(from: "Set1", in: "Champions") { (champions: [Champion]) in
            self.rootChamps = champions.sorted(by: {$0.cost > $1.cost})
            self.champController.allChampions = self.rootChamps
        }
        
        service.fetchFirestoreData(from: "Set1", in: "TeamCompositions") { (teamComps: [TeamComposition]) in
            self.rootTeamComps = teamComps.sorted(by: {$0.tier.rawValue < $1.tier.rawValue})
            self.teamCompController.allTeamComps = self.rootTeamComps
            self.teamCompController.allChampions = self.rootChamps
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [
            createTabBarItem(tabBarTitle: "Items", tabBarImage: "ItemTabBar", viewController: itemsController),
            createTabBarItem(tabBarTitle: "Champions", tabBarImage: "ChampionTabBar", viewController: champController),
            createTabBarItem(tabBarTitle: "Tier List", tabBarImage: "TeamCompTabBar", viewController: teamCompController),
            createTabBarItem(tabBarTitle: "Patch Notes", tabBarImage: "ChampionTabBar", viewController: patchNotesController)
        ]
        
        
        // Changes default opening tab
        selectedIndex = 1
        
        // Tab Bar Colors
        tabBar.barTintColor = CustomColor.charcoal
        tabBar.tintColor = CustomColor.platinum
        tabBar.unselectedItemTintColor = CustomColor.romanSilver
        tabBar.isTranslucent = false
    }
    
    fileprivate func createTabBarItem(tabBarTitle: String, tabBarImage: String, viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = tabBarTitle
        navigationController.tabBarItem.image = UIImage(named: tabBarImage)
        navigationController.navigationBar.barTintColor = CustomColor.charcoal
        navigationController.navigationBar.tintColor = CustomColor.platinum
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: CustomColor.platinum]
        return navigationController
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
