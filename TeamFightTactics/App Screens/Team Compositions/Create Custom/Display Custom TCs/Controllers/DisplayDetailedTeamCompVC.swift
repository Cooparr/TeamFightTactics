//
//  DisplayDetailedTeamCompVC.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 25/02/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class DisplayDetailedTeamCompVC: UIViewController {
    
    //MARK: Properties
    private let detailView = DisplayDetailedTeamCompView(tamic: true, backgroundColor: ThemeColor.richBlack)
    
    
    //MARK: Init
    required init(customTeamComp: CustomTeamComposition) {
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = customTeamComp.title
        
        
        setupChampImgViewStackView(with: customTeamComp.champions)
        setupTraitTilesStackView(with: customTeamComp.traits)
    }
    
    
    //MARK: Load View
    override func loadView() {
        super.loadView()
        self.view = self.detailView
    }
    
    
    //MARK:
    fileprivate func setupChampImgViewStackView(with champs: [Champion]) {
        let champEndGameViews = champs.map { TCDetailEndGameChampView(champion: $0, items: $0.customItems) }
        detailView.champImgViewStacks.addChampViewsToStack(champViews: champEndGameViews)
    }
    
    
    fileprivate func setupTraitTilesStackView(with traits: [Trait]) {
        for trait in traits {
            guard trait.rank != .unranked else { continue }
            let traitInfo = TCDetailTraitInfo(with: trait)
            detailView.synergiesStackView.addArrangedSubview(traitInfo)
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
