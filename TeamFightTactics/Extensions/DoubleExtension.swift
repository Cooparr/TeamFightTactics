//
//  DoubleExtension.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 11/03/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import Foundation

extension Double {
    
    var removePointZero: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
