//
//  PNChangeView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 21/07/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class PNChangeView: BaseView {
    
    //MARK: Properties
    let titleDevNoteStack = BaseStack(axis: .vertical, spacing: 5)
    let changeTitle = BaseLabel(fontSize: 18, fontWeight: .semibold, fontColor: ThemeColor.platinum, multiLine: true)

    let pointsStack: BaseStack = {
        let stack = BaseStack(axis: .vertical)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0)
        return stack
    }()
    
    
    //MARK: Override Setup View
    override func setupView() {
        layer.masksToBounds = true
    }
    
    
    //MARK: Override Setup View
    override func setupSubviews() {
        let padding: CGFloat = 8.0
        addSubviews(titleDevNoteStack, pointsStack)
        titleDevNoteStack.addArrangedSubview(changeTitle)
        NSLayoutConstraint.activate([
            titleDevNoteStack.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleDevNoteStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            titleDevNoteStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            titleDevNoteStack.bottomAnchor.constraint(equalTo: pointsStack.topAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            pointsStack.topAnchor.constraint(equalTo: titleDevNoteStack.bottomAnchor, constant: 5),
            pointsStack.leadingAnchor.constraint(equalTo: titleDevNoteStack.leadingAnchor),
            pointsStack.trailingAnchor.constraint(equalTo: titleDevNoteStack.trailingAnchor),
            pointsStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
    }
    
    
    //MARK: Configure Change View
    func configureChangeView(with change: PNChange) {
        changeTitle.text = change.title ?? change.name
        
        if let developerNote = change.devNote {
            createDevNoteLabel(developerNote)
        }
        
        if let changePoints = change.points {
            changePoints.forEach { point in
                createChangePoint(with: point)
            }
        }
    }
    
    
    //MARK: Create Change Point
    fileprivate func createDevNoteLabel(_ developerNote: String) {
        let devNote = BaseLabel(fontSize: 14, fontWeight: .regular, multiLine: true)
        devNote.attributedText = developerNote.createDeveloperNote()
        titleDevNoteStack.addArrangedSubview(devNote)
    }
    
    
    //MARK: Create Change Point
    fileprivate func createChangePoint(with point: String) {
        let pointLabel = BaseLabel(fontSize: 14, fontWeight: .regular, multiLine: true)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = 9
        let attributes = [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        let bulletList = NSMutableAttributedString(string: .bulletPoint + point, attributes: attributes)
        pointLabel.attributedText = bulletList
        pointsStack.addArrangedSubview(pointLabel)
    }
}
