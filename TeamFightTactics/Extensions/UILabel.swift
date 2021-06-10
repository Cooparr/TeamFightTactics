//
//  LabelExtension.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 19/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

//MARK:- UILabel Extension
extension UILabel {
    
    //MARK:- Create Circular Label
    func makeCircular(size: CGFloat) {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: size),
            self.widthAnchor.constraint(equalToConstant: size)
        ])

        self.textAlignment = .center
        self.layer.cornerRadius = size / 2
        self.layer.masksToBounds = true
    }
}
