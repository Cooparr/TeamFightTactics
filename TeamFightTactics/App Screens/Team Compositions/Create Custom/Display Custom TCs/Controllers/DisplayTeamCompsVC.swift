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
        customTeamComps = teamComps.sorted { $0.title < $1.title }
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
        let displayCustomTeamCompVC = DisplayDetailedTeamCompVC(customTeamComp: customTeamComps[indexPath.row])
        navigationController?.pushViewController(displayCustomTeamCompVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completion) in
            guard let self = self else { return }
            PersistenceManager.deleteSingleTeamComp(teamComp: self.customTeamComps[indexPath.row]) { result in
                switch result {
                case.success:
                    self.customTeamComps.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                case.failure(let error):
                    self.presentErrorAlertOnMainThread(title: "Deletion Error", message: error.rawValue + self.customTeamComps[indexPath.row].title)
                }
            }
            completion(true)
        }
        deleteAction.image = SFSymbol.OtherIcons.trash

        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] (_, _, completion) in
            guard let self = self else { return }
            let teamComp = self.customTeamComps[indexPath.row]
            let vc = CreateTCPageViewController(teamCompToUpdate: teamComp)
            self.navigationController?.pushViewController(vc, animated: true)
            completion(true)
        }
        editAction.image = SFSymbol.OtherIcons.edit
        editAction.backgroundColor = ThemeColor.independence
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
}
