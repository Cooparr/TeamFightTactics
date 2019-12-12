//
//  BestItemImageView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 27/11/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class BestItemImageView: UIImageView {    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        contentMode = .scaleAspectFit
        layer.borderColor = CustomColor.romanSilver.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 2.0
        layer.masksToBounds = true
        widthAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
