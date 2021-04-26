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
    private let teamComp: CustomTeamComposition
    private let detailView = DisplayDetailedTeamCompView(tamic: true, backgroundColor: ThemeColor.richBlack)
    
    
    //MARK: Init
    required init(customTeamComp: CustomTeamComposition) {
        self.teamComp = customTeamComp
        super.init(nibName: nil, bundle: nil)
    }
    
    
    //MARK: Load View
    override func loadView() {
        super.loadView()
        self.view = self.detailView
    }
    
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = teamComp.title
        let desc = teamComp.description
        let champImgs = teamComp.champions.map { TCDetailEndGameChampView(champion: $0, items: $0.customItems) }
        let traitTiles = teamComp.traits.filter { $0.rank != .unranked }.map { TCDetailTraitInfo(with: $0) }
        detailView.configureDetailView(desc: desc, champImgViews: champImgs, traitTiles: traitTiles)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
