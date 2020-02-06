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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(setupAlertController))
    }
    
    @objc fileprivate func setupAlertController() {
        let alertController: UIAlertController = UIAlertController(title: "Change Set", message: "Tap which Set data you would like to display", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Set 1", style: .default, handler: changeSetData))
        alertController.addAction(UIAlertAction(title: "Set 2", style: .default, handler: changeSetData))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        
        #if DEBUG
        alertController.pruneNegativeWidthConstraints()
        #endif
        
        present(alertController, animated: true)
    }
    
    fileprivate func changeSetData(_ alert: UIAlertAction) {
        guard let set = alert.title?.removeNameSpaces() else { return }
        if let tabCont = self.tabBarController as? TabBarController {
            if tabCont.fetchedSet != set {
                tabCont.fetchedSet = set
                tabCont.fetchData(from: set)
            }
        }
    }
}


//MARK:- Alert Controller
extension UIAlertController {
    func pruneNegativeWidthConstraints() {
        for subView in self.view.subviews {
            for constraint in subView.constraints where constraint.debugDescription.contains("width == - 16") {
                subView.removeConstraint(constraint)
            }
        }
    }
}
