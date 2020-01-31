//
//  StringExtension.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 24/01/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import Foundation


extension String {
    
    //MARK: Remove Spaces in Champ Name Strings
    func removeNameSpaces() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    //MARK: Format Lux and Qiyana Name Strings
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
