//
//  TeamCompDetailViewController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 11/12/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class TeamCompDetailViewController: UIViewController {
    
    var teamComp: TeamComposition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = teamComp?.title
        navigationController?.navigationBar.topItem?.title = "Back"
        
        view.backgroundColor = CustomColor.richBlack
    }
    
}
