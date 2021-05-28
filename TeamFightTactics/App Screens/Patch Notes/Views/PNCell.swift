//
//  PNCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 10/07/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class PNCell: BaseTableViewCell, ReusableCell {
    
    //MARK:- Properties
    typealias DataType = PatchNote
    static var reuseId: String = "patchNoteId"
    
    let patchLabel = BaseLabel(fontSize: 22, fontWeight: .medium)
    let dateLabel = BaseLabel(fontSize: 12, fontWeight: .light, fontColor: ThemeColor.romanSilver)
    let cellStack = BaseStack(axis: .vertical, spacing: 2)
    
    
    //MARK:- Configure Cell
        func configureCell(with patchNotes: PatchNote) {
            patchLabel.text = patchNotes.version
            dateLabel.text = patchNotes.getDateAsString()
        }

    
    //MARK:- Setup Cell
    override func setupCell() {
        accessoryType = .disclosureIndicator
        backgroundColor = ThemeColor.richBlack
    }
    
    
    //MARK:- Setup Cell Views
    override func setupCellViews() {
        contentView.addSubview(cellStack)
        cellStack.addArrangedSubviews(patchLabel, dateLabel)
        NSLayoutConstraint.activate([
            cellStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
    }
}
