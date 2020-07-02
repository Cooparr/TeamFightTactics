//
//  ItemStatsStack.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 02/07/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class ItemStatsStack: UIStackView {
    
    //MARK:- Properties
    let statViewArray = (1...3).map { _ in
        StatView(statWidth: 70, iconSize: 17, fontSize: 13, fontWeight: .regular)
    }
    
    
    //MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
        spacing = 8
        alignment = .center
    }
    
    
    //MARK:- Configure Stackview
    func configureStackView(with stats: [ItemStat]) {
        for (index, stat) in stats.enumerated() {
            if index >= arrangedSubviews.count {
                let newStatView = StatView(statWidth: 70, iconSize: 17, fontSize: 13, fontWeight: .regular)
                updateStatView(newStatView, with: stat)
                addArrangedSubview(newStatView)
            } else {
                guard let existingStatView = arrangedSubviews[index] as? StatView else { return }
                updateStatView(existingStatView, with: stat)
            }
        }
        
        let overflow = arrangedSubviews.count - stats.count
        if overflow > 0 {
            for _ in 1...overflow {
                guard let removeStatView = arrangedSubviews.last as? StatView else { return }
                removeStatView.removeFromSuperview()
            }
        }
    }
    
    
    //MARK:- Update StatView
    fileprivate func updateStatView(_ statView: StatView, with stat: ItemStat) {
        guard let key = stat.key, let value = stat.value else { return }
        statView.statLabel.text = "+\(value)"
        statView.updateStatIcon(statType: key)
    }
    
    
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
