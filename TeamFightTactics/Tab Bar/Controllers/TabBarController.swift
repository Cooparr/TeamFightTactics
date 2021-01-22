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
        implementUserCustomSettings()
    }
    
    
    //MARK: Setup Tab Bar
    fileprivate func setupTabBar() {
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
    
    
    //MARK: Implement Custom User Settings
    fileprivate func implementUserCustomSettings() {
        let desiredTab = UserDefaults.standard.integer(forKey: UDKey.tabKey)
        self.selectedIndex = desiredTab
    }
    
    
    //MARK: Create Tab
    fileprivate func createTab(_ tabItem: TabItem) -> UINavigationController {
        let navigationController = NavBarController(rootViewController: tabItem.viewController)
        navigationController.tabBarItem.title = tabItem.title
        navigationController.tabBarItem.image = tabItem.image
        return navigationController
    }
}
