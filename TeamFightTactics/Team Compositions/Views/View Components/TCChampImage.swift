//
//  TCChampImage.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 31/10/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCChampImage: UIImageView {

    //MARK: Properties
    let champImgSize: CGFloat = 35
    
    
    //MARK:- Override Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
        layer.borderWidth = 1.0
        layer.cornerRadius = 2.0
        layer.borderColor = CustomColor.romanSilver.cgColor
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: champImgSize),
            widthAnchor.constraint(equalToConstant: champImgSize)
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
