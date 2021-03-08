//
//  ChampionImageView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 20/01/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class ChampionImageView: GeneralImageView {
    
    //MARK:- Override Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 2.0
    }
    
    
    //MARK:- Custom Init
    init(imageSize: CGFloat) {
        super.init(frame: CGRect(x: 0, y: 0, width: imageSize, height: imageSize))
        
        layer.cornerRadius = 2.0
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: imageSize),
            self.heightAnchor.constraint(equalToConstant: imageSize)
        ])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
