//
//  TeamCompSynergyBadge.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 01/11/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class TeamCompSynergyBadge: UIView {

    //MARK:- Override Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = CustomColor.silverSynergy
        layer.cornerRadius = 2.0
        
        setupSubviewsAndConstraints()
    }

    //MARK:- Properties
    let synergyIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.tintColor = CustomColor.platinum
        return imgView
    }()
    
    let synergyLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return lbl
    }()
    
    
    //MARK:- Setup Subviews & Constraints
    fileprivate func setupSubviewsAndConstraints() {
        addSubview(synergyIcon)
        addSubview(synergyLabel)
        
        synergyIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        synergyIcon.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        synergyIcon.topAnchor.constraint(equalTo: topAnchor).isActive = true
        synergyIcon.trailingAnchor.constraint(equalTo: synergyLabel.leadingAnchor).isActive = true
        synergyIcon.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        synergyLabel.leadingAnchor.constraint(equalTo: synergyIcon.trailingAnchor).isActive = true
        synergyLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        synergyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6).isActive = true
        synergyLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
