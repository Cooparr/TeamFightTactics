//
//  MetaTCView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 11/12/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class MetaTCView: BaseView {
    
    //MARK:- Properties
    var activityIndicator = CustomActivityIndicator()
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TCCell.self, forCellReuseIdentifier: TCCell.reuseId)
        tableView.backgroundColor = ThemeColor.richBlack
        tableView.showsVerticalScrollIndicator = false
        tableView.removeExcessCells()
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
        tableView.pinSubview(to: self)
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
