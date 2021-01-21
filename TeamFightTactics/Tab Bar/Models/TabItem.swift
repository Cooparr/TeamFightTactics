//
//  TabItem.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 13/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit


struct TabItem {
    let title: String
    let image: UIImage?
    let viewController: UIViewController
    
    init(tabTitle: TabTitle, tabImage: UIImage?, tabVC: UIViewController) {
        self.title = tabTitle.rawValue
        self.image = tabImage
        self.viewController = tabVC
    }
}
