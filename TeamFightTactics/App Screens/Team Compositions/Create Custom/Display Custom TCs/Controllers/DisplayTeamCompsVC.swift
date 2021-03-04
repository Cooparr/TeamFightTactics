//
//  DisplayTeamCompsVC.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 23/11/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class DisplayTeamCompsVC: UIViewController {
    
    
    //MARK:- Properties
    private let customTeamCompView = DisplayTeamCompsView()
    var customTeamComps = [CustomTeamComposition]()
    
    
    //MARK:- Load View
    override func loadView() {
        super.loadView()
        self.view = customTeamCompView
    }
    
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Assign Delegates
        customTeamCompView.tableView.delegate = self
        customTeamCompView.tableView.dataSource = self
    }
    
    
    //MARK:- View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCustomTeamComps()
    }
    
    
    
    //MARK:- Get Custom Team Comps
    fileprivate func getCustomTeamComps() {
        PersistenceManager.retrieveTeamComps { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let teamComps):
                self.updateCustomTeamCompsTableView(with: teamComps)
            case .failure(let error):
                self.presentErrorAlertOnMainThread(title: "Something went wrong", message: error.rawValue)
            }
        }
    }
    
    
    //MARK:- Update Custom Team Comps Table View
    fileprivate func updateCustomTeamCompsTableView(with teamComps: [CustomTeamComposition]) {
        teamComps.isEmpty ? customTeamCompView.tableView.setEmptyMessage("No Team Comps Found!\nCreate One?") : customTeamCompView.tableView.removeEmptyMessage()
        customTeamComps = teamComps
        customTeamCompView.tableView.reloadDataOnMainThread()
    }
}


//MARK:- TableView Data Source
extension DisplayTeamCompsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        customTeamComps.isEmpty ? tableView.setEmptyMessage("Try creating your own team comps.") : tableView.removeEmptyMessage()
        return customTeamComps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(DisplayTeamCompsCell.self, for: indexPath)
        cell.configureCell(with: customTeamComps[indexPath.row])
        return cell
    }
}


//MARK:- TableView Delegate
extension DisplayTeamCompsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DisplayDetailedTeamCompVC(customTeamComp: customTeamComps[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        PersistenceManager.updateTeamComp(teamComp: customTeamComps[indexPath.row], actionType: .delete) { [weak self] error in
            guard let self = self else { return }
            guard error != nil else {
                self.customTeamComps.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                return
            }
            self.presentErrorAlertOnMainThread(title: "Deletion Error", message: "Unable to delete \(self.customTeamComps[indexPath.item].title) team composition. Please try again.")
        }
    }
}
