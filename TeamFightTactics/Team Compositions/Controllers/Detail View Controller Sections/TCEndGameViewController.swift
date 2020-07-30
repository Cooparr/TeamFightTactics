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
    let neededChampObjs: [Champion]
    
    
    //MARK:- Init
    init(_ champObjs: [Champion]) {
        self.neededChampObjs = champObjs
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
        setEndGameImages(neededChampObjs, endGameView.topStack, endGameView.botStack)
    }
    
    
    //MARK: Set End Champ Images
    fileprivate func setEndGameImages(_ champObjs: [Champion], _ topStack: UIStackView, _ botStack: UIStackView) {
        for (index, champ) in champObjs.enumerated() {
            if let champImg = delegate?.createChampImage(champ, imageSize: 60, borderWidth: 2.0) {
                switch index {
                case 0...3:
                    topStack.addArrangedSubview(champImg)
                default:
                    botStack.addArrangedSubview(champImg)
                }
            }
        }
        
        if champObjs.count > 4 && champObjs.count < 8 {
            botStack.insertArrangedSubview(UIView(), at: 0)
            botStack.addArrangedSubview(UIView())
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
