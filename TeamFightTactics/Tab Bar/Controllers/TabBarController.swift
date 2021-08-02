//
//  TabBarController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 22/07/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        delegate = self
        selectedIndex = SettingsManager.getDefaultTab()
    }
    
    
    //MARK: Setup Tab Bar
    private func setupTabBar() {
        viewControllers = [
            createTab(TabItem(tabTitle: TabTitle.items, tabImage: TabIcon.item, tabVC: ItemsController())),
            createTab(TabItem(tabTitle: TabTitle.champs, tabImage: TabIcon.champ, tabVC: ChampionsController())),
            createTab(TabItem(tabTitle: TabTitle.teamComps, tabImage: TabIcon.teamComp, tabVC: TCPagesViewController())),
            createTab(TabItem(tabTitle: TabTitle.patchNotes, tabImage: TabIcon.patchNotes, tabVC: PNController())),
            createTab(TabItem(tabTitle: TabTitle.more, tabImage: TabIcon.more, tabVC: MoreTabsController()))
        ]
        
        // Tab Bar Colors
        tabBar.barTintColor = ThemeColor.charcoal
        tabBar.tintColor = ThemeColor.platinum
        tabBar.unselectedItemTintColor = ThemeColor.romanSilver
        tabBar.isTranslucent = false
    }
    
    
    //MARK: Create Tab
    private func createTab(_ tabItem: TabItem) -> UINavigationController {
        let navigationController = NavBarController(rootViewController: tabItem.viewController)
        navigationController.tabBarItem.title = tabItem.title
        navigationController.tabBarItem.image = tabItem.image
        return navigationController
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let vc = viewController as? NavBarController {
            vc.popToRootViewController(animated: false)
        }
    }
}
