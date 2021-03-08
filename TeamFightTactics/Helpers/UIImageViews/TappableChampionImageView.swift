//
//  TappableChampionImageView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 20/01/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class TappableChampionImageView: ChampionImageView {
    
    //MARK:- Properties
    let champion: Champion
    
    
    //MARK:- Init
    init(withChamp: Champion, imageSize: CGFloat) {
        self.champion = withChamp
        super.init(imageSize: imageSize)

        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
    }
    
    
    //MARK:- Image Tapped Action
    @objc func imageTapped(_ sender: UITapGestureRecognizer)  {
        let champPopUp = ChampionPopUpView(champion: champion)
        
        guard let tabBar = self.window?.rootViewController as? TabBarController else { return }
        tabBar.view.addSubview(champPopUp)
        champPopUp.pinSubview(to: tabBar.view)
        champPopUp.centerYConstraint?.constant = 500.0
        champPopUp.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            champPopUp.blurEffectView.effect = UIBlurEffect(style: .systemThinMaterialDark)
            champPopUp.centerYConstraint?.constant = 0
            champPopUp.layoutIfNeeded()
        })
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
