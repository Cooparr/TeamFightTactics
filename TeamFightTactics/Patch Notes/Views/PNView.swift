//
//  PNView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 09/07/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class PNView: BaseView {
    
    //MARK:- Properties
    let activityIndicator = CustomActivityIndicator()
    let patchNotesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PNCell.self, forCellReuseIdentifier: PNCell.reuseId)
        tableView.backgroundColor = ThemeColor.richBlack
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    
    //MARK:- Setup View
    override func setupView() {
        setupTableViewConstraints()
        setupActivityIndicatorConstraints()
    }
    
    
    //MARK: Setup Table View Constraints
    fileprivate func setupTableViewConstraints() {
        addSubview(patchNotesTableView)
        patchNotesTableView.pinSubview(to: self)
    }
    
    
    //MARK: Setup Activity Indicator Constraints
    fileprivate func setupActivityIndicatorConstraints() {
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
