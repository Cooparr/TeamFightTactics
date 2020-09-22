//
//  BestItemImageView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 27/11/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class BestItemImgView: UIImageView {
    
    //MARK: Override Frame Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        contentMode = .scaleAspectFit
        layer.borderWidth = 1.0
        layer.cornerRadius = 2.0
    }
    
    
    //MARK: Convenience Img & Size Init
    convenience init(img: UIImage?, size: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: size, height: size))
        image = img
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: size),
            heightAnchor.constraint(equalToConstant: size)
        ])
    }
    
    
    //MARK: Convenience Size Init
    convenience init(size: CGFloat) {
        self.init(frame: CGRect.zero)
        layer.borderColor = ThemeColor.romanSilver.cgColor

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: size),
            heightAnchor.constraint(equalToConstant: size)
        ])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
