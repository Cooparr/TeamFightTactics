//
//  TeamCompChampImage.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 31/10/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class TeamCompChampImage: UIImageView {

    let champImgSize: CGFloat = 35
    
    override init(image: UIImage?) {
        super.init(image: image)
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
        layer.borderWidth = 1.0
        layer.cornerRadius = 2.0
        layer.borderColor = CustomColor.romanSilver.cgColor
        heightAnchor.constraint(equalToConstant: champImgSize).isActive = true
        widthAnchor.constraint(equalToConstant: champImgSize).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
