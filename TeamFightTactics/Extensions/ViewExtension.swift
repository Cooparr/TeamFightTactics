//
//  ViewExtension.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 08/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

//MARK:- UIView Extensions
extension UIView {
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
    
    
    func pinSubview(to superView: UIView) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor)
        ])
    }
    
    
    func pinSubviewWithPadding(to superView: UIView, top: CGFloat = 0, leading: CGFloat = 0, trailing: CGFloat = 0, bottom: CGFloat = 0) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor, constant: top),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: leading),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -trailing),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -bottom)
        ])
    }
    
    
    func pinSubviewWithPadding(to superView: UIView, allSides: CGFloat) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor, constant: allSides),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: allSides),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -allSides),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -allSides)
        ])
    }
}
