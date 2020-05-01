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
    let traitsSection = TCTraitsViewController()
    
    var teamComp: TeamComposition? {
        didSet {
            guard
                let tier: TierRating = teamComp?.tier,
                let earlyGame = teamComp?.earlyGame,
                let midGame = teamComp?.midGame,
                let endGame = teamComp?.endGame,
                let synergies = teamComp?.synergies,
                let allChampObjs = teamComp?.allChampObjs,
                let classObjs = teamComp?.classObjs,
                let originObjs = teamComp?.originObjs
                else { return }
            if allChampObjs.isEmpty || classObjs.isEmpty || originObjs.isEmpty { return }
            
            
            traitsSection.classObjs = classObjs
            traitsSection.originObjs = originObjs
            traitsSection.synergies = synergies
            
            
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
        setupTraitsSectionVC()
    }
    
    
    //MARK:- Navigation Bar Code
    fileprivate func navigationBarSetup() {
        navigationItem.title = teamComp?.title
    }
    
    
    //MARK:- Setup Traits Section VC
    fileprivate func setupTraitsSectionVC() {
        addChild(traitsSection)
        detailRootView.scrollViewContainer.addArrangedSubview(traitsSection.view)
        traitsSection.didMove(toParent: self)
    }
    
    
    //MARK: Set Tier Label And Color
    fileprivate func setTierLabel(_ tier: TierRating) {
        tier.setTierTextAndColor(for: detailRootView.earlyAndMidGameSection.teamCompTier)
    }
    
    //MARK:- Set Early & Mid Champ Images
    fileprivate func setEarlyMidImages(_ champions: [String], _ stackView: UIStackView, _ champObjs: [Champion]) {
        for champ in champions {
            for champObj in champObjs where champObj.name == champ {
                let champImg = createChampImage(champObj, imageSize: 35, borderWidth: 1.0)
                stackView.addArrangedSubview(champImg)
            }
        }
    }
    
    
    //MARK: Set End Champ Images
    fileprivate func setEndGameImages(_ endGameChamps: [TeamCompositionEndGameChamps], _ topStack: UIStackView, _ botStack: UIStackView, champObjs: [Champion]) {
        for (index, champ) in endGameChamps.enumerated() {
            for champObj in champObjs where champObj.name == champ.name {
                let champImg = createChampImage(champObj, imageSize: 60, borderWidth: 2.0)
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
    fileprivate func createChampImage(_ champObj: Champion, imageSize: CGFloat, borderWidth: CGFloat) -> TCDetailChampImage {
        let image = TCDetailChampImage(width: imageSize, height: imageSize, borderWidth: borderWidth)
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
