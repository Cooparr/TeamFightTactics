//
//  TabBarController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 22/07/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [
            createTabBarItem(tabBarTitle: "Items", tabBarImage: "ItemTabBar", viewController: ItemsController()),
            createTabBarItem(tabBarTitle: "Champions", tabBarImage: "ChampionTabBar", viewController: ChampionsController(collectionViewLayout: UICollectionViewFlowLayout())),
            createTabBarItem(tabBarTitle: "Tier Lists", tabBarImage: "null", viewController: TierListsController()),
            createTabBarItem(tabBarTitle: "Patch Notes", tabBarImage: "null", viewController: PatchNotesController()),
            createTabBarItem(tabBarTitle: "Test", tabBarImage: "null", viewController: CollectionTestController(collectionViewLayout: UICollectionViewFlowLayout()))
        ]
        
        
        // Changes default opening tab
        selectedIndex = 1
    }
    
    fileprivate func createTabBarItem(tabBarTitle: String, tabBarImage: String, viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = tabBarTitle
        navigationController.tabBarItem.image = UIImage(named: tabBarImage)
        return navigationController
    }
}
