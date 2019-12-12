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
    lazy private var detailRootView = TCDetailView()
    var teamComp: TeamComposition? {
        didSet {
            guard
                let earlyGame = teamComp?.earlyGame,
                let midGame = teamComp?.midGame,
                let endGame = teamComp?.endGame
                else { return }
            
            // Early Game
            detailRootView.earlyOneImage.sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.13.1/img/champion/\(earlyGame[0]).png"))
            detailRootView.earlyTwoImage.sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.13.1/img/champion/\(earlyGame[0]).png"))
            detailRootView.earlyThreeImage.sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.13.1/img/champion/\(earlyGame[0]).png"))
            
            // Mid Game
            detailRootView.midOneImage.sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.13.1/img/champion/\(midGame[0]).png"))
            detailRootView.midTwoImage.sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.13.1/img/champion/\(midGame[0]).png"))
            detailRootView.midThreeImage.sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.13.1/img/champion/\(midGame[0]).png"))
            detailRootView.midFourImage.sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.13.1/img/champion/\(midGame[0]).png"))
            detailRootView.midFiveImage.sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.13.1/img/champion/\(midGame[0]).png"))
            
            // End Game
            detailRootView.endOneImage.sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.13.1/img/champion/\(endGame[0].name).png"))
            detailRootView.endTwoImage.sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.13.1/img/champion/\(endGame[0].name).png"))
            detailRootView.endThreeImage.sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.13.1/img/champion/\(endGame[0].name).png"))
            detailRootView.endFourImage.sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.13.1/img/champion/\(endGame[0].name).png"))
            detailRootView.endFiveImage.sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.13.1/img/champion/\(endGame[0].name).png"))
            detailRootView.endSixImage.sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.13.1/img/champion/\(endGame[0].name).png"))
            detailRootView.endSevenImage.sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.13.1/img/champion/\(endGame[0].name).png"))
            detailRootView.endEightImage.sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.13.1/img/champion/\(endGame[0].name).png"))
            
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
}
