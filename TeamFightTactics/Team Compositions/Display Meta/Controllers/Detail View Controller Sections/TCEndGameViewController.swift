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

    
    //MARK: Create End Champ Views
    fileprivate func createEndGameChampViews(_ champObjs: [Champion], _ endGameChars: [TCEndGameChamp]) -> [TCDetailEndGameChampView] {
        var endGameViews = [TCDetailEndGameChampView]()
        for champ in champObjs {
            for character in endGameChars where champ.name == character.name {
                let endGameChampView = TCDetailEndGameChampView(champ: champ, endGameChar: character)
                endGameViews.append(endGameChampView)
            }
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
