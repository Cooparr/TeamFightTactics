//
//  TCEndGameViewController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 04/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCEndGameViewController: UIViewController {
    
    lazy private var endGameView: TCEndGameView = TCEndGameView()
    weak var delegate: CreateChampImage?
    
    //MARK: Properties
    let champObjs: [Champion]
    let endGameChamps: [TCEndGameChamps]
    
    
    //MARK:- Init
    init(_ champObjs: [Champion], _ endGameChamps: [TCEndGameChamps]) {
        self.champObjs = champObjs
        self.endGameChamps = endGameChamps
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
        
        setEndGameImages(champObjs, endGameChamps, endGameView.topStack, endGameView.botStack)
    }
    
    
    //MARK: Set End Champ Images
    fileprivate func setEndGameImages(_ champObjs: [Champion], _ endGameChamps: [TCEndGameChamps], _ topStack: UIStackView, _ botStack: UIStackView) {
        for (index, champ) in endGameChamps.enumerated() {
            for champObj in champObjs where champObj.name == champ.name {
                let champImg = delegate?.createChampImage(champObj, imageSize: 60, borderWidth: 2.0)
                
                switch index {
                case ...3:
                    topStack.addArrangedSubview(champImg!)
                default:
                    botStack.addArrangedSubview(champImg!)
                }
            }
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
