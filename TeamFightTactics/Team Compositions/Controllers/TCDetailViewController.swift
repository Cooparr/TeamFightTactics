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
            setEarlyMidImages(earlyGame, detailRootView.earlyAndMidGameSection.earlyGameStack, allChampObjs)
            setEarlyMidImages(midGame, detailRootView.earlyAndMidGameSection.midGameStack, allChampObjs)
            setEndGameImages(endGame, detailRootView.endGameSection.topStack, detailRootView.endGameSection.botStack, champObjs: allChampObjs)
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
        tier.setTierTextAndColor(for: detailRootView.earlyAndMidGameSection.teamCompTier)
    }
    
    //MARK:- Set Early & Mid Champ Images
    fileprivate func setEarlyMidImages(_ champions: [String], _ stackView: UIStackView, _ champObjs: [Champion]) {
        for champ in champions {
            for champObj in champObjs where champObj.name == champ {
                let champImg = createChampImage(champObj, imageSize: 35)
                stackView.addArrangedSubview(champImg)
            }
        }
    }
    
    
    //MARK: Set End Champ Images
    fileprivate func setEndGameImages(_ endGameChamps: [TeamCompositionEndGameChamps], _ topStack: UIStackView, _ botStack: UIStackView, champObjs: [Champion]) {
        for champ in endGameChamps {
            for (index, champObj) in champObjs.enumerated() where champObj.name == champ.name {
                let champImg = createChampImage(champObj, imageSize: 60)
                switch index {
                case ...3:
                    topStack.addArrangedSubview(champImg)
                default:
                    botStack.addArrangedSubview(champImg)
                }
            }
        }
    }
    
    
    //MARK: Create Champ Image
    fileprivate func createChampImage(_ champObj: Champion, imageSize: CGFloat) -> TCDetailChampImage {
        let image = TCDetailChampImage(width: imageSize, height: imageSize)
        image.useStandardOrSetSkin(champObj.imgURL, champObj.key)
        champObj.cost.setChampImageBorder(for: image)
        return image
    }
    
    //MARK:- Set Champ Board Position
    fileprivate func setBoardPosition(for endGameChamps: [TeamCompositionEndGameChamps], championObjs: [Champion]) {
        for champ in endGameChamps {
            let slotPosition = champ.position - 1
            let boardSlot = detailRootView.boardSection.boardSlots[slotPosition]
            for champObj in championObjs where champObj.name == champ.name {
                boardSlot.useStandardOrSetSkin(champObj.imgURL, champObj.key)
            }
        }
    }
    
    
    //MARK:- Deinit
    deinit {
        print("TCDetail View Controller: 👋")
    }
}
