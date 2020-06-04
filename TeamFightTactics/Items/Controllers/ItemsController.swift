//
//  ItemsController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 22/07/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class ItemsController: UIViewController {

    //MARK: Properties
    private let itemsView = ItemsView()
    var allItems = [Item]() {
        didSet {
            itemsView.reloadData()
        }
    }
    
    
    
    //MARK: Load View
    override func loadView() {
        super.loadView()
        self.view = itemsView
    }
    
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarSetup()
    }
    
    
    //MARK: Navigation Bar Code
    fileprivate func navigationBarSetup() {
        navigationItem.title = "Items"
        rightNavBarSettingsButton()
    }
}
