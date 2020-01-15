//
//  TabBarController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 22/07/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    var allChampions = [Champion]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [
            createTabBarItem(tabBarTitle: "Items", tabBarImage: "ItemTabBar", viewController: ItemsController()),
            createTabBarItem(tabBarTitle: "Champions", tabBarImage: "ChampionTabBar", viewController: ChampionsController()),
            createTabBarItem(tabBarTitle: "Tier Lists", tabBarImage: "TeamCompTabBar", viewController: TCViewController()),
            createTabBarItem(tabBarTitle: "Patch Notes", tabBarImage: "ChampionTabBar", viewController: PatchNotesController())
        ]
        
        // Changes default opening tab
        selectedIndex = 2
        
        // Tab Bar Colors
        tabBar.barTintColor = CustomColor.charcoal
        tabBar.tintColor = CustomColor.platinum
        tabBar.unselectedItemTintColor = CustomColor.romanSilver
        tabBar.isTranslucent = false
        
        testFunc()
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
    
    
    func testFunc() {
        let tester = FireStoreManager()
        tester.getChampionsTester {
            self.allChampions = tester.allChampions
        }
        
    }
}
