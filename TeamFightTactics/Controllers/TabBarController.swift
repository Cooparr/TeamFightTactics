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
            createTabBarItem(tabBarTitle: "Classes", tabBarImage: "null", viewController: ClassesController()),
            createTabBarItem(tabBarTitle: "Patch Notes", tabBarImage: "null", viewController: PatchNotesController())
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
