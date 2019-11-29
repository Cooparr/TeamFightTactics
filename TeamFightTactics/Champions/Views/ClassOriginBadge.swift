//
//  ClassOriginBadge.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 29/11/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class ClassOriginBadge: UIView {

    let typeLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return lbl
    }()
    
    let typeIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.tintColor = CustomColor.platinum
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = CustomColor.romanSilver
        layer.cornerRadius = 2.0
        
        addSubview(typeIcon)
        addSubview(typeLabel)
        
        NSLayoutConstraint.activate([
          typeIcon.heightAnchor.constraint(equalToConstant: 17),
            typeIcon.widthAnchor.constraint(equalToConstant: 15),
            typeIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            typeIcon.topAnchor.constraint(equalTo: topAnchor),
            typeIcon.trailingAnchor.constraint(equalTo: typeLabel.leadingAnchor),
            typeIcon.bottomAnchor.constraint(equalTo: bottomAnchor),
            typeLabel.leadingAnchor.constraint(equalTo: typeIcon.trailingAnchor),
            typeLabel.topAnchor.constraint(equalTo: topAnchor),
            typeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            typeLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
