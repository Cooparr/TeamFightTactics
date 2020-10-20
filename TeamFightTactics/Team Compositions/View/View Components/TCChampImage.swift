//
//  TCChampImage.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 31/10/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCChampImage: UIImageView {

    var champion: Champion?
    
    //MARK:- Override Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
        clipsToBounds = true
        layer.cornerRadius = 2.0
        layer.borderColor = ThemeColor.romanSilver.cgColor
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
    }
    
    
    //MARK:- Convinence Init
    convenience init(imageSize: CGFloat, borderWidth: CGFloat, tappable: Bool = true) {
        self.init(frame: CGRect(x: 0, y: 0, width: imageSize, height: imageSize))
        self.layer.borderWidth = borderWidth
        self.isUserInteractionEnabled = tappable
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: imageSize),
            self.heightAnchor.constraint(equalToConstant: imageSize)
        ])
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer)  {
        let champPopUp = ChampionPopUpView(tamic: false)
        if let tabBar = self.window?.rootViewController as? TabBarController {
            tabBar.view.addSubview(champPopUp)
            champPopUp.pinSubview(to: tabBar.view)
            champPopUp.configurePopUp(champion: champion)

            champPopUp.centerYConstraint?.constant = 500.0
            champPopUp.layoutIfNeeded()

            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                champPopUp.blurEffectView.effect = UIBlurEffect(style: .systemThinMaterialDark)
                champPopUp.centerYConstraint?.constant = 0
                champPopUp.layoutIfNeeded()
            })
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
