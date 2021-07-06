//
//  DisplayTeamCompsView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 25/11/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class DisplayTeamCompsView: BaseView {
    
    //MARK:- Properties
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DisplayTeamCompsCell.self, forCellReuseIdentifier: DisplayTeamCompsCell.reuseId)
        tableView.backgroundColor = ThemeColor.richBlack
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.removeExcessCells()
        return tableView
    }()
    
    
    //MARK:- Setup View
    override func setupView() {
        addSubview(tableView)
        tableView.pinSubview(to: self)
    }
    
    
    //MARK:- Refresh Table View
    func refreshTableView(teamCompsIsEmpty: Bool) {
        tableView.shouldDisplayEmptyMessage(if: teamCompsIsEmpty, message: "Uh oh!\nNo Team Comps Found.")
        tableView.reloadDataOnMainThread()
    }
}
