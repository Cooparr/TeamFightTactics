//
//  TCDetailViewController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 11/12/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit
import SDWebImage


protocol CreateChampImage: class {
    func createChampImage(_ champObj: Champion, imageSize: CGFloat, borderWidth: CGFloat) -> TCDetailChampImage
}


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
                let synergies = teamComp?.synergies,
                let allChampObjs = teamComp?.allChampObjs,
                let classObjs = teamComp?.classObjs,
                let originObjs = teamComp?.originObjs
                else { return }
            if allChampObjs.isEmpty || classObjs.isEmpty || originObjs.isEmpty { return }
            
            
            setupEarlyMidGameSectionVC(tier, earlyGame, midGame, allChampObjs)
            setupEndGameSectionVC(allChampObjs, endGame)
            setupBoardSectionVC(allChampObjs, endGame)
            setupTraitsSectionVC(classObjs, originObjs, synergies)
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
    
    
    //MARK:- Navigation Bar Code
    fileprivate func navigationBarSetup() {
        navigationItem.title = teamComp?.title
    }
    
    
    //MARK:- Setup Early Mid Game Section VC
    fileprivate func setupEarlyMidGameSectionVC(_ tier: TierRating, _ earlyChamps: [String], _ midChamps: [String], _ champObjs: [Champion]) {
        let earlyMidGameSection = TCEarlyAndMidGameViewController(tier, earlyChamps, midChamps, champObjs)
        earlyMidGameSection.delegate = self
        add(childVC: earlyMidGameSection, toStack: detailRootView.scrollViewContainer)
    }
    
    
    //MARK:- Setup End Game Section VC
    fileprivate func setupEndGameSectionVC(_ champObjs: [Champion], _ endGame: [TCEndGameChamps]) {
        let endGameSection = TCEndGameViewController(champObjs, endGame)
        endGameSection.delegate = self
        add(childVC: endGameSection, toStack: detailRootView.scrollViewContainer)
    }
    
    
    //MARK:- Setup Board Section VC
    fileprivate func setupBoardSectionVC(_ allChampObjs: [Champion], _ endGame: [TCEndGameChamps]) {
        let boardSection = TCBoardViewController(allChampObjs, endGame)
        add(childVC: boardSection, toStack: detailRootView.scrollViewContainer)
    }
    
    
    //MARK:- Setup Traits Section VC
    fileprivate func setupTraitsSectionVC(_ classObjs: [Trait], _ originObjs: [Trait], _ synergies: [TCSynergies]) {
        let traitsSection = TCTraitsViewController(classObjs, originObjs, synergies)
        add(childVC: traitsSection, toStack: detailRootView.scrollViewContainer)
    }    
    
    
    //MARK:- Deinit
    deinit {
        print("TCDetail View Controller: 👋")
    }
}

//MARK:- Create Champ Image Extension
extension TCDetailViewController: CreateChampImage {
    
    func createChampImage(_ champObj: Champion, imageSize: CGFloat, borderWidth: CGFloat) -> TCDetailChampImage {
        let image = TCDetailChampImage(width: imageSize, height: imageSize, borderWidth: borderWidth)
        image.useStandardOrSetSkin(champObj.imgURL, champObj.key)
        champObj.cost.setChampImageBorder(for: image)
        return image
    }
    
}




