//
//  StringExtension.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 24/01/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit


//MARK:- String Extension
extension String {
    static var bulletPoint: String {
        return "\u{2022} "
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
    
    
    func createDeveloperNote() -> NSAttributedString {
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]
        let boldString = NSMutableAttributedString(string: "Developer Note: ", attributes: attributes)
        let developerNote = NSMutableAttributedString(string: self)
        boldString.append(developerNote)
        return boldString
    }
}
