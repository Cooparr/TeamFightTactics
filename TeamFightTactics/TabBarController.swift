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
        fetchDefaultTab()
        fetchDefaultSet()
    }
    
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    //MARK: Fetch Default Set
    fileprivate func fetchDefaultSet() {
        let defaults = UserDefaults.standard
        
        if let fetchedSet = defaults.object(forKey: Constants.setKey) as? String {
            fetchData(from: fetchedSet)
        } else {
            defaults.set(Constants.setTwo, forKey: Constants.setKey)
            fetchData(from: Constants.setTwo)
        }
    }
    
    //MARK: Fetch Default Tab
    fileprivate func fetchDefaultTab() {
        let defaults = UserDefaults.standard
        
        if let fetchedTab = defaults.object(forKey: Constants.tabKey) as? Int {
            self.selectedIndex = fetchedTab
        } else {
            defaults.set(Constants.teamCompTabNum, forKey: Constants.tabKey)
            self.selectedIndex = Constants.teamCompTabNum
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
            self.prefetchChampImages()
            fetchDispatchGroup.leave()
        }

        fetchDispatchGroup.enter()
        service.fetchFirestoreData(from: set, in: "TeamCompositions") { (teamComps: [TeamComposition]) in
            self.rootTeamComps = teamComps.sorted(by: {$0.tier.rawValue < $1.tier.rawValue})
            fetchDispatchGroup.leave()
        }
        
        fetchDispatchGroup.notify(queue: .main) {
//            for tc in self.rootTeamComps {
//                var champArray = [Champion]()
//                for champ in self.rootChamps where tc.endGame.contains(where: {$0.name == champ.name}) {
//                    champArray.append(champ)
//                }
//                tc.champObjs = champArray
//                print(tc.title, tc.champObjs.count)
//            }
            
            
            self.champController.allChampions = self.rootChamps
            self.teamCompController.allChampions = self.rootChamps
            self.teamCompController.allTeamComps = self.rootTeamComps
        }
    }
    
    
    //MARK: Prefetch Champ & Ability Images
    fileprivate func prefetchChampImages() {
        let champImgURLS = self.rootChamps.compactMap({
            URL(string: "https://raw.communitydragon.org/\(Constants.cdVer)/game/assets/characters/\($0.imgURL).png")
        })
        
        let abilityImgURLS = self.rootChamps.compactMap({
            URL(string: "https://raw.communitydragon.org/\(Constants.cdVer)/game/assets/characters/\($0.key)/hud/icons2d/\($0.ability.key).png")
        })
        
        SDWebImagePrefetcher.shared.prefetchURLs(champImgURLS + abilityImgURLS)
    }
}
