//
//  ButtonExtension.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 03/03/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit


//MARK:- UIButton Extension
extension UIButton {
    
    //MARK: Shake Animation
    func shakeAnimation() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let from = CGPoint(x: center.x - 5, y: center.y)
        let to = CGPoint(x: center.x + 5, y: center.y)
        
        shake.fromValue = NSValue(cgPoint: from)
        shake.toValue = NSValue(cgPoint: to)
        
        layer.add(shake, forKey: nil)
    }

    //MARK: Pulse Animation On Tap
    func pulseAnimateOnTap() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.25
        pulse.repeatCount = 1
        pulse.autoreverses = true
        pulse.fromValue = 1
        pulse.toValue = 1.05
        pulse.initialVelocity = 0.5
        pulse.damping = 1
        
        layer.add(pulse, forKey: nil)
    }

}
