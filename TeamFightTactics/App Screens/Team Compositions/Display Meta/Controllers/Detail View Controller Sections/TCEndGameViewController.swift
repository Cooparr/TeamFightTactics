//
//  TCEndGameViewController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 04/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCEndGameViewController: UIViewController {
    
    //MARK: Properties
    lazy private var endGameView = TCEndGameView(backgroundColor: ThemeColor.richBlack)
    weak var delegate: CreateChampImage?
    let champObjs: [Champion]
    let tcCharacters: [TCEndGameChamp]
    
    
    //MARK:- Init
    init(_ champObjs: [Champion], _ endGameCharacters: [TCEndGameChamp]) {
        self.champObjs = champObjs
        self.tcCharacters = endGameCharacters
        super.init(nibName: nil, bundle: nil)
    }
        
    
    //MARK:- Load View
    override func loadView() {
        super.loadView()
        self.view = self.endGameView
    }
    
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        let endGameViews = createEndGameChampViews(champObjs, tcCharacters)
        endGameView.champImageStacks.addChampViewsToStack(champViews: endGameViews)
    }
    
    
    //MARK: Create End Champ Views
    fileprivate func createEndGameChampViews(_ champObjs: [Champion], _ endGameChars: [TCEndGameChamp]) -> [TCDetailEndGameChampView] {
        var endGameViews = [TCDetailEndGameChampView]()
        for champ in champObjs {
            for character in endGameChars where champ.name == character.name {
                let endGameChampView = TCDetailEndGameChampView(champion: champ, items: character.items)
                endGameViews.append(endGameChampView)
            }
        }
        return endGameViews
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
