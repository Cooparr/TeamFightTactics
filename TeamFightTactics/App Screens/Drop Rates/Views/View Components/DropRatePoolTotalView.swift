//
//  DropRatePoolTotalView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 20/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class DropRatePoolTotalView: BaseView {
    
    //MARK:- Properties
    let champTierLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.makeCircular(size: 33)
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        lbl.textColor = ThemeColor.platinum
        return lbl
    }()
    
    let poolTotalLabel: BaseLabel = {
        let lbl = BaseLabel(fontSize: 22, fontWeight: .light)
        lbl.textAlignment = .center
        return lbl
    }()
    
    
    //MARK: Setup Subviews
    override func setupSubviews() {
        let padding: CGFloat = 10
        setupChampTierLabel(padding)
        setupPoolValueLabel(padding)
    }
    
    
    //MARK:- Setup Champ Tier Label
    fileprivate func setupChampTierLabel(_ padding: CGFloat) {
        addSubview(champTierLabel)
        NSLayoutConstraint.activate([
            champTierLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            champTierLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            champTierLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            champTierLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
    }
    
    
    //MARK:- Setup Pool Value Label
    fileprivate func setupPoolValueLabel(_ padding: CGFloat) {
        addSubview(poolTotalLabel)
        NSLayoutConstraint.activate([
            poolTotalLabel.topAnchor.constraint(equalTo: champTierLabel.bottomAnchor, constant: padding),
            poolTotalLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            poolTotalLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            poolTotalLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
    }
}
