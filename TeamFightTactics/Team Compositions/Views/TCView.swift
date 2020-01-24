//
//  TCView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 11/12/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCView: UIView {
    
    //MARK:- Properties
    var activityIndicator = CustomActivityIndicator()
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TCCell.self, forCellReuseIdentifier: "tableId")
        tableView.backgroundColor = CustomColor.richBlack
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

    
    //MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupTableViewConstraints()
        setupActivityIndicatorConstraints()
    }
    
    
    //MARK:- Constraint Functions
    fileprivate func setupTableViewConstraints() {
        addSubview(tableView)
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: tableView.topAnchor),
            bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
        ])
    }
    
    fileprivate func setupActivityIndicatorConstraints() {
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
