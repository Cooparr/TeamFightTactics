//
//  PNSectionStack.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 21/07/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class PNSectionStack: BaseStack {
    
    //MARK:- Properties
    let sectionName = BaseLabel(fontSize: 22, fontWeight: .semibold)
    let sectionNamePanel: BaseView = {
        let view = BaseView()
        view.backgroundColor = ThemeColor.romanSilver
        view.layer.cornerRadius = 4.0
        return view
    }()
    
    let changesStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        return stack
    }()
    
    
    //MARK:- Setup Stack
    override func setupStack() {
        axis = .vertical
        spacing = 6
        isLayoutMarginsRelativeArrangement = true
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
    }
    
    
    //MARK:- Setup Arranged Subviews
    override func setupArrangedSubviews() {
        createSectionNamePanel()
        addArrangedSubview(sectionNamePanel)
        addArrangedSubview(changesStack)
    }
    
    
    //MARK:- Create Section Name Panel
    fileprivate func createSectionNamePanel() {
        sectionNamePanel.addSubview(sectionName)
        NSLayoutConstraint.activate([
            sectionName.topAnchor.constraint(equalTo: sectionNamePanel.topAnchor, constant: 3),
            sectionName.leadingAnchor.constraint(equalTo: sectionNamePanel.leadingAnchor, constant: 5),
            sectionName.trailingAnchor.constraint(equalTo: sectionNamePanel.trailingAnchor, constant: -5),
            sectionName.bottomAnchor.constraint(equalTo: sectionNamePanel.bottomAnchor, constant: -3)
        ])
    }
}