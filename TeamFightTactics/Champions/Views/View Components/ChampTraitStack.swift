//
//  ChampTraitStack.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 04/08/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class ChampTraitStack: BaseStack {
    
    //MARK:- Setup Stack
    override func setupArrangedSubviews() {
        for _ in 1...4 {
            addArrangedSubview(ChampTraitBadge(backgroundColor: ThemeColor.romanSilver, cornerRadius: 2))
        }
    }
    
    
    //MARK: Set Origin and Class
    func setTraitBadges(_ classes: [String], _ origins: [String]) {
        let traits = [classes, origins].flatMap({$0})
        
        self.arrangedSubviews.forEach({ $0.isHidden = true })
        for (index, trait) in traits.enumerated() {
            if let badge = self.arrangedSubviews[index] as? ChampTraitBadge {
                badge.typeLabel.text = trait
                badge.typeIcon.image = UIImage(named: "\(trait)")
                badge.isHidden = false
            }
        }
    }
}
