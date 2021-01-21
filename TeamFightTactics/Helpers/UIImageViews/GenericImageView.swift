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
    init(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: ThemeColorAlternative) {
        super.init(frame: .zero)
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.color.cgColor
    }



    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
