//
//  TCDetailChampImage.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 12/12/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCDetailChampImage: UIImageView {
    
    //MARK:- Properties
    let width: CGFloat
    let height: CGFloat
    let borderWidth: CGFloat
    
    
    //MARK:- Override Init
    init(frame: CGRect, width: CGFloat, height: CGFloat, borderWidth: CGFloat) {
        self.width = width
        self.height = height
        self.borderWidth = borderWidth
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        contentMode = .scaleAspectFit
        layer.borderWidth = borderWidth
        layer.cornerRadius = 2.0
        layer.borderColor = ThemeColor.romanSilver.cgColor
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: width),
            heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    
    //MARK:- Convinence Init
    convenience init(width: CGFloat, height: CGFloat, borderWidth: CGFloat) {
        self.init(frame: CGRect.zero, width: width, height: height, borderWidth: borderWidth)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
