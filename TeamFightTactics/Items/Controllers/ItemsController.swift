//
//  ItemsController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 22/07/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class ItemsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = ThemeColor.charcoal
        navigationItem.title = "Items"
        
        
        
        view.addSubview(nothingButton)
        nothingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nothingButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        nothingButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    let nothingButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Nothing to see.. yet", for: .normal)
        btn.backgroundColor = ThemeColor.romanSilver
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 1
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        btn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return btn
    }()
    
    @objc func buttonTapped() {
        tabBarController?.selectedIndex = 1
    }
}

