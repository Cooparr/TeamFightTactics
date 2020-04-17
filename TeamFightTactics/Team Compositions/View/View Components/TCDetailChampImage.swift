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
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        contentMode = .scaleAspectFit
        layer.borderWidth = 1.0
        layer.cornerRadius = 2.0
        layer.borderColor = CustomColor.romanSilver.cgColor
    }    
    
    //MARK:- Convinence Init    
    convenience init(width: CGFloat, height: CGFloat) {
      self.init(frame: CGRect.zero)
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: width),
            heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
