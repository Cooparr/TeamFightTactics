//
//  TCBoardViewController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 04/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCBoardViewController: UIViewController {
    
    //MARK: Properties
    lazy private var boardSectionView = TCBoardView(backgroundColor: ThemeColor.richBlack)
    let champObjs: [Champion]
    let endGameChamps: [TCEndGameChamp]
    
    
    //MARK:- Init
    init(_ champObjs: [Champion], _ endGameChamps: [TCEndGameChamp]) {
        self.champObjs = champObjs
        self.endGameChamps = endGameChamps
        super.init(nibName: nil, bundle: nil)
    }
    
    
    //MARK:- Load View
    override func loadView() {
        super.loadView()
        self.view = self.boardSectionView
    }
    
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBoardPosition(for: endGameChamps, championObjs: champObjs)
    }
    
    
    //MARK:- Set Board Position
    fileprivate func setBoardPosition(for endGameChamps: [TCEndGameChamp], championObjs: [Champion]) {
            for champ in endGameChamps {
                let slotPosition = champ.position - 1
                let boardSlot = boardSectionView.boardSlots[slotPosition]
                for champObj in championObjs where champObj.name == champ.name {
                    boardSlot.useStandardOrSetSkin(champObj.imageURL, champObj.name.formattedName())
                    boardSlot.setupColouredHexagonMask(for: boardSlot.layer, with: champObj, lineWidth: 3.0)
                }
            }
        }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
