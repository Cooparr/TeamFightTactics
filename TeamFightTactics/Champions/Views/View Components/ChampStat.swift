//
//  ChampStat.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 10/12/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class ChampStat: BaseView {

    //MARK:- Properties
    let statLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = ThemeColor.platinum
        lbl.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return lbl
    }()

    let statIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()


    //MARK:- Convenience Init
    convenience init(image: UIImage?, iconColor: UIColor) {
        self.init(frame: .zero)
        self.statIcon.image = image
        self.statIcon.tintColor = iconColor
    }


    //MARK:- Setup View
    override func setupView() {
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 55),
            heightAnchor.constraint(equalToConstant: 15)
        ])
    }


    //MARK:- Setup Subviews
    override func setupSubviews() {
        addSubview(statIcon)
        NSLayoutConstraint.activate([
            statIcon.heightAnchor.constraint(equalToConstant: 15),
            statIcon.widthAnchor.constraint(equalToConstant: 15)
        ])
        
        addSubview(statLabel)
        NSLayoutConstraint.activate([
            statLabel.leadingAnchor.constraint(equalTo: statIcon.trailingAnchor, constant: 4),
            statLabel.topAnchor.constraint(equalTo: statIcon.topAnchor),
            statLabel.bottomAnchor.constraint(equalTo: statIcon.bottomAnchor),
            statLabel.widthAnchor.constraint(equalToConstant: 36)
        ])
    }
}
