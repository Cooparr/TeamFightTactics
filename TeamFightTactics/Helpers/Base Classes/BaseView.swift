//
//  BaseView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 03/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupSubviews()
    }
    
    convenience init(tamic: Bool = false, backgroundColor: UIColor? = nil, cornerRadius: CGFloat = 0.0) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = tamic
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
    }
    
    func setupView() {}
    
    func setupSubviews() {}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
