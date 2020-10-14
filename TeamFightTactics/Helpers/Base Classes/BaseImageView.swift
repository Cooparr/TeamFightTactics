//
//  BaseImageView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 15/09/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class BaseImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(image: UIImage? = nil, contentMode: ContentMode = .scaleAspectFit, tintColor: UIColor? = nil) {
        self.init(frame: CGRect.zero)
        self.image = image
        self.contentMode = contentMode
        self.tintColor = tintColor
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
