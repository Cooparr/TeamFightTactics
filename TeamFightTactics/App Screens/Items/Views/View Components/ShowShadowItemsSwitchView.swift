//
//  ShowShadowItemsSwitchView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 21/05/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class ShowShadowItemsSwitchView: BaseView {
    
    //MARK: Properties
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    
    private let hideShadowItemsLabel = BaseLabel(fontSize: 16, fontWeight: .medium, lblText: "Shadow Items", textAlignment: .center)
    private let hideShadowItemsSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.addTarget(self, action: #selector(CSItemController.showShadowItemSwitchChanged), for: .valueChanged)
        toggle.translatesAutoresizingMaskIntoConstraints = false
        toggle.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        return toggle
    }()
    
    
    override func setupView() {
        super.setupView()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ThemeColor.charcoal
        layer.cornerRadius = 8
        alpha = 0
        
        addSubview(stackView)
        stackView.pinSubviewWithPadding(to: self, top: 3, leading: 8, trailing: 3, bottom: 3)
        stackView.addArrangedSubviews(hideShadowItemsLabel, hideShadowItemsSwitch)
    }
    
    
    //MARK:- Should Hide Shadow Items Switch
    func displayShadowItemsSwitch() {
        switch SettingsManager.getDisplayedSet() != TFTSet.five {
        case true:
            self.fadeOut(duration: 0.8)
        case false:
            self.fadeIn(duration: 0.8)
        }
    }
}
