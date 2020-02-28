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
        
        navigationBar.barTintColor = CustomColor.charcoal
        navigationBar.tintColor = CustomColor.platinum
        navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: CustomColor.platinum]
    }
}

//MARK:- View Controller Extension
extension UIViewController {
    func rightNavBarSettingsButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Settings"), style: .plain, target: self, action: #selector(goToSettings))
    }
    
    @objc fileprivate func goToSettings() {
        let settings = SettingsController()
        self.navigationController?.pushViewController(settings, animated: true)
    }
}
