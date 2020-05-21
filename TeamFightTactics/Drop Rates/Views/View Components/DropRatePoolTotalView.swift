//
//  DropRatePoolTotalView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 20/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class DropRatePoolTotalView: UIView {
    
    //MARK:- Properties
    let champTierLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.makeCircular(size: 33)
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        lbl.textColor = ThemeColor.platinum
        return lbl
    }()
    
    let poolTotalLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 22, weight: .light)
        lbl.textAlignment = .center
        lbl.textColor = ThemeColor.platinum
        return lbl
    }()
    
    
    //MARK:- Override Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        
        let padding: CGFloat = 10
        setupChampTierLabel(padding)
        setupPoolValueLabel(padding)
    }
    
    
    //MARK:- Setup View
    fileprivate func setupView() {
        backgroundColor = ThemeColor.charcoal
        layer.cornerRadius = 6
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
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
