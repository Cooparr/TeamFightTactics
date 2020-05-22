//
//  MenuCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 22/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    //MARK:- Properties
    let menuLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.textColor = ThemeColor.romanSilver
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return lbl
    }()
    
    override var isHighlighted: Bool {
        didSet{
            menuLabel.textColor = isHighlighted ? ThemeColor.platinum : ThemeColor.romanSilver
            menuLabel.font = isHighlighted ? UIFont.systemFont(ofSize: 16, weight: .semibold) : UIFont.systemFont(ofSize: 16, weight: .regular)
        }
    }
    
    override var isSelected: Bool {
        didSet{
            menuLabel.textColor = isSelected ? ThemeColor.platinum : ThemeColor.romanSilver
            menuLabel.font = isSelected ? UIFont.systemFont(ofSize: 16, weight: .semibold) : UIFont.systemFont(ofSize: 16, weight: .regular)
        }
    }
    
    
    //MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        constrainMenuLabel()
    }
    
    
    //MARK:- Constrain Menu Label
    fileprivate func constrainMenuLabel() {
        addSubview(menuLabel)
        NSLayoutConstraint.activate([
            menuLabel.topAnchor.constraint(equalTo: topAnchor),
            menuLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            menuLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            menuLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
