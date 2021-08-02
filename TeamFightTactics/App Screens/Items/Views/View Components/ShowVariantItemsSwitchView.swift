//
//  ShowVariantItemsSwitchView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 21/05/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class ShowVariantItemsSwitchView: BaseView {
    
    //MARK: Properties
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    
    private let hideVariantItemsLabel = BaseLabel(fontSize: 16, fontWeight: .medium, textAlignment: .center)
    private let hideVariantItemsSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.addTarget(self, action: #selector(CSItemController.showShadowItemSwitchChanged), for: .valueChanged)
        toggle.translatesAutoresizingMaskIntoConstraints = false
        toggle.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        return toggle
    }()
    
    
    //MARK: Setup View
    override func setupView() {
        super.setupView()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ThemeColor.charcoal
        layer.cornerRadius = 8
        alpha = 0
        
        addSubview(stackView)
        stackView.pinSubviewWithPadding(to: self, top: 3, leading: 8, trailing: 3, bottom: 3)
        stackView.addArrangedSubviews(hideVariantItemsLabel, hideVariantItemsSwitch)
    }
    
    
    //MARK:- Configure Variant Items Switch
    func configureVariantItemsSwitch() {
        switch SettingsManager.getDisplayedSet() {
        case .one, .two, .three, .four, .four_5:
            self.fadeOut(duration: 0.8)
        case .five:
            hideVariantItemsLabel.text = "Show Shadow"
            self.fadeIn(duration: 0.8)
        case .latest:
            #warning("When Set 6 comes out this will need to be changed, as latest might not have Radiant Items anymore.")
            hideVariantItemsLabel.text = "Show Radiant"
            self.fadeIn(duration: 0.8)
        }
    }
}
