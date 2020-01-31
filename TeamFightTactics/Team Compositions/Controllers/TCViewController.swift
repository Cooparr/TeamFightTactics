//
//  TCViewController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 15/10/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit
import FirebaseFirestore

class TCViewController: UIViewController {
    
    //MARK:- Properties
    private let tcRootView = TCView()
    var allChampions = [Champion]()
    var allTeamComps = [TeamComposition]() {
        didSet {
            handleSpinner(spin: tcRootView.activityIndicator, if: allTeamComps.isEmpty)
            tcRootView.tableView.reloadData()
        }
    }

    
    //MARK:- Load View
    override func loadView() {
        super.loadView()
        self.view = tcRootView
    }
    
    
    //MARK:- View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleSpinner(spin: tcRootView.activityIndicator, if: allTeamComps.isEmpty)
    }
    
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetup()
        
        // Assign Delegates
        tcRootView.tableView.delegate = self
        tcRootView.tableView.dataSource = self
    }
    
    
    //MARK: Navigation Bar Code
    fileprivate func navigationBarSetup() {
        navigationItem.title = "Team Composition"
    }
}


//MARK:- TableView Data Source
extension TCViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTeamComps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableId", for: indexPath) as! TCCell
        cell.teamComp = allTeamComps[indexPath.row]
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = CustomColor.charcoal
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
}


//MARK:- TableView Delegate
extension TCViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let teamComp = allTeamComps[indexPath.row]
        let teamCompDetailViewController = TCDetailViewController()
        teamCompDetailViewController.teamComp = teamComp
        self.navigationController?.pushViewController(teamCompDetailViewController, animated: true)
        tcRootView.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
