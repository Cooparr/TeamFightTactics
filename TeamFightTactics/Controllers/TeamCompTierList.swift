//
//  TeamCompTierList.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 15/10/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class TeamCompTierList: UITableViewController {
    
    //MARK:- Properties
    let tableId = "tableId"
    var teampCompCount: Int?
    var allTeamComps = [TeamComposition]()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .whiteLarge)
        spinner.color = CustomColor.romanSilver
        view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return spinner
    }()
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Team Comps"
        setupTableView()
    }
    
    
    //MARK:- View Did Load
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if teampCompCount != allTeamComps.count {
            getTeamCompositionsDataFromFirestore()
        }
    }
    
    
    //MARK:- Setup Table View
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TeamCompCell.self, forCellReuseIdentifier: tableId)
        tableView.backgroundColor = .white
    }
    
    
    //MARK:- Get Team Comp Data
    fileprivate func getTeamCompositionsDataFromFirestore() {
        self.activityIndicator.startAnimating()
        self.allTeamComps.removeAll()
        
        FirestoreManager.teamComps.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents:", err)
            } else if let querySnapshot = querySnapshot {
                for document in querySnapshot.documents {
                    let teamComp = TeamComposition(data: document.data())
                    self.allTeamComps.append(teamComp)
                    self.teampCompCount = self.allTeamComps.count
//                    print("----------")
//                    print("title:", teamComp.title)
//                    print("tier:", teamComp.tier)
//                    print("early game:", teamComp.earlyGame)
//                    print("mid game:", teamComp.midGame)
//                    print("synergies:", teamComp.synergies)
//                    teamComp.endGame.forEach { (champ) in
//                        champ.forEach { (key, value) in
//                            print(key, value)
//                        }
//                    }
                }
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }

    
    //MARK:- Number Of Rows In Sections
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTeamComps.count
    }
    

    //MARK:- Height For Row At
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    //MARK:- Cell For Row At
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableId, for: indexPath) as! TeamCompCell
        cell.teamComp = allTeamComps[indexPath.row]
        return cell
    }
}