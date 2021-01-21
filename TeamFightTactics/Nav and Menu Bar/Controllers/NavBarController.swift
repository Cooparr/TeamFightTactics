//
//  NavBarController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 06/02/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class NavBarController: UINavigationController {
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.barTintColor = ThemeColor.charcoal
        navigationBar.tintColor = ThemeColor.platinum
        navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: ThemeColor.platinum]
        navigationBar.shadowImage = UIImage()
    }
}

//MARK:- View Controller Extension
extension UIViewController {
    func setupNavBar(navTitle: TabTitle, showSettingsButton: Bool = true) {
        navigationItem.title = navTitle.rawValue
        
        if showSettingsButton {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: NavIcon.settings, style: .plain, target: self, action: #selector(goToSettings))
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        }
    }

    @objc func goToSettings() {
        self.navigationController?.pushViewController(SettingsController(), animated: true)
    }
}
