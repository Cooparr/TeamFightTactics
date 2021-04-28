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
    init(gradientDirection: GradientDirection) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        autoresizingMask = [.flexibleWidth, .flexibleHeight]

        guard let layer = self.layer as? CAGradientLayer else { return }
        (layer.startPoint, layer.endPoint) = gradientDirection.setGradientStartAndEndPoints()
        layer.frame = self.bounds
    }
    
    
    //MARK: Convenience Init
    convenience init(frame: CGRect = .zero, gradientColors: [CGColor]? = nil, gradientDirection: GradientDirection, colorLocations: [NSNumber]? = nil) {
        self.init(gradientDirection: gradientDirection)
        guard let layer = self.layer as? CAGradientLayer else { return }
        layer.colors = gradientColors
        layer.locations = colorLocations
    }

    
    //MARK: Set Colors
    private func setGradientColors(_ newColors: [CGColor]) {
        guard let layer = self.layer as? CAGradientLayer else { return }
        layer.colors = newColors
    }
    
    
    //MARK: Update Colors For Cost
    func updateGradientColors(for tier: TierRating) {
        switch tier {
        case .sTier:
            setGradientColors([TierRatingColor.sTier.cgColor, TierRatingColor.sTier.cgColor])
        case .aTier:
            setGradientColors([TierRatingColor.aTier.cgColor, TierRatingColor.aTier.cgColor])
        case .bTier:
            setGradientColors([TierRatingColor.bTier.cgColor, TierRatingColor.bTier.cgColor])
        case .cTier:
            setGradientColors([TierRatingColor.cTier.cgColor, TierRatingColor.cTier.cgColor])
        case .dTier:
            setGradientColors([TierRatingColor.dTier.cgColor, TierRatingColor.dTier.cgColor])
        case .noTier:
            setGradientColors([TierRatingColor.noTier.cgColor, TierRatingColor.noTier.cgColor])
        }
    }
    
    
    //MARK: Update Colors For Cost
    func updateGradientColors(for cost: Cost) {
        switch cost {
        case .one:
            setGradientColors([ChampCostColor.one, ChampCostColor.one])
        case .two:
            setGradientColors([ChampCostColor.two, ChampCostColor.two])
        case .three:
            setGradientColors([ChampCostColor.three, ChampCostColor.three])
        case .four:
            setGradientColors([ChampCostColor.four, ChampCostColor.four])
        case .five, .six:
            setGradientColors([ChampCostColor.five, ChampCostColor.five])
        case .seven:
            setGradientColors(ChampCostRainbowColor.rainbow)
        }
    }
    
    
    //MARK: Update Colors For Rank
    func updateGradientColors(for rank: SynergyRank, _ isChosen: Bool? = nil) {
        if isChosen == true { return setGradientColors([TraitRatingColor.chosen.cgColor, TraitRatingColor.chosen.cgColor]) }
        
        switch rank {
        case .unranked:
            setGradientColors([TraitRatingColor.unranked.cgColor, TraitRatingColor.unranked.cgColor])
        case .bronze:
            setGradientColors([TraitRatingColor.bronze.cgColor, TraitRatingColor.bronze.cgColor])
        case .silver:
            setGradientColors([TraitRatingColor.silver.cgColor, TraitRatingColor.silver.cgColor])
        case .gold:
            setGradientColors([TraitRatingColor.gold.cgColor, TraitRatingColor.gold.cgColor])
        case .chromatic:
            setGradientColors(TraitRatingColor.rainbow)
        }
    }
    
    
    func getTintColor(for rank: SynergyRank, _ isChosen: Bool?) -> UIColor {
        if isChosen == true { return ThemeColor.platinum }
        
        switch rank {
        case .unranked, .bronze, .silver, .gold:
            return ThemeColor.platinum
        case .chromatic:
            return ThemeColor.charcoal
        }
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
