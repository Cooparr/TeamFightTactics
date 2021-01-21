//
//  IconImageView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 20/01/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class IconImageView: GeneralImageView {
    
    //MARK:- Init
    init(icon: UIImage? = nil, tintColor: UIColor? = nil) {
        super.init(frame: .zero)
        self.image = icon
        self.tintColor = tintColor
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
