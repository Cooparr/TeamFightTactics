//
//  TCSynergyBadge.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 01/11/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCSynergyBadge: UIView {
    
    //MARK:- Properties
    let synergyIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.tintColor = CustomColor.platinum
        return imgView
    }()
    
    let synergyCountLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return lbl
    }()
    
    
    //MARK:- Override Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 2.0
        
        setupSubviewsAndConstraints()
    }
    
    
    //MARK:- Setup Subviews & Constraints
    fileprivate func setupSubviewsAndConstraints() {
        addSubview(synergyIcon)
        addSubview(synergyCountLabel)
        NSLayoutConstraint.activate([
            synergyIcon.widthAnchor.constraint(equalToConstant: 25),
            synergyIcon.leadingAnchor.constraint(equalTo: leadingAnchor),
            synergyIcon.topAnchor.constraint(equalTo: topAnchor),
            synergyIcon.trailingAnchor.constraint(equalTo: synergyCountLabel.leadingAnchor),
            synergyIcon.bottomAnchor.constraint(equalTo: bottomAnchor),
            synergyCountLabel.leadingAnchor.constraint(equalTo: synergyIcon.trailingAnchor),
            synergyCountLabel.topAnchor.constraint(equalTo: topAnchor),
            synergyCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            synergyCountLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
