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
    private let sectionImageView = IconImageView(tintColor: ThemeColor.richBlack)
    private let gradientView = GradientView(gradientDirection: .vertical)
    
    
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
            sectionImageView.image = nil
            
        case .cost:
            configureCostHeader(costValues[sectionIndex])
            
        case .tier:
            guard let tier = TierRating(rawValue: sectionIndex + 1) else { return }
            configureTierHeader(tier)
        }
    }
    
    
    //MARK: Configure Cost Header
    private func configureCostHeader(_ cost: Cost) {
        gradientView.updateGradientColors(for: cost)
        
        switch cost {
        case .one:
            sectionImageView.image = SFSymbol.CostIcon.oneCost
        case .two:
            sectionImageView.image = SFSymbol.CostIcon.twoCost
        case .three:
            sectionImageView.image = SFSymbol.CostIcon.threeCost
        case .four:
            sectionImageView.image = SFSymbol.CostIcon.fourCost
        case .five:
            sectionImageView.image = SFSymbol.CostIcon.fiveCost
        case .six:
            sectionImageView.image = SFSymbol.CostIcon.sixCost
        case .seven:
            sectionImageView.image = SFSymbol.CostIcon.sevenCost
        }
    }
    
    
    //MARK: Configure Tier Header
    private func configureTierHeader(_ tier: TierRating) {
        gradientView.updateGradientColors(for: tier)
        
        switch tier {
        case .sTier:
            sectionImageView.image = SFSymbol.TierIcon.sTier
        case .aTier:
            sectionImageView.image = SFSymbol.TierIcon.aTier
        case .bTier:
            sectionImageView.image = SFSymbol.TierIcon.bTier
        case .cTier:
            sectionImageView.image = SFSymbol.TierIcon.cTier
        case .dTier:
            sectionImageView.image = SFSymbol.TierIcon.dTier
        default:
            sectionImageView.image = SFSymbol.TierIcon.notier
        }
    }
    
    
    //MARK: Constrain Gradient View
    private func constrainGradientView() {
        addSubview(gradientView)
        gradientView.pinSubview(to: self)
    }
    
    
    //MARK: Constrain Section Image View
    private func constrainSectionImageView() {
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
