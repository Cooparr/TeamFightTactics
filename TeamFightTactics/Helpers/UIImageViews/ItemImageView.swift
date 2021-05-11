//
//  ItemImageView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 11/05/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class ItemImageView: UIImageView {
    
    //MARK: Properties
    private let borderWidth: CGFloat
    private let borderColor: UIColor

    //MARK:- Init
    init(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor) {
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        contentMode = .scaleAspectFit
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
    }
    
    
    //MARK:- Configure Image View
    func configureImageView(with itemName: String, isShadow: Bool?) {
        image = UIImage(named: itemName.formattedName())
        isShadow == true ? removeBorder() : setBorder()
    }
    
    
    //MARK:  Set Border Color
    private func setBorder() {
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
    
    
    //MARK:  Remove Border Color
    private func removeBorder() {
        layer.borderWidth = 0.0
        layer.borderColor = nil
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
