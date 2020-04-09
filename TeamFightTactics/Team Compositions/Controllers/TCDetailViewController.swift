//
//  TCDetailViewController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 11/12/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit
import SDWebImage

class TCDetailViewController: UIViewController {
    
    //MARK:- Properties
    lazy private var detailRootView: TCDetailView = TCDetailView()
    
    var teamComp: TeamComposition? {
        didSet {
            guard
                let tier: TierRating = teamComp?.tier,
                let earlyGame = teamComp?.earlyGame,
                let midGame = teamComp?.midGame,
                let endGame = teamComp?.endGame,
                let allChampObjs = teamComp?.allChampObjs
                else { return }
            if allChampObjs.isEmpty { return }
            
            setTierLabel(tier)
            newSetImages(earlyGame, detailRootView.earlyGameSection.earlyGameStack, allChampObjs)
            newSetImages(midGame, detailRootView.midGameSection.midGameStack, allChampObjs)
            setImages(for: endGame, in: detailRootView.endGameSection.endGameChamps, allChampObjs)
            setBoardPosition(for: endGame, championObjs: allChampObjs)
        }
    }

    //MARK:- Load View
    override func loadView() {
        super.loadView()
        self.view = self.detailRootView
    }
    
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetup()
    }
    
    //MARK: Navigation Bar Code
    fileprivate func navigationBarSetup() {
        navigationItem.title = teamComp?.title
    }
    
    
    //MARK: Set Tier Label And Color
    fileprivate func setTierLabel(_ tier: TierRating) {
        tier.setTierTextAndColor(for: detailRootView.earlyGameSection.teamCompTier)
    }
    
    //MARK:- Set Champ Images
    fileprivate func setImages(for champions: [Any], in imgViewArray: [TCDetailChampImage], _ champObjs: [Champion]) {
            for (index, champ) in champions.enumerated() {
                var champName: String
                if champ is TeamCompositionEndGameChamps {
                    guard let champ = champ as? TeamCompositionEndGameChamps else { return }
                    champName = champ.name
                } else {
                    guard let champ = champ as? String else { return }
                    champName = champ
                }
                
                
                for champ in champObjs where champ.name == champName {
                    imgViewArray[index].useStandardOrSetSkin(champ.imgURL, champ.key)
                    imgViewArray[index].isHidden = false
                }
                
            }
        }
    
    fileprivate func newSetImages(_ champions: [Any],_ stackView: UIStackView, _ champObjs: [Champion]) {
        for champ in champions {
            var champName: String
            if champ is TeamCompositionEndGameChamps {
                guard let champ = champ as? TeamCompositionEndGameChamps else { return }
                champName = champ.name
            } else {
                guard let champ = champ as? String else { return }
                champName = champ
            }
            
            
            for champ in champObjs where champ.name == champName {
                let champImg = TCDetailChampImage()
                champImg.useStandardOrSetSkin(champ.imgURL, champ.key)
                champImg.isHidden = false
                stackView.addArrangedSubview(champImg)
            }
        }
    }
    
    
    
    //MARK:- Set Champ Board Position
    fileprivate func setBoardPosition(for endGameChamps: [TeamCompositionEndGameChamps], championObjs: [Champion]) {
        for champ in endGameChamps {
            let slotPosition = champ.position - 1
            for champObj in championObjs where champObj.name == champ.name {
                detailRootView.boardSection.boardSlots[slotPosition].useStandardOrSetSkin(champObj.imgURL, champObj.key)
            }
        }
    }
    
    
    //MARK:- Deinit
    deinit {
        print("TCDetail View Controller: 👋")
    }
}
