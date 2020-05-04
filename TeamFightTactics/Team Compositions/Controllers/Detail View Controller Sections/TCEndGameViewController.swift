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
    let champObjs: [Champion]
    let endGameChamps: [TeamCompositionEndGameChamps]
    lazy private var endGameView: TCEndGameView = TCEndGameView()
    
    
    //MARK:- Init
    init(_ champObjs: [Champion], _ endGameChamps: [TeamCompositionEndGameChamps]) {
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
    fileprivate func setEndGameImages(_ champObjs: [Champion], _ endGameChamps: [TeamCompositionEndGameChamps], _ topStack: UIStackView, _ botStack: UIStackView) {
        for (index, champ) in endGameChamps.enumerated() {
            for champObj in champObjs where champObj.name == champ.name {
                let champImg = createChampImage(champObj, imageSize: 60, borderWidth: 2.0)
                switch index {
                case ...3:
                    topStack.addArrangedSubview(champImg)
                default:
                    botStack.addArrangedSubview(champImg)
                }
            }
        }
    }
    
    
    //MARK: Create Champ Image
    fileprivate func createChampImage(_ champObj: Champion, imageSize: CGFloat, borderWidth: CGFloat) -> TCDetailChampImage {
        let image = TCDetailChampImage(width: imageSize, height: imageSize, borderWidth: borderWidth)
        image.useStandardOrSetSkin(champObj.imgURL, champObj.key)
        champObj.cost.setChampImageBorder(for: image)
        return image
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
