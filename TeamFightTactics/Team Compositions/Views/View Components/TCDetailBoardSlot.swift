//
//  TCDetailBoardSlot.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 12/12/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCDetailBoardSlot: UIImageView {
    
    //MARK:- Override Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentMode = .scaleAspectFill
        backgroundColor = CustomColor.charcoal
        setupHexagonMask(lineWidth: 1.0, color: .white, cornerRadius: 1)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 50),
            widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    //MARK:- Convinence Init
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK:- UIBezierPath Extension
extension UIBezierPath {
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


//MARK:- UIImageView Extension
extension UIImageView {
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
}
