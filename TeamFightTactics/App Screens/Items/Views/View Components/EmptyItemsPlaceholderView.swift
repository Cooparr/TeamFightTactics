//
//  EmptyItemsPlaceholderView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 25/05/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class MainCSItemsPlaceholderView: BaseView {
    
    //MARK: Properties
    private let placholderLabel: BaseLabel = {
        let lbl = BaseLabel(fontSize: 16, fontWeight: .medium, lblText: "Tap Item to view more info.")
        lbl.textAlignment = .center
        return lbl
    }()
    
    
    //MARK: Setup View
    override func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ThemeColor.charcoal
        layer.cornerRadius = 6
        alpha = 0
    }
    
    
    //MARK: Setup Subviews
    override func setupSubviews() {
        addSubview(placholderLabel)
        placholderLabel.pinSubview(to: self)
    }
    
    
    //MARK:- Handle Placeholder View
    func hidePlaceholderView(if mainItemsIsEmpty: Bool) {
        switch mainItemsIsEmpty {
        case true:
            self.fadeIn(duration: 1.0)
        case false:
            self.fadeOut(duration: 0)
        }
    }
}
