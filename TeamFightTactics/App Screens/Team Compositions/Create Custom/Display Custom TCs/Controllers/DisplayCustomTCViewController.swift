//
//  DisplayTeamCompsVC.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 23/11/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit
import FirebaseFirestore

class DisplayCustomTCViewController: UIViewController {

    //MARK:- Properties
    private let customTeamCompView = DisplayTeamCompsView()
    private(set) var customTeamComps = [CustomTeamComposition]()
    
    
    //MARK:- Firestore Listeners
    private var customTeamCompsListener: ListenerRegistration?
    
    
    //MARK:- Load View
    override func loadView() {
        super.loadView()
        self.view = customTeamCompView
    }
    
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        assignTableViewDelegates()
    }
    
    
    //MARK:- View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCustomTeamComps()
    }
    
    
    //MARK:- View Will Disappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        customTeamCompsListener?.remove()
    }
        
    
    //MARK: Assign Table View Delegates
    private func assignTableViewDelegates() {
        customTeamCompView.tableView.delegate = self
        customTeamCompView.tableView.dataSource = self
    }
    
    
    //MARK:- Get Custom Team Comps
    private func getCustomTeamComps() {
        customTeamCompsListener = CustomTCManager.retrieveTeamComps { [weak self] result in
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
    private func updateCustomTeamCompsTableView(with teamComps: [CustomTeamComposition]) {
        teamComps.isEmpty ? customTeamCompView.tableView.setEmptyMessage("No Team Comps Found!\nCreate One?") : customTeamCompView.tableView.removeEmptyMessage()
        customTeamComps = teamComps.sorted { $0.title < $1.title }
        customTeamCompView.tableView.reloadDataOnMainThread()
    }
}


//MARK:- TableView Data Source
extension DisplayCustomTCViewController: UITableViewDataSource {
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
extension DisplayCustomTCViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let displayCustomTeamCompVC = DisplayDetailedTeamCompVC(customTeamComp: customTeamComps[indexPath.row])
        navigationController?.pushViewController(displayCustomTeamCompVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = handleDeleteAction(for: tableView, indexPath)
        deleteAction.image = SFSymbol.OtherIcons.trash

        let updateAction = handleUpdateAction(indexPath)
        updateAction.image = SFSymbol.OtherIcons.edit
        updateAction.backgroundColor = ThemeColor.independence
        
        return UISwipeActionsConfiguration(actions: [deleteAction, updateAction])
    }
}


//MARK:- Contextual Action For Trailing Swipe
extension DisplayCustomTCViewController {
    private func handleDeleteAction(for tableView: UITableView, _ indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, isComplete) in
            guard let self = self else { return }

            let teamCompToDelete = self.customTeamComps[indexPath.row]
            self.customTeamComps.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            CustomTCManager.deleteSingleTeamComp(teamCompId: teamCompToDelete.uuid) { result in
                switch result {
                case.success:
                    isComplete(true)
                case.failure(let error):
                    self.presentErrorAlertOnMainThread(title: "Deletion Error", message: error.rawValue + teamCompToDelete.title)
                    isComplete(false)
                }
            }
        }
    }
    
    
    private func handleUpdateAction(_ indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .normal, title: "Update") { [weak self] (_, _, isComplete) in
            guard let self = self else { return isComplete(false) }
            let teamCompToUpdate = self.customTeamComps[indexPath.row]
            let vc = CreateTCPageViewController(teamCompToUpdate: teamCompToUpdate)
            self.navigationController?.pushViewController(vc, animated: true)
            isComplete(true)
        }
    }
}
