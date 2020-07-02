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
    
    
    func removeCharacters(from forbiddenChars: CharacterSet) -> String {
        let passed = self.unicodeScalars.filter { !forbiddenChars.contains($0) }
        return String(String.UnicodeScalarView(passed))
    }
    
    func formattedName(from: String = ".' ") -> String {
        return removeCharacters(from: CharacterSet(charactersIn: from)).lowercased()
    }
}
