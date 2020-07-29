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
        setupStack()
        setupArrangedSubviews()
    }
    
    func setupStack() {}
    func setupArrangedSubviews() {}
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
