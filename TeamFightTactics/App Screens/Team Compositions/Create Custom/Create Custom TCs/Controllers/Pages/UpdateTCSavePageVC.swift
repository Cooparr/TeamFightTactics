//
//  UpdateTCSavePageVC.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 08/06/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class UpdateTCSavePageVC: CreateTCSavePageVC {
    
    //MARK: Properties
    private(set) var teamCompToUpdate: CustomTeamComposition
    
    
    //MARK: Init
    init(teamCompToUpdate: CustomTeamComposition) {
        self.teamCompToUpdate = teamCompToUpdate
        super.init(nibName: nil, bundle: nil)
        
        savePageView.saveButton.setTitle("Update Team Comp", for: .normal)
        savePageView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    
    //MARK: Override Save Button Tapped
    override func saveButtonTapped(button: UIButton) {
        button.pulseAnimateOnTap()
        guard let teamCompTitle = savePageView.nameTextField.text else { return }
        let teamCompDesc = savePageView.descTextView.text
        guard let teamCompChamps = saveDelegate?.getChampionsForTeamComp() else { return }
        guard let teamCompTraits = saveDelegate?.getTraitsForTeamComp() else { return }

        
        teamCompToUpdate.updateTeamComp(title: teamCompTitle, description: teamCompDesc, champions: teamCompChamps, traits: teamCompTraits)
        
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
