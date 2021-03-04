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
    let sectionNamePanel = BaseView()
    let sectionName = BaseLabel(fontSize: 22, fontWeight: .semibold, fontColor: TraitRatingColor.gold)
    let changesStack: BaseStack = {
        let stack = BaseStack(axis: .vertical, spacing: 8)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6)
        return stack
    }()
    
    
    //MARK: Configure Section Info
    func configureSection(title: String, devNote: String?) {
        sectionName.text = title
        
        if let developerNote = devNote {
            createDevNotePanel(developerNote)
        }
    }
    
    
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
    
    
    //MARK:- Create Section Dev Note Panel
    fileprivate func createDevNotePanel(_ developerNote: String) {
        let sectionDevNotePanel = BaseView(backgroundColor: ThemeColor.charcoal, cornerRadius: 6)
        let sectionDevNote = BaseLabel(fontSize: 14, fontWeight: .regular, multiLine: true)
        sectionDevNote.attributedText = developerNote.createDeveloperNote()
        constrainSectionDevNotePanel(panel: sectionDevNotePanel, devNoteLabel: sectionDevNote)
        insertArrangedSubview(sectionDevNotePanel, at: 1)
    }
    
    
    //MARK:- Constrain  Dev Note Panel
    fileprivate func constrainSectionDevNotePanel(panel: BaseView, devNoteLabel: UILabel) {
        panel.addSubview(devNoteLabel)
        NSLayoutConstraint.activate([
            devNoteLabel.topAnchor.constraint(equalTo: panel.topAnchor, constant: 8),
            devNoteLabel.leadingAnchor.constraint(equalTo: panel.leadingAnchor, constant: 8),
            devNoteLabel.trailingAnchor.constraint(equalTo: panel.trailingAnchor, constant: -8),
            devNoteLabel.bottomAnchor.constraint(equalTo: panel.bottomAnchor, constant: -8)
        ])
    }
}
