//
//  GradientView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 19/10/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class GradientView: UIView {

    //MARK: Gradient Direction Enum
    enum GradientDirection {
        case topLeftToBottomRight
        case horizontal
        case vertical
    }


    //MARK: Properties
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }


    //MARK: Init
    init(frame: CGRect = .zero, gradientColors: [CGColor]? = nil, gradientDirection: GradientDirection, colorLocations: [NSNumber]? = nil) {
        super.init(frame: frame)
        autoresizingMask = [.flexibleWidth, .flexibleHeight]

        guard let layer = self.layer as? CAGradientLayer else { return }
        (layer.startPoint, layer.endPoint) = gradientDirection.setGradientStartAndEndPoints()
        layer.colors = gradientColors
        layer.locations = colorLocations
        layer.frame = self.bounds
    }

    
    //MARK: Update Colors
    func updateColors(newColors: [CGColor]) {
        guard let layer = self.layer as? CAGradientLayer else { return }
        layer.colors = newColors
    }

    
    //MARK: Remove Colors
    func removeColors() {
        guard let layer = self.layer as? CAGradientLayer else { return }
        layer.colors = nil
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




extension GradientView.GradientDirection {
    
    //MARK: Set Gradient Start & End Points
    fileprivate func setGradientStartAndEndPoints() -> (CGPoint, CGPoint) {
        switch self {
        case .topLeftToBottomRight:
            return (CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 1))
        case .horizontal:
            return (CGPoint(x: 0, y: 0.5), CGPoint(x: 1, y: 0.5))
        case .vertical:
            return (CGPoint(x: 0.5, y: 0), CGPoint(x: 0.5, y: 1))
        }
    }
}
