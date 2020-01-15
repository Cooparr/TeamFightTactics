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
            setImages(for: earlyGame, in: detailRootView.earlyGameChamps)
            setImages(for: midGame, in: detailRootView.midGameChamps)
            setImages(for: endGame, in: detailRootView.endGameChamps)
            setBoardPosition(for: endGame)
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
    
    
    //MARK:- Set Champ Images
    fileprivate func setImages(for champions: [Any], in array: [TCDetailChampImage]) {
        for (index, champ) in champions.enumerated() {
            if champions is [TeamCompositionEndGameChamps] {
                guard let champ = champ as? TeamCompositionEndGameChamps else { return }
                array[index].sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.13.1/img/champion/\(champ.name).png"))
            } else {
                array[index].sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.13.1/img/champion/\(champ).png"))
            }
            array[index].isHidden = false
        }
    }
    
    
    //MARK:- Set Champ Board Position
    fileprivate func setBoardPosition(for endGameChamps: [TeamCompositionEndGameChamps]) {
        for champ in endGameChamps {
            let slotPosition = champ.position - 1
            detailRootView.boardSlots[slotPosition].sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.13.1/img/champion/\(champ.name).png"))
        }
    }
    
    
    //MARK:- Deinit
    deinit {
        print("TCDetail View Controller: 👋")
    }
}
