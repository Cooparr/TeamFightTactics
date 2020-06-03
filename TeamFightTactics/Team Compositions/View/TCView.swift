//
//  TCView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 11/12/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCView: BaseView {
    
    //MARK:- Properties
    var activityIndicator = CustomActivityIndicator()
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TCCell.self, forCellReuseIdentifier: ReuseId.teamCompCell)
        tableView.backgroundColor = ThemeColor.richBlack
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

    
    //MARK:- Setup Subviews
    override func setupSubviews() {
        setupTableViewConstraints()
        setupActivityIndicatorConstraints()
    }
    
    
    //MARK: Setup Table View Constraints
    fileprivate func setupTableViewConstraints() {
        addSubview(tableView)
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: tableView.topAnchor),
            bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
        ])
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
