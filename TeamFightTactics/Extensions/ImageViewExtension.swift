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
    
    //MARK; Setup Hexagon Mask
    func setupHexagonMask(lineWidth: CGFloat, color: UIColor, cornerRadius: CGFloat) {
        let path: CGPath = UIBezierPath(roundedPolygonPathInRect: bounds, lineWidth: lineWidth, sides: 6, cornerRadius: cornerRadius, rotationOffset: CGFloat.pi / 2.0).cgPath

        let mask: CAShapeLayer = CAShapeLayer()
        mask.path = path
        mask.lineWidth = lineWidth
        mask.strokeColor = UIColor.clear.cgColor
        mask.fillColor = UIColor.white.cgColor
        layer.mask = mask

        let border: CAShapeLayer = CAShapeLayer()
        border.path = path
        border.lineWidth = lineWidth
        border.strokeColor = color.cgColor
        border.fillColor = UIColor.clear.cgColor
        layer.addSublayer(border)
    }
    
    //MARK: Use Skin Image or Standard
    func useStandardOrSetSkin(_ skinURL: String, _ nonSkinKey: String) {
        let useSkins = UserDefaults.standard.bool(forKey: UDKey.skinsKey)
        
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
