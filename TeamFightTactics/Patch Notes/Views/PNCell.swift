//
//  PNCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 10/07/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class PNCell: UITableViewCell, ReusableCell {
    
    //MARK:- Properties
    typealias DataType = PatchNote
    static var reuseId: String = "patchNoteId"
    
    let patchLabel = BaseLabel(fontSize: 22, fontWeight: .medium)
    let dateLabel = BaseLabel(fontSize: 12, fontWeight: .light, fontColor: ThemeColor.romanSilver)
    let cellStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 2
        return stack
    }()
    
    
    //MARK:- Override Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        backgroundColor = ThemeColor.richBlack
        constrainSubviews()
    }
    
    
    //MARK:- Configure Cell
    func configureCell(with patchNotes: PatchNote) {
        patchLabel.text = patchNotes.version
        dateLabel.text = patchNotes.date
    }
    
    
    //MARK:- Constrain Subviews
    fileprivate func constrainSubviews() {
        contentView.addSubview(cellStack)
        cellStack.addArrangedSubviews(patchLabel, dateLabel)
        NSLayoutConstraint.activate([
            cellStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
