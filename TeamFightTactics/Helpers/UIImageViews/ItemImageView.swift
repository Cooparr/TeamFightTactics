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
    private(set) var initialBorderWidth: CGFloat?
    private(set) var initialBorderColor: UIColor?
    
    
    //MARK:- Override Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        contentMode = .scaleAspectFit
    }
    
    
    //MARK: Convenience Init (Corner Radius, Border Width & Layer)
    convenience init(cornerRadius: CGFloat, borderWidth: CGFloat = 0, borderColor: UIColor? = nil) {
        self.init(frame: .zero)
        initialBorderWidth = borderWidth
        initialBorderColor = borderColor
        
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor?.cgColor
    }
    
    
    //MARK: Convenience Init (Size & Corner Radius)
    convenience init(size: CGFloat, cornerRadius: CGFloat = 0) {
        self.init(frame: .zero)        
        layer.cornerRadius = cornerRadius
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: size),
            heightAnchor.constraint(equalToConstant: size)
        ])
    }
    
    
    //MARK:- Configure Item Name & isShadow
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
        layer.borderWidth = initialBorderWidth ?? 0
        layer.borderColor = initialBorderColor?.cgColor
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
