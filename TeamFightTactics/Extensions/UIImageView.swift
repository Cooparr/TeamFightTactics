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
    
    //MARK:- Setup Blank Hexagon Mask
    func setupBlankHexagonMask(lineWidth: CGFloat, color: UIColor, cornerRadius: CGFloat) {
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
    
    
    //MARK:- Setup Coloured Hexagon Mask
    func setupColouredHexagonMask(for boardSlotLayer: CALayer, with champ: Champion?, lineWidth: CGFloat = 2.0, cornerRadius: CGFloat = 1.0) {
        boardSlotLayer.sublayers?.removeAll()
        let path: CGPath = UIBezierPath(roundedPolygonPathInRect: bounds, lineWidth: lineWidth, sides: 6, cornerRadius: cornerRadius, rotationOffset: CGFloat.pi / 2.0).cgPath
        
        let mask: CAShapeLayer = CAShapeLayer()
        mask.path = path
        mask.lineWidth = lineWidth
        mask.strokeColor = UIColor.black.cgColor
        mask.fillColor = UIColor.clear.cgColor
        
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: boardSlotLayer.frame.size)
        gradient.cornerRadius = 2.0
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)

        
        switch champ?.cost {
        case .one:
            gradient.colors = [ChampCostColor.one, ChampCostColor.one]
        case .two:
            gradient.colors = [ChampCostColor.two, ChampCostColor.two]
        case .three:
            gradient.colors = [ChampCostColor.three, ChampCostColor.three]
        case .four:
            gradient.colors = [ChampCostColor.four, ChampCostColor.four]
        case .five:
            gradient.colors = [ChampCostColor.five, ChampCostColor.five]
        case .six, .seven:
            gradient.colors = ChampCostRainbowColor.rainbow
        default:
            gradient.colors = [ThemeColor.romanSilver, ThemeColor.romanSilver]
        }
        
        gradient.mask = mask
        layer.addSublayer(gradient)
    }
    
    
    //MARK:- Set Champ Cost Border Color
    func setChampCostBorderColor(champCost: Cost, rainbowLineWidth: CGFloat = 4) {
        self.layer.borderWidth = champCost > .five ? 0 : 2
        
        switch champCost {
        case .one:
            self.layer.borderColor = ChampCostColor.one
        case .two:
            self.layer.borderColor = ChampCostColor.two
        case .three:
            self.layer.borderColor = ChampCostColor.three
        case .four:
            self.layer.borderColor = ChampCostColor.four
        case .five:
            self.layer.borderColor = ChampCostColor.five
        case .six, .seven:
            self.layer.sublayers?.removeAll()
            let gradient = CAGradientLayer()
            gradient.frame =  CGRect(origin: CGPoint.zero, size: self.frame.size)
            gradient.cornerRadius = 2.0
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 1, y: 1)
            gradient.colors = ChampCostRainbowColor.rainbow
            
            let shape = CAShapeLayer()
            shape.path = UIBezierPath(rect: self.layer.bounds).cgPath
            shape.lineWidth = rainbowLineWidth
            shape.strokeColor = UIColor.black.cgColor
            shape.fillColor = UIColor.clear.cgColor
            
            gradient.mask = shape
            self.layer.addSublayer(gradient)
        }
    }
    
    
    //MARK:- Use Skin Image or Standard
    func useStandardOrSetSkin(_ skinURL: String, _ nonSkinKey: String) {
        switch SettingsManager.shouldUseSetSkins() {
        case true:
            self.sd_setImage(with: URL(string: skinURL), placeholderImage: PlaceholderImage.champ)
        case false:
            self.image = UIImage(named: nonSkinKey)
        }
    }
}
