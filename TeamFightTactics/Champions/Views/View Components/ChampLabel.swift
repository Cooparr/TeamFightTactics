//
//  ChampLabel.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 04/11/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class ChampLabel: UILabel {

    init(fontSize: CGFloat, fontWeight: UIFont.Weight) {
        super.init(frame: CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        textColor = CustomColor.platinum
        font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
    }
    
    convenience init() {
        self.init(fontSize: 12, fontWeight: .bold)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
