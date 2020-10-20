//
//  TCEarlyAndMidGameViewController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 05/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCEarlyAndMidGameViewController: UIViewController {
    
    lazy private var earlyMidGameView = TCEarlyAndMidGameView(backgroundColor: ThemeColor.richBlack)
    weak var delegate: CreateChampImage?
   
    //MARK: Properties
    let tier: TierRating
    let earlyChamps: [String]
    let midChamps: [String]
    let champObjs: [Champion]
    
    
    //MARK:- Init
    init(_ tier: TierRating, _ earlyChamps: [String], _ midChamps: [String], _ champObjs: [Champion]) {
        self.tier = tier
        self.earlyChamps = earlyChamps
        self.midChamps = midChamps
        self.champObjs = champObjs
        super.init(nibName: nil, bundle: nil)
    }
    
    
    //MARK:- Load View
    override func loadView() {
        super.loadView()
        self.view = self.earlyMidGameView
    }
    
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTierLabel(tier)
        setEarlyMidImages(earlyChamps, earlyMidGameView.earlyGameStack, champObjs)
        setEarlyMidImages(midChamps, earlyMidGameView.midGameStack, champObjs)
    }
    
    
    //MARK: Set Tier Label And Color
    fileprivate func setTierLabel(_ tier: TierRating) {
        tier.setTierTextAndColor(for: earlyMidGameView.teamCompTier)
    }
    
    
    //MARK:- Set Early & Mid Champ Images
    fileprivate func setEarlyMidImages(_ champions: [String], _ stackView: UIStackView, _ champObjs: [Champion]) {
        for champ in champions {
            for champObj in champObjs where champObj.name == champ {
                if let champImg = delegate?.createChampImage(champObj, imageSize: 35, borderWidth: 1.0) {
                    stackView.addArrangedSubview(champImg)
                }
            }
        }
        
        if stackView.arrangedSubviews.isEmpty {
            if let stackContainer = stackView.superview?.superview {
                stackContainer.isHidden = true
            }
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
