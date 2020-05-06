//
//  ChampStat.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 10/12/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class ChampStat: UIView {
    
    var iconColor: UIColor?
    var iconImage: UIImage?
    
    init(image: UIImage?, iconColor: UIColor) {
        super.init(frame: .zero)
        
        self.iconColor = iconColor
        self.iconImage = image
        translatesAutoresizingMaskIntoConstraints = false
        setupSubviewsAndConstraints()
    }
    
    let statLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = ThemeColor.platinum
        lbl.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return lbl
    }()
    
    lazy var statIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.tintColor = iconColor
        imgView.image = iconImage
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    func setupSubviewsAndConstraints() {
        addSubview(statLabel)
        addSubview(statIcon)
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 55),
            heightAnchor.constraint(equalToConstant: 15),

            statIcon.heightAnchor.constraint(equalToConstant: 15),
            statIcon.widthAnchor.constraint(equalToConstant: 15),
            
            statLabel.leadingAnchor.constraint(equalTo: statIcon.trailingAnchor, constant: 4),
            statLabel.topAnchor.constraint(equalTo: statIcon.topAnchor),
            statLabel.bottomAnchor.constraint(equalTo: statIcon.bottomAnchor),
            statLabel.widthAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
