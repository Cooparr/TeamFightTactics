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
    
    
    //MARK:- Prepare For Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundColor = nil
        sectionImageView.image = nil
    }
    
    
    //MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 6
        clipsToBounds = true
                
        addSubview(sectionImageView)
        NSLayoutConstraint.activate([
            sectionImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            sectionImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15)
        ])
    }
    
    
    //MARK:- Configure Section Header
    func configureSectionHeader(sortingBy: CreateTeamCompView.SortBy, sectionIndex: Int) {
        switch sortingBy {
        case .name:
            backgroundColor = nil
            sectionImageView.image = nil
            
        case .cost:
            if let cost = Cost(rawValue: sectionIndex + 1) {
                configureCostHeader(cost)
            }
            
        case .tier:
            if let tier = TierRating(rawValue: sectionIndex) {
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
            #warning("This needs addressing, should be rainbow?")
            backgroundColor = .red
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
            backgroundColor = TierRatingColor.eTier
            sectionImageView.image = SFSymbol.TierIcon.eTier
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
