//
//  BaseStack.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 20/07/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class BaseStack: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupStack()
        setupArrangedSubviews()
    }
    
    convenience init(axis: NSLayoutConstraint.Axis = .horizontal, distribution: Distribution = .fill, alignment: Alignment = .fill, spacing: CGFloat = 0) {
        self.init(frame: .zero)
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
    }
    
    func setupStack() {}
    func setupArrangedSubviews() {}
    
    
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
