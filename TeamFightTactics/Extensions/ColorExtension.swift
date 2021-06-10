//
//  UIColor.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 22/01/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

//MARK: UIColor Extension
extension UIColor {
    
    convenience init(bundleName: String) {
        self.init(named: bundleName)!
    }
    
    
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}
