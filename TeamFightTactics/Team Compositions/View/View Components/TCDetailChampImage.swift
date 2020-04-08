//
//  TCDetailChampImage.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 12/12/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCDetailChampImage: UIImageView {
    
    //MARK:- Override Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
        layer.borderWidth = 1.0
        layer.cornerRadius = 2.0
        layer.borderColor = CustomColor.romanSilver.cgColor
        isHidden = true
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 50),
            widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    //MARK:- Convinence Init
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
