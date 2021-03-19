//
//  SelectionColViewSectionHeader.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 12/01/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class SelectionColViewSectionHeader: UICollectionReusableView {
    
    //MARK:- Properties
    static let reuseId = "selectionColViewSectionHeaderId"
    let containerStack = BaseStack(axis: .vertical, spacing: 5)
    let sectionImageView = IconImageView(tintColor: ThemeColor.richBlack)
    let gradientView = GradientView(gradientColors: nil, gradientDirection: .vertical, colorLocations: [0.2, 0.4, 0.6, 0.8, 1.0])
    
    
    //MARK:- Prepare For Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        gradientView.removeColors()
        backgroundColor = nil
        sectionImageView.image = nil
    }
    
    
    //MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 6
        clipsToBounds = true
        
        constrainGradientView()
        constrainSectionImageView()
    }
    
    
    //MARK:- Configure Section Header
    func configureSectionHeader(sortingBy: CreateTCView.SortBy, sectionIndex: Int, costValues: [Cost]) {
        switch sortingBy {
        case .name:
            backgroundColor = nil
            sectionImageView.image = nil
            
        case .cost:
            configureCostHeader(costValues[sectionIndex])
            
        case .tier:
            if let tier = TierRating(rawValue: sectionIndex + 1) {
                configureTierHeader(tier)
            }
        }
    }
    
    
    //MARK: Configure Cost Header
    private func configureCostHeader(_ cost: Cost) {
        switch cost {
        case .one:
            backgroundColor = UIColor(cgColor: ChampCostColor.one)
            sectionImageView.image = SFSymbol.CostIcon.oneCost
        case .two:
            backgroundColor = UIColor(cgColor: ChampCostColor.two)
            sectionImageView.image = SFSymbol.CostIcon.twoCost
        case .three:
            backgroundColor = UIColor(cgColor: ChampCostColor.three)
            sectionImageView.image = SFSymbol.CostIcon.threeCost
        case .four:
            backgroundColor = UIColor(cgColor: ChampCostColor.four)
            sectionImageView.image = SFSymbol.CostIcon.fourCost
        case .five:
            backgroundColor = UIColor(cgColor: ChampCostColor.five)
            sectionImageView.image = SFSymbol.CostIcon.fiveCost
        case .six:
            backgroundColor = UIColor(cgColor: ChampCostColor.five)
            sectionImageView.image = SFSymbol.CostIcon.sixCost
        case .seven:
            gradientView.updateColors(newColors: ChampCostRainbowColor.rainbow)
            sectionImageView.image = SFSymbol.CostIcon.sevenCost
        }
    }
    
    
    //MARK: Configure Tier Header
    private func configureTierHeader(_ tier: TierRating) {
        switch tier {
        case .sTier:
            backgroundColor = TierRatingColor.sTier
            sectionImageView.image = SFSymbol.TierIcon.sTier
        case .aTier:
            backgroundColor = TierRatingColor.aTier
            sectionImageView.image = SFSymbol.TierIcon.aTier
        case .bTier:
            backgroundColor = TierRatingColor.bTier
            sectionImageView.image = SFSymbol.TierIcon.bTier
        case .cTier:
            backgroundColor = TierRatingColor.cTier
            sectionImageView.image = SFSymbol.TierIcon.cTier
        case .dTier:
            backgroundColor = TierRatingColor.dTier
            sectionImageView.image = SFSymbol.TierIcon.dTier
        default:
            backgroundColor = TierRatingColor.untiered
            sectionImageView.image = SFSymbol.TierIcon.untiered
        }
    }
    
    
    //MARK: Constrain Gradient View
    fileprivate func constrainGradientView() {
        addSubview(gradientView)
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    //MARK: Constrain Section Image View
    fileprivate func constrainSectionImageView() {
        gradientView.addSubview(sectionImageView)
        NSLayoutConstraint.activate([
            sectionImageView.centerXAnchor.constraint(equalTo: gradientView.centerXAnchor),
            sectionImageView.topAnchor.constraint(equalTo: gradientView.topAnchor, constant: 15)
        ])
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
