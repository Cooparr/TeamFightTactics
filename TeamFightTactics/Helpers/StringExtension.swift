//
//  StringExtension.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 24/01/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import Foundation


//MARK:- String Extension
extension String {
    func removeNameSpaces() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    func isLuxOrQiyana() -> String {
        if self.contains("Lux") {
            return "Lux"
        } else if self.contains("Qiyana") {
            return "Qiyana"
        } else {
            return self
        }
    }
}
