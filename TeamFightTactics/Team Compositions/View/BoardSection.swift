//
//  BoardSection.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 08/04/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class BoardSection: UIView {

    //MARK: Properties
    var boardSlots = [TCDetailBoardSlot]()
    let boardMap: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = CustomColor.richBlack
        return view
    }()
    
    let boardLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Board Positioning"
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return lbl
    }()

    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSection()
        setupBoardLabelAndMap()
        setupBoardSlotsAndConstraints()
    }
    
    
    //MARK: Setup Section
    fileprivate func setupSection() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = CustomColor.richBlack
        heightAnchor.constraint(equalToConstant: 300).isActive = true
    }

    
    //MARK: Setup Board Label & Map
    fileprivate func setupBoardLabelAndMap() {
        addSubview(boardLabel)
        NSLayoutConstraint.activate([
            boardLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            boardLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
        ])
        
        addSubview(boardMap)
        NSLayoutConstraint.activate([
            boardMap.centerXAnchor.constraint(equalTo: centerXAnchor),
            boardMap.topAnchor.constraint(equalTo: boardLabel.bottomAnchor, constant: 6),
            boardMap.leadingAnchor.constraint(equalTo: leadingAnchor),
            boardMap.trailingAnchor.constraint(equalTo: trailingAnchor),
            boardMap.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    //MARK: Setup Board Slots & Constraints
    fileprivate func setupBoardSlotsAndConstraints() {
        // Create 27 Board Slots
        boardSlots = (1...28).map { _ in TCDetailBoardSlot() }
        
        let boardSpacing: CGFloat = -2
        let tightenHexagons: CGFloat = -8
        
        // Begin Looping through Slots
        for (index, slot) in boardSlots.enumerated() {
            boardMap.addSubview(slot)
            
            
            if index.isMultiple(of: 0) {
                NSLayoutConstraint.activate([
                    slot.topAnchor.constraint(equalTo: boardMap.topAnchor),
                    slot.leadingAnchor.constraint(equalTo: boardMap.leadingAnchor)
                ])
            } else if index.isMultiple(of: 14) {
                NSLayoutConstraint.activate([
                    slot.topAnchor.constraint(equalTo: boardSlots[index - 7].bottomAnchor, constant: tightenHexagons),
                    slot.leadingAnchor.constraint(equalTo: boardSlots[0].leadingAnchor)
                ])
            } else if index.isMultiple(of: 7) {
                NSLayoutConstraint.activate([
                    slot.topAnchor.constraint(equalTo: boardSlots[index - 7].bottomAnchor, constant: tightenHexagons),
                    slot.leadingAnchor.constraint(equalTo: boardSlots[index - 7].centerXAnchor, constant: -1)
                ])
            } else {
                NSLayoutConstraint.activate([
                    slot.leadingAnchor.constraint(equalTo: boardSlots[index - 1].trailingAnchor, constant: boardSpacing),
                    slot.topAnchor.constraint(equalTo: boardSlots[index - 1].topAnchor)
                ])
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
