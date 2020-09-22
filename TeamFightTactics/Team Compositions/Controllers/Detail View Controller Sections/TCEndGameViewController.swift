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
    lazy private var endGameView: TCEndGameView = TCEndGameView()
    weak var delegate: CreateChampImage?
    let champObjs: [Champion]
    let tcCharacters: [TCEndGameChamp]
    
    var champObjCount: Int {
        return champObjs.count
    }
    
    
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
        addChampViewsToStack(champViews: endGameViews, champImageStack: endGameView.champImageStacks)
    }
    
    
    //MARK:- Add Champ View To Stack
    fileprivate func addChampViewsToStack(champViews: [TCDetailEndGameChampView], champImageStack: UIStackView) {
        guard
            let topStack = champImageStack.arrangedSubviews[0] as? UIStackView,
            let botStack = champImageStack.arrangedSubviews[1] as? UIStackView
            else { return }

        for (index, champView) in champViews.enumerated() {
            switch index {
            case 0...3:
                topStack.addArrangedSubview(champView)
            default:
                botStack.addArrangedSubview(champView)
            }
        }
        addSpacerIfRequired(botStack)
    }

    
    //MARK: Creat End Champ Views
    fileprivate func createEndGameChampViews(_ champObjs: [Champion], _ endGameChars: [TCEndGameChamp]) -> [TCDetailEndGameChampView] {
        var endGameViews = [TCDetailEndGameChampView]()
        for champ in champObjs {
            let endGameChampView = TCDetailEndGameChampView()
            endGameChampView.champImage.useStandardOrSetSkin(champ.imgURL, champ.key)
            endGameChampView.champImage.setChampCostBorderColor(champCost: champ.cost)

            for char in endGameChars where champ.name == char.name {
                guard let bestItems = char.items else { break }
                for item in bestItems {
                    let bestItemImageView = BestItemImgView(img: UIImage(named: item.formattedName()), size: 22)
                    bestItemImageView.setChampCostBorderColor(champCost: champ.cost, rainbowLineWidth: 2.0)
                    endGameChampView.champBestItemImages.addArrangedSubview(bestItemImageView)
                }
            }
            endGameViews.append(endGameChampView)
        }
        return endGameViews
    }
    
    
    //MARK: Add Spacer To Stack
    fileprivate func addSpacerIfRequired(_ botStack: UIStackView) {
        if champObjCount > 4 && champObjCount < 8 {
            botStack.insertArrangedSubview(UIView(), at: 0)
            botStack.addArrangedSubview(UIView())
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
