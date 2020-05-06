//
//  CustomActivityIndicator.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 21/01/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class CustomActivityIndicator: UIActivityIndicatorView {

    override init(style: UIActivityIndicatorView.Style) {
        super.init(style: style)
        translatesAutoresizingMaskIntoConstraints = false
        color = ThemeColor.romanSilver
    }

    convenience init() {
        self.init(style: .whiteLarge)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIViewController {
    func handleSpinner(spin indicator: UIActivityIndicatorView, if empty: Bool) {
        if empty {
            indicator.startAnimating()
        } else {
            indicator.stopAnimating()
        }
    }
}
