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
            
            setTierLabel(tier)
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
    fileprivate func setTierLabel(_ tier: TierRating) {
        tier.setTierTextAndColor(for: detailRootView.teamCompTier)
    }
    
    //MARK:- Set Champ Images
    fileprivate func setImages(for champions: [Any], in array: [TCDetailChampImage]) {
        for (index, champ) in champions.enumerated() {
           
            var champName: String
            if champ is TeamCompositionEndGameChamps {
                guard let champ = champ as? TeamCompositionEndGameChamps else { return }
                champName = champ.name
            } else {
                guard let champ = champ as? String else { return }
                champName = champ
            }
            
            champName = champName.removeNameSpaces().isLuxOrQiyana()
            array[index].sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/\(Constants.ver)/img/champion/\(champName).png"))
            array[index].isHidden = false
        }
    }
    
    
    //MARK:- Set Champ Board Position
    fileprivate func setBoardPosition(for endGameChamps: [TeamCompositionEndGameChamps]) {
        for champ in endGameChamps {
            let slotPosition = champ.position - 1
            let champName = champ.name.removeNameSpaces().isLuxOrQiyana()
            detailRootView.boardSlots[slotPosition].sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/\(Constants.ver)/img/champion/\(champName).png"))
        }
    }
    
    
    //MARK:- Deinit
    deinit {
        print("TCDetail View Controller: 👋")
    }
}
