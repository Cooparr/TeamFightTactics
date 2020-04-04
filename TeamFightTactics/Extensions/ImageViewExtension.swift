//
//  ImageViewExtension.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 04/04/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit


//MARK:- UIImageView Extension
extension UIImageView {
    
    //MARK: Use Skin Image or Standard
    func useStandardOrSetSkin(_ skinURL: String, _ nonSkinKey: String) {
        let useSkins = UserDefaults.standard.bool(forKey: Constants.skinsKey)
        
        switch useSkins {
        case true:
            let placeholder = UIImage(named: "placeholder")
            let champImgUrl = URL(string: skinURL)
            self.sd_setImage(with: champImgUrl, placeholderImage: placeholder)
        case false:
            self.image = UIImage(named: nonSkinKey)
        }
    }
}
