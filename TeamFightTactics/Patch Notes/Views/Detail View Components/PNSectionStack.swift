//
//  PNSectionStack.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 21/07/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class PNSectionStack: BaseStack {
    #warning("Come back to this - sectionnamepanel could use convinence init?")
    //MARK:- Properties
    let sectionName = BaseLabel(fontSize: 22, fontWeight: .semibold, fontColor: TraitRatingColor.gold)
    let sectionNamePanel: BaseView = {
        let view = BaseView()
        view.layer.cornerRadius = 4.0
        return view
    }()
    
    let changesStack: BaseStack = {
        let stack = BaseStack(axis: .vertical, spacing: 8)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6)
        return stack
    }()
    
    
    //MARK:- Setup Stack
    override func setupStack() {
        isLayoutMarginsRelativeArrangement = true
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
    }
    
    
    //MARK:- Setup Arranged Subviews
    override func setupArrangedSubviews() {
        createSectionNamePanel()
        addArrangedSubviews(sectionNamePanel, changesStack)
    }
    
    
    //MARK:- Create Section Name Panel
    fileprivate func createSectionNamePanel() {
        sectionNamePanel.addSubview(sectionName)
        NSLayoutConstraint.activate([
            sectionName.topAnchor.constraint(equalTo: sectionNamePanel.topAnchor, constant: 3),
            sectionName.centerXAnchor.constraint(equalTo: sectionNamePanel.centerXAnchor),
            sectionName.bottomAnchor.constraint(equalTo: sectionNamePanel.bottomAnchor, constant: -3)
        ])
    }
}
