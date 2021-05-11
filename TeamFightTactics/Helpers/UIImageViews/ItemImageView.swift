//
//  ItemImageView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 11/05/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class ItemImageView: UIImageView {
    
    //MARK:- Init
    init(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        contentMode = .scaleAspectFit
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
    
    
    //MARK:- Configure Image View
    func configureImageView(with item: Item) {
        image = UIImage(named: item.name.formattedName())
        layer.borderWidth = item.isShadow == true ? 0 : 3
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
