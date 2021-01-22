//
//  GenericImageView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 20/01/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class GenericImageView: GeneralImageView {
    
    //MARK:- Init
    init(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor) {
        super.init(frame: .zero)
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }



    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
