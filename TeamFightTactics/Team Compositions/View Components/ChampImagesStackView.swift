//
//  ChampImagesStackView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 03/03/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class ChampImagesStackView: BaseStack {
    
    //MARK: Properties
    let topRow = BaseStack(distribution: .equalSpacing, alignment: .top)
    let botRow = BaseStack(distribution: .equalSpacing, alignment: .top)
    
    
    //MARK:- Override Setup Stack
    override func setupStack() {
        addArrangedSubviews(topRow, botRow)
    }
    
    
    //MARK:- Add Champ View To Stack
    func addChampViewsToStack(champViews: [TCDetailEndGameChampView]) {
        for (index, champView) in champViews.enumerated() {
            switch index {
            case 0...3:
                topRow.addArrangedSubview(champView)
            default:
                botRow.addArrangedSubview(champView)
            }
        }
        addSpacerIfRequired(champCount: champViews.count)
    }
    
    
    //MARK: Add Spacer To Stack
    fileprivate func addSpacerIfRequired(champCount: Int) {
        if 5...7 ~= champCount {
            botRow.insertArrangedSubview(UIView(), at: 0)
            botRow.addArrangedSubview(UIView())
        }
    }
}
