//
//  ChampStatIcon.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 03/12/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class ChampStatIcon: UIImageView {

    init(image: UIImage?, iconColor: UIColor) {
        super.init(image: image)
        translatesAutoresizingMaskIntoConstraints = false
        tintColor = iconColor
        contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 15),
            widthAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
