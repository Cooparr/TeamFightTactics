//
//  StatView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 18/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit


class StatView: BaseView {
    
    //MARK:- Properties
    let statLabel = BaseLabel()
    let iconSize: CGFloat
    let statIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    
    //MARK:- Required Init
    required init(statWidth: CGFloat, iconSize: CGFloat, fontSize: CGFloat, fontWeight: UIFont.Weight) {
        self.iconSize = iconSize
        self.statLabel.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: statWidth).isActive = true
    }
       
    
    //MARK:- Setup View
    override func setupView() {
        addSubview(statIcon)
        NSLayoutConstraint.activate([
            statIcon.heightAnchor.constraint(equalToConstant: iconSize),
            statIcon.widthAnchor.constraint(equalToConstant: iconSize),
            statIcon.topAnchor.constraint(equalTo: topAnchor),
            statIcon.leadingAnchor.constraint(equalTo: leadingAnchor),
            statIcon.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        addSubview(statLabel)
        NSLayoutConstraint.activate([
            statLabel.topAnchor.constraint(equalTo: statIcon.topAnchor),
            statLabel.leadingAnchor.constraint(equalTo: statIcon.trailingAnchor, constant: 4),
            statLabel.bottomAnchor.constraint(equalTo: statIcon.bottomAnchor),
            statLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
