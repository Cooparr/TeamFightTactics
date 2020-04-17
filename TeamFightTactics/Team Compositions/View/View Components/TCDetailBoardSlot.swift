//
//  TCDetailBoardSlot.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 12/12/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCDetailBoardSlot: UIImageView {
    
    //MARK:- Override Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentMode = .scaleAspectFill
        backgroundColor = CustomColor.charcoal
        setupHexagonMask(lineWidth: 2.0, color: CustomColor.romanSilver, cornerRadius: 1)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 50),
            widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    //MARK:- Convinence Init
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
