//
//  TCChampImage.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 31/10/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCChampImage: UIImageView {

    //MARK:- Override Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
        clipsToBounds = true
        layer.cornerRadius = 2.0
        layer.borderColor = ThemeColor.romanSilver.cgColor
    }
    
    
    //MARK:- Convinence Init
    convenience init(imageSize: CGFloat, borderWidth: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: imageSize, height: imageSize))
        self.layer.borderWidth = borderWidth
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: imageSize),
            self.heightAnchor.constraint(equalToConstant: imageSize)
        ])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
