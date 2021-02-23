//
//  SaveTeamCompAlertController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 23/02/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class SaveTeamCompAlertController: UIAlertController {
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
    }
    
    
    //MARK: Setup Text Field
    fileprivate func setupTextField() {
        addTextField { textField in
            textField.placeholder = "Name this Team Comp"
            textField.textAlignment = .center
            textField.textColor = ThemeColor.platinum
            textField.font = UIFont.preferredFont(forTextStyle: .body)
            textField.adjustsFontSizeToFitWidth = true
            textField.minimumFontSize = 12
            textField.autocorrectionType = .no
            textField.returnKeyType = .done
            textField.clearButtonMode = .whileEditing
            textField.tintColor = ThemeColor.platinum
            textField.layer.borderColor = ThemeColor.romanSilver.cgColor
            textField.delegate = self
        }
    }
}


extension SaveTeamCompAlertController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 20
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}
