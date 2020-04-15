//
//  BezierPathExtension.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 15/04/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit


//MARK:- UIBezierPath Extension
extension UIBezierPath {
    
    //MARK: Conv Init - Rounded PolygonPath
    convenience init(roundedPolygonPathInRect rect: CGRect, lineWidth: CGFloat, sides: NSInteger, cornerRadius: CGFloat = 0, rotationOffset: CGFloat = 0) {
        self.init()

        let theta: CGFloat = 2.0 * CGFloat.pi / CGFloat(sides)
        let width: CGFloat = min(rect.size.width, rect.size.height)
        let center: CGPoint = CGPoint(x: rect.origin.x + width / 2.0, y: rect.origin.y + width / 2.0)
        let radius: CGFloat = (width - lineWidth + cornerRadius - (cos(theta) * cornerRadius)) / 2.0
        var angle: CGFloat = CGFloat(rotationOffset)

        let corner: CGPoint = CGPoint(x: center.x + (radius - cornerRadius) * cos(angle), y: center.y + (radius - cornerRadius) * sin(angle))
        move(to: CGPoint(x: corner.x + cornerRadius * cos(angle + theta), y: corner.y + cornerRadius * sin(angle + theta)))

        for _ in 0 ..< sides {
            angle += theta

            let corner: CGPoint  = CGPoint(x: center.x + (radius - cornerRadius) * cos(angle), y: center.y + (radius - cornerRadius) * sin(angle))
            let tip: CGPoint  = CGPoint(x: center.x + radius * cos(angle), y: center.y + radius * sin(angle))
            let start: CGPoint  = CGPoint(x: corner.x + cornerRadius * cos(angle - theta), y: corner.y + cornerRadius * sin(angle - theta))
            let end: CGPoint  = CGPoint(x: corner.x + cornerRadius * cos(angle + theta), y: corner.y + cornerRadius * sin(angle + theta))

            addLine(to: start)
            addQuadCurve(to: end, controlPoint: tip)
        }

        close()
    }
}
