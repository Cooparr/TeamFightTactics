//
//  MoreTabsView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 13/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class MoreTabsView: UITableView {
    
    //MARK:- Init
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupTableView()
    }
    
    
    //MARK:- Setup Table View
    fileprivate func setupTableView() {
        register(MoreTabCell.self, forCellReuseIdentifier: MoreTabCell.reuseId)
        backgroundColor = ThemeColor.richBlack
        separatorInset.left = .zero
        isScrollEnabled = false
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 60
        removeExcessCells()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
