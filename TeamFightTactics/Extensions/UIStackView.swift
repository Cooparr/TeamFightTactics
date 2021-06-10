//
//  StackViewExtension.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 24/09/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

//MARK:- UIStackView Extensions
extension UIStackView {
    func addArrangedSubviews(_ subviews: UIView...) {
        subviews.forEach { addArrangedSubview($0) }
    }
}
