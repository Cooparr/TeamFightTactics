//
//  TraitCountView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 23/03/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class CircularTraitCountView: GradientView {
    
    //MARK: Properties
    private let traitCountLbl = BaseLabel(fontSize: 14, fontWeight: .regular, textAlignment: .center)
    
    
    //MARK: Init
    init(size: CGFloat) {
        super.init(gradientDirection: .horizontal)
        setupView(size)
        setupSubviews(size)
    }
    
    
    //MARK: Setup View
    fileprivate func setupView(_ size: CGFloat) {
        layer.cornerRadius = size / 2
        layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: size),
            heightAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
    
    //MARK: Setup Subviews
    func setupSubviews(_ size: CGFloat) {
        addSubviews(traitCountLbl)
        traitCountLbl.makeCircular(size: size - 3)
        traitCountLbl.backgroundColor = ThemeColor.richBlack
        NSLayoutConstraint.activate([
            traitCountLbl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            traitCountLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    
    //MARK: Update Trait View
    func updateTraitCountView(with traitRank: SynergyRank, and bonusCount: Int, isChosen: Bool? = nil) {
        traitCountLbl.text = "\(bonusCount)"
        updateGradientColors(for: traitRank, isChosen)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
