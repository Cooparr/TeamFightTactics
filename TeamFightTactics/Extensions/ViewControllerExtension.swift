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
    func add(childVC child: UIViewController, toStack rootView: UIStackView) {
        addChild(child)
        rootView.addArrangedSubview(child.view)
        child.didMove(toParent: self)
    }
}
