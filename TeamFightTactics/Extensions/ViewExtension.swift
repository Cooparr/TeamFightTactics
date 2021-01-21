//
//  ViewExtension.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 08/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

//MARK:- UIView Extensions
extension UIView {
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
    
    func pinSubview(to superView: UIView) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor)
        ])
    }
    
    func setBackgroundColor(for tier: DropRate.Tier) {
        switch tier {
        case .one:
            self.backgroundColor = UIColor(cgColor: ChampCostColor.oneCost)
        case .two:
            self.backgroundColor = UIColor(cgColor: ChampCostColor.twoCost)
        case .three:
            self.backgroundColor = UIColor(cgColor: ChampCostColor.threeCost)
        case .four:
            self.backgroundColor = UIColor(cgColor: ChampCostColor.fourCost)
        case .five:
            self.backgroundColor = UIColor(cgColor: ChampCostColor.fiveCost)
        }
    }
}
