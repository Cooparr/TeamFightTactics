//
//  UpdateExistingTeamCompVC.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 21/04/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class UpdateExistingTeamComp: CreateNewTeamCompVC {
    
    //MARK: Properties
    private(set) var teamCompToUpdate: CustomTeamComposition
    
    
    //MARK: Init
    init(teamCompToUpdate: CustomTeamComposition) {
        self.teamCompToUpdate = teamCompToUpdate
        super.init(nibName: nil, bundle: nil)
        
        selectedTeamCompVC.selectedChampsForTeamComp = teamCompToUpdate.champions
        traitsController.traitsToDisplay = teamCompToUpdate.traits
    }
    
    
    //MARK: Override Configure Nav Bar
    override func configureNavBar() {
        navigationItem.title = teamCompToUpdate.title
        let updateButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTeamCompTapped))
        navigationItem.rightBarButtonItem = updateButton
    }
    
    
    //MARK: Override Present Save Alert Controller
    override func presentSaveTeamCompAlertController() {
        let alertController = UIAlertController(title: "Update Team Comp", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let updateAction = UIAlertAction(title: "Update", style: .default) { [weak self] _ in
            let title = alertController.textFields?[0].text ?? ""
            let desc = alertController.textFields?[1].text
            self?.updateAction(teamCompTitle: title, teamCompDesc: desc)
        }
        
        alertController.addTextField(configurationHandler: configureTeamCompNameTextField)
        alertController.addTextField(configurationHandler: configureTeamDescriptionTextField)
        alertController.addAction(updateAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    
    
    //MARK: Update Action
    private func updateAction(teamCompTitle: String, teamCompDesc: String?) {
        self.teamCompToUpdate.title = teamCompTitle
        self.teamCompToUpdate.description = teamCompDesc
        self.teamCompToUpdate.champions = self.selectedTeamCompVC.selectedChampsForTeamComp
        self.teamCompToUpdate.traits = self.traitsController.traitsToDisplay
        self.updateTeamComp(teamCompToUpdate: self.teamCompToUpdate)
    }
    
    
    //MARK: Update Custom Team Comp
    private func updateTeamComp(teamCompToUpdate: CustomTeamComposition) {
        PersistenceManager.updateExistingTeamComp(teamComp: teamCompToUpdate) { [weak self] result in
            switch result {
            case .success:
                self?.navigationController?.popViewController(animated: true)
            case .failure(let error):
                self?.presentErrorAlertOnMainThread(title: "Error Updating Team Comp", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
