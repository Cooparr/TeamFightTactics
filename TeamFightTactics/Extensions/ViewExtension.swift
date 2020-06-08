//
//  ViewExtension.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 08/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit


//MARK:- UIView Extensions
extension UIView {
    
    func pinSubview(to superView: UIView) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor)
        ])
    }
}
