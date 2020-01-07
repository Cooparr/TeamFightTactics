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
                let earlyGame: [String] = teamComp?.earlyGame,
                let midGame: [String] = teamComp?.midGame,
                let endGame: [TeamCompositionEndGameChamps] = teamComp?.endGame
                else { return }
            
            setTierLabelAndColor(tier)
            setEarlyAndMidChampImages(earlyGame, detailRootView.earlyGameStack)
            setEarlyAndMidChampImages(midGame, detailRootView.midGameStack)
            setEndGameChampImagesAndBoardPosition(endGame)
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
    fileprivate func setTierLabelAndColor(_ tier: TierRating) {
        let tierText: String
        let tierColor: UIColor
        
        switch tier {
        case .sTier:
            tierText = "S Tier"
            tierColor = CustomColor.sTier
        case .aTier:
            tierText = "A Tier"
            tierColor = CustomColor.aTier
        case .bTier:
            tierText = "B Tier"
            tierColor = CustomColor.bTier
        case .cTier:
            tierText = "C Tier"
            tierColor = CustomColor.cTier
        case .dTier:
            tierText = "D Tier"
            tierColor = CustomColor.dTier
        default:
            tierText = "E Tier"
            tierColor = CustomColor.eTier
        }
        
        detailRootView.teamCompTier.text = tierText
        detailRootView.teamCompTier.backgroundColor = tierColor
    }
    
    
    //MARK:- Set Early & Mid Champ Images
    fileprivate func setEarlyAndMidChampImages(_ champions: [String], _ stackView: UIStackView) {
        for (index, champ) in champions.enumerated() {
            guard let stackImage =  stackView.arrangedSubviews[index] as? TCDetailChampImage else { return }
            stackImage.sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.13.1/img/champion/\(champ).png"))
            stackImage.isHidden = false
        }
    }
    
    
    //MARK:- Set End Game Champ Images & Board Position
    fileprivate func setEndGameChampImagesAndBoardPosition(_ endGame: [TeamCompositionEndGameChamps]) {
        // Champ Images
        detailRootView.endGameChamps.forEach({$0.isHidden = true})
        for (index, champ) in endGame.enumerated() {
            let imgView = detailRootView.endGameChamps[index]
            imgView.sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.13.1/img/champion/\(champ.name).png"))
            imgView.isHidden = false
        }
        
        // Board Positions
        for champ in endGame {
            let slotPosition = champ.position - 1
            detailRootView.boardSlots[slotPosition].sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.13.1/img/champion/\(champ.name).png"))
        }
    }
}
