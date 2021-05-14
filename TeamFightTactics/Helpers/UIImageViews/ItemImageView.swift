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
    private let initialBorderWidth: CGFloat
    private let initialBorderColor: UIColor?
    
    
    //MARK:- Init
    init(cornerRadius: CGFloat, borderWidth: CGFloat = 0.0, borderColor: UIColor? = nil) {
        self.initialBorderWidth = borderWidth
        self.initialBorderColor = borderColor
        
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        contentMode = .scaleAspectFit
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor?.cgColor
    }
    
    
    //MARK:- Configure Image View
    func configureImageView(with itemName: String, isShadowItem: Bool) {
        image = UIImage(named: itemName.formattedName())
        guard !isShadowItem else { return removeBorder() }
        setBorderToInitial()
    }
    
    
    //MARK: Remove Border
    private func removeBorder() {
        layer.borderWidth = 0.0
        layer.borderColor = nil
    }
    
    
    //MARK: Set To Initial Border
    private func setBorderToInitial() {
        layer.borderWidth = initialBorderWidth
        layer.borderColor = initialBorderColor?.cgColor
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
