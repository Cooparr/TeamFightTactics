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
    }
}

//MARK:- View Controller Extension
extension UIViewController {
    func rightNavBarSettingsButton() {
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        let settingsIcon = UIImage(systemName: "gear", withConfiguration: boldConfig)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: settingsIcon, style: .plain, target: self, action: #selector(goToSettings))
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
    }
    
    @objc fileprivate func goToSettings() {
        let settings = SettingsController()
        self.navigationController?.pushViewController(settings, animated: true)
    }
}
