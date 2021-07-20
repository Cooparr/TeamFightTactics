//
//  TextViewExtension.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 01/06/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

extension UITextView {
    
    //MARK: Add Done Button To Keyboard
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barTintColor = ThemeColor.charcoal
        doneToolbar.tintColor = ThemeColor.platinum
        

        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc private func doneButtonAction() {
        self.resignFirstResponder()
    }
}
