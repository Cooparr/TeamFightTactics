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
    func createChampImage(_ champObj: Champion, imageSize: CGFloat) -> TappableChampionImageView
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
        prefetchPopUpSplashImages(teamComp.allChampObjs)
        setupEarlyMidGameSectionVC(teamComp.tier, teamComp.allChampObjs, teamComp.earlyGame, teamComp.midGame)
        setupEndGameSectionVC(teamComp.endGameChampObjs, teamComp.endGame)
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
    fileprivate func setupEndGameSectionVC(_ endGameChampObjs: [Champion], _ endGame: [TCEndGameChamp]) {
        let endGameSection = TCEndGameViewController(endGameChampObjs, endGame)
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
    
    
    //MARK:- Prefetch Champ PopUp Images
    fileprivate func prefetchPopUpSplashImages(_ champObjs: [Champion]) {
        let splashURLSThatNeedPrefetching = champObjs.filter {
            !SDImageCache.shared.diskImageDataExists(withKey: $0.splashImg)
        }.compactMap { URL(string: $0.splashImg) }
        
        if !splashURLSThatNeedPrefetching.isEmpty {
            SDWebImagePrefetcher.shared.prefetchURLs(splashURLSThatNeedPrefetching)
        }
    }
    
    
    //MARK:- Deinit
    deinit {
        print("TCDetail View Controller: Bye 👋")
    }
}

//MARK:- Create Champ Image Extension
extension TCDetailViewController: CreateChampImage {
    
    //MARK: Create Champ Image
    func createChampImage(_ champ: Champion, imageSize: CGFloat) -> TappableChampionImageView {
        let image = TappableChampionImageView(withChamp: champ, imageSize: imageSize)
        image.useStandardOrSetSkin(champ.imgURL, champ.key)
        image.setChampCostBorderColor(champCost: champ.cost)
        return image
    }
}
