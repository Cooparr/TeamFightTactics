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
    func createChampImage(_ champObj: Champion, imageSize: CGFloat, borderWidth: CGFloat) -> TCChampImage
}


class TCDetailViewController: UIViewController {
    
    //MARK:- Properties
    lazy private var detailRootView: TCDetailView = TCDetailView()
    
    
    //MARK:- Load View
    override func loadView() {
        super.loadView()
        self.view = self.detailRootView
    }
    
    
    //MARK:- Configure TC Detail VC
    func configureTCDetailVC(with teamComp: TeamComposition) {
        navigationItem.title = teamComp.title
        setupEarlyMidGameSectionVC(teamComp.tier, teamComp.allChampObjs, teamComp.earlyGame, teamComp.midGame)
        setupEndGameSectionVC(teamComp.allChampObjs, teamComp.endGame)
        setupBoardSectionVC(teamComp.allChampObjs, teamComp.endGame)
        setupTraitsSectionVC(teamComp.traitObjs, teamComp.synergies)
    }
    
    //MARK:- Setup Early Mid Game Section VC
    fileprivate func setupEarlyMidGameSectionVC(_ tier: TierRating, _ champObjs: [Champion], _ earlyChamps: [String], _ midChamps: [String]) {
        let earlyMidGameSection = TCEarlyAndMidGameViewController(tier, earlyChamps, midChamps, champObjs)
        earlyMidGameSection.delegate = self
        add(childVC: earlyMidGameSection, toStack: detailRootView.scrollViewContainer)
    }
    
    
    //MARK:- Setup End Game Section VC
    fileprivate func setupEndGameSectionVC(_ champObjs: [Champion], _ endGame: [TCEndGameChamp]) {
        let endGameChampObjs = createEndGameChampObjArray(champObjs, endGame)
        let endGameSection = TCEndGameViewController(endGameChampObjs)
        endGameSection.delegate = self
        add(childVC: endGameSection, toStack: detailRootView.scrollViewContainer)
    }
    
    
    //MARK:- Setup Board Section VC
    fileprivate func setupBoardSectionVC(_ allChampObjs: [Champion], _ endGame: [TCEndGameChamp]) {
        let boardSection = TCBoardViewController(allChampObjs, endGame)
        add(childVC: boardSection, toStack: detailRootView.scrollViewContainer)
    }
    
    
    //MARK:- Setup Traits Section VC
    fileprivate func setupTraitsSectionVC(_ traitObjs: [Trait], _ synergies: [TCSynergy]) {
        let traitsSection = TCTraitsViewController(traitObjs, synergies)
        add(childVC: traitsSection, toStack: detailRootView.scrollViewContainer)
    }
    
    
    //MARK:- Deinit
    deinit {
        print("TCDetail View Controller: Bye 👋")
    }
}

//MARK:- Create Champ Image Extension
extension TCDetailViewController: CreateChampImage {
    
    //MARK: Create Champ Image
    func createChampImage(_ champObj: Champion, imageSize: CGFloat, borderWidth: CGFloat) -> TCChampImage {
        let image = TCChampImage(imageSize: imageSize, borderWidth: borderWidth)
        image.useStandardOrSetSkin(champObj.imgURL, champObj.key)
        image.setChampCostBorderColor(champCost: champObj.cost)
        return image
    }
    
    
    //MARK: Create End Game Champ Objs Array
    fileprivate func createEndGameChampObjArray(_ champObjs: [Champion], _ endGame: [TCEndGameChamp]) -> [Champion] {
        var tempArray: [Champion] = []
        for champObj in champObjs.sorted(by: {$0.cost.rawValue < $1.cost.rawValue}) {
            for champ in endGame where champObj.name == champ.name {
                tempArray.append(champObj)
            }
        }
        return tempArray
    }
}
