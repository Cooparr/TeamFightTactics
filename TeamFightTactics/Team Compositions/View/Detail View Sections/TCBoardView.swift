//
//  TCBoardView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 04/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCBoardView: BaseView {
    
    //MARK:- Properties
    var boardSlots = [TCDetailBoardSlot]()
    let boardMap = BaseView(backgroundColor: ThemeColor.richBlack)
    let boardLabel: BaseLabel = {
        let lbl = BaseLabel(fontSize: 20, fontWeight: .regular, lblText: "Champion Positioning")
        lbl.textAlignment = .center
        return lbl
    }()
    
    
    //MARK:- Setup View
    override func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ThemeColor.richBlack
    }
    
    
    //MARK: Setup Subviews
    override func setupSubviews() {
        setupBoardLabelAndMap()
        setupBoardSlotsAndConstraints()
        let lastBoardSlot = boardSlots.endIndex - 1
        boardSlots[lastBoardSlot].bottomAnchor.constraint(equalTo: boardMap.bottomAnchor).isActive = true
    }
    
    
    //MARK: Setup Board Label & Map
    fileprivate func setupBoardLabelAndMap() {
        addSubviews(boardLabel, boardMap)
        NSLayoutConstraint.activate([
            boardLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            boardLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            boardLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            boardMap.topAnchor.constraint(equalTo: boardLabel.bottomAnchor, constant: 6),
            boardMap.bottomAnchor.constraint(equalTo: bottomAnchor),
            boardMap.widthAnchor.constraint(equalToConstant: 362),
            boardMap.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    
    //MARK: Setup Board Slots & Constraints
    fileprivate func setupBoardSlotsAndConstraints() {
        if UserDefaults.standard.integer(forKey: UDKey.setKey) == 1 {
            boardSlots = (1...21).map { _ in TCDetailBoardSlot() }
        } else {
            boardSlots = (1...28).map { _ in TCDetailBoardSlot() }
        }
        
        let boardSpacing: CGFloat = -2
        let tightenHexagons: CGFloat = -8
        
        for (index, slot) in boardSlots.enumerated() {
            boardMap.addSubview(slot)
            let topConstraint: NSLayoutConstraint
            let leadConstraint: NSLayoutConstraint
            
            switch index {
            case 0:
                topConstraint = slot.topAnchor.constraint(equalTo: boardMap.topAnchor)
                leadConstraint = slot.leadingAnchor.constraint(equalTo: boardMap.leadingAnchor)
            case 7, 21:
                topConstraint = slot.topAnchor.constraint(equalTo: boardSlots[index - 7].bottomAnchor, constant: tightenHexagons)
                leadConstraint = slot.leadingAnchor.constraint(equalTo: boardSlots[index - 7].centerXAnchor, constant: -1)
            case 14:
                topConstraint = slot.topAnchor.constraint(equalTo: boardSlots[index - 7].bottomAnchor, constant: tightenHexagons)
                leadConstraint = slot.leadingAnchor.constraint(equalTo: boardSlots[0].leadingAnchor)
            default:
                topConstraint = slot.topAnchor.constraint(equalTo: boardSlots[index - 1].topAnchor)
                leadConstraint = slot.leadingAnchor.constraint(equalTo: boardSlots[index - 1].trailingAnchor, constant: boardSpacing)
            }

            addConstraints([topConstraint, leadConstraint])
        }
    }
}
