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
    var allTeamComps = [TeamComposition]()
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Team Comps"
        setupTableView()
    }
    
    
    //MARK:- View Did Load
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getTeamCompositionsDataFromFirestore()
    }
    
    
    //MARK:- Setup Table View
    fileprivate func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableId)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    //MARK:- Get Team Comp Data
    fileprivate func getTeamCompositionsDataFromFirestore() {
        FirestoreManager.teamComps.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents:", err)
            } else if let querySnapshot = querySnapshot {
                for document in querySnapshot.documents {
                    let teamComp = TeamComposition(data: document.data())
                    self.allTeamComps.append(teamComp)
                    print(teamComp)
                }
            }
        }
    }

    
    //MARK:- Number Of Sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
        let cell = tableView.dequeueReusableCell(withIdentifier: tableId, for: indexPath)
        
        return cell
    }
}
