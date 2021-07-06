//
//  CellFlair.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 06/07/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

#warning("This could be optimised - Use BaseView etc etc, also more cells need to utilise")
class CellFlair: UIView {
    
    //MARK:- Properties
    private let flairLabel = BaseLabel(fontSize: 12, fontWeight: .semibold, fontColor: ThemeColor.richBlack, textAlignment: .center)
    
    
    //MARK:- Override Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        layer.cornerRadius = 6.0
        layer.maskedCorners = [.layerMinXMaxYCorner]
        
        addSubview(flairLabel)
        flairLabel.pinSubview(to: self)
    }
    
    
    //MARK: Setup Flair
    func updateFlair(text: String, backgroundColor: UIColor) {
        flairLabel.text = text
        self.backgroundColor = backgroundColor
    }
    
    
    //MARK:- Constrain Cell Flair
    func constrainCellFlair(to cell: UITableViewCell) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: cell.topAnchor),
            self.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
            self.widthAnchor.constraint(equalToConstant: 60),
            self.heightAnchor.constraint(equalToConstant: 17)
        ])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
