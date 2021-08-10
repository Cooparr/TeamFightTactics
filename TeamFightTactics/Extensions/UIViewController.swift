//
//  ViewControllerExtension.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 12/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

//MARK:- View Controller Extension
extension UIViewController {
    
    //MARK: Add Child VC - UIView
    func add(childVC child: UIViewController, toView rootView: UIView) {
        addChild(child)
        rootView.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    //MARK: Add Child VC - UIStackView
    func add(childVC child: UIViewController, toStack rootView: UIStackView) {
        addChild(child)
        rootView.addArrangedSubview(child.view)
        child.didMove(toParent: self)
    }
    
    
    //MARK: Present GFAlert On Main Thread
    func presentErrorAlertOnMainThread(title: String, message: String, buttonTitle: String = "Okay") {
        DispatchQueue.main.async {
            let alertVC = ErrorAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            self.present(alertVC, animated: true)
        }
    }
}
