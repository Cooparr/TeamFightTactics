//
//  TeamCompTierList.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 15/10/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit
import FirebaseFirestore

class TeamCompTierList: UIViewController {
    
    //MARK:- Properties
    lazy private var teamCompRootView = TeamCompControllerView()
    var teampCompCount: Int?
    var allTeamComps = [TeamComposition]()
    
    
    //MARK:- Load View
    override func loadView() {
        super.loadView()
        self.view = self.teamCompRootView
    }
    
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetup()
        
        // Assign Delegates
        teamCompRootView.tableView.delegate = self
        teamCompRootView.tableView.dataSource = self
    }
    
    
    //MARK:- View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if teampCompCount != allTeamComps.count {
            teamCompRootView.activityIndicator.startAnimating()
            performSelector(inBackground: #selector(getTeamCompositionsDataFromFirestore), with: nil)
        }
    }
    
    
    //MARK: Navigation Bar Code
    fileprivate func navigationBarSetup() {
        navigationItem.title = "Team Composition"
    }
    
    
    //MARK:- Get Team Comp Data
    @objc fileprivate func getTeamCompositionsDataFromFirestore() {
        self.allTeamComps.removeAll()
        
        Firestore.firestore().teamComps(fromSet: "Set1").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents:", err)
            }
            
            guard let documents = querySnapshot?.documents else { return }
            for document in documents {
                let teamComp = TeamComposition(data: document.data())
                self.allTeamComps.append(teamComp)
            }
            self.allTeamComps.sort(by: {$0.tier.rawValue < $1.tier.rawValue})
            self.teampCompCount = self.allTeamComps.count
            
            DispatchQueue.main.async {
                self.teamCompRootView.activityIndicator.stopAnimating()
                self.teamCompRootView.tableView.reloadData()
            }
        }
    }
}


//MARK:- TableView Data Source
extension TeamCompTierList: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTeamComps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableId", for: indexPath) as! TeamCompCell
        cell.teamComp = allTeamComps[indexPath.row]
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = CustomColor.charcoal
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
}


//MARK:- TableView Delegate
extension TeamCompTierList: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let teamComp = allTeamComps[indexPath.row]
        let teamCompDetailViewController = TeamCompDetailViewController()
        teamCompDetailViewController.teamComp = teamComp
        self.navigationController?.pushViewController(teamCompDetailViewController, animated: true)
        teamCompRootView.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
