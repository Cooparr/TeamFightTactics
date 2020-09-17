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
    
    convenience init(contentMode: ContentMode = .scaleAspectFit) {
        self.init(frame: CGRect.zero)
        self.contentMode = contentMode
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
