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
    
    //MARK: Bullet Point Property
    static var bulletPoint: String {
        return "\u{2022} "
    }
    
    
    //MARK: Remove Characters
    func removeCharacters(from forbiddenChars: CharacterSet) -> String {
        let passed = self.unicodeScalars.filter { !forbiddenChars.contains($0) }
        return String(String.UnicodeScalarView(passed))
    }
    
    
    //MARK: Formatted Name
    func formattedName(charactersToRemove: String = ".' ") -> String {
        return removeCharacters(from: CharacterSet(charactersIn: charactersToRemove)).lowercased()
    }
    
    
    //MARK: Developer Note
    func createDeveloperNote() -> NSAttributedString {
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]
        let boldString = NSMutableAttributedString(string: "Developer Note: ", attributes: attributes)
        let developerNote = NSMutableAttributedString(string: self)
        boldString.append(developerNote)
        return boldString
    }
}
