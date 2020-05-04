//
//  TCBoardView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 04/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCBoardView: UIView {
    
    //MARK:- Properties
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
        lbl.text = "Champion Positioning"
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return lbl
    }()
    
    //MARK:- Init
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
            boardMap.topAnchor.constraint(equalTo: boardLabel.bottomAnchor, constant: 6),
            boardMap.bottomAnchor.constraint(equalTo: bottomAnchor),
            boardMap.heightAnchor.constraint(equalToConstant: 177),
            boardMap.widthAnchor.constraint(equalToConstant: 362),
            boardMap.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    
    //MARK: Setup Board Slots & Constraints
    fileprivate func setupBoardSlotsAndConstraints() {
        boardSlots = (1...28).map { _ in TCDetailBoardSlot() }
        
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
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
