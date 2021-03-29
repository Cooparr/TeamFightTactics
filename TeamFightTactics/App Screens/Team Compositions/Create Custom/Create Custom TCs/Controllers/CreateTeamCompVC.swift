//
//  CreateTeamCompVC.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 26/11/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class CreateTeamCompVC: UIViewController {

    //MARK: Properties
    static let maxTeamCompSize = 9
    static let numOfChampOccurencesPerTeamComp = 2
    
    private let createCustomTCView = CreateTCView()
    let traitsController = CreateTeamCompTraitsCollectionVC()
    let champItemsController = ChampItemSelectionVC()
    let selectedTeamCompVC = SelectedTeamCompTableVC()
    

    //MARK: Load View
    override func loadView() {
        super.loadView()
        self.view = createCustomTCView
    }
    
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()

        createDismissKeyboardTapGesture()
        addChildViewControllers()
        selectedTeamCompVC.selectedTCDelegate = traitsController
        selectedTeamCompVC.createTCDelegate = champItemsController
        
        setupNavBar(navTitle: .createTeamComp, showSettingsButton: false)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped)),
            UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(retrieveTeamComp)),
            UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteAllTeamComps)),
        ]
    }
    
    
    //MARK: Add Child View Controllers
    fileprivate func addChildViewControllers() {
        add(childVC: champItemsController, toStack: createCustomTCView.mainStackView)
        add(childVC: traitsController, toStack: createCustomTCView.mainStackView)
        add(childVC: selectedTeamCompVC, toStack: createCustomTCView.mainStackView)
    }
    
    
    //MARK: Create Dismiss Keyboard Tap Gesture
    fileprivate func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    
    //MARK: Save Custom Team Comp
    fileprivate func saveCustomTeamComp(teamCompToSave: CustomTeamComposition) {
        PersistenceManager.updateTeamComp(teamComp: teamCompToSave, actionType: .add) { [weak self] error in
            guard let error = error else {
                self?.navigationController?.popViewController(animated: true)
                return
            }
            self?.presentErrorAlertOnMainThread(title: "Error Saving Team Comp", message: error.rawValue, buttonTitle: "Ok")
        }
    }
    
    
    //MARK: Save Button Tapped Action
    @objc fileprivate func saveButtonTapped() {
        let alertController = SaveTeamCompAlertController(title: "Save Team Comp", message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] action in
            guard let self = self else { return }
            let teamCompTitle = alertController.textFields?[0].text ?? ""
            let teamCompChampions = self.selectedTeamCompVC.selectedChampsForTeamComp
            let teamCompTraits = self.traitsController.traitsToDisplay
            let customTeamComp = CustomTeamComposition(title: teamCompTitle, champions: teamCompChampions, traits: teamCompTraits)
            self.saveCustomTeamComp(teamCompToSave: customTeamComp)
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }
    
    #warning("Need to remove retieve and delete before submission")
    //MARK: Retrieve Team Comp Action
    @objc fileprivate func retrieveTeamComp() {
        PersistenceManager.retrieveTeamComps { result in
            switch result {
            case .success(let teamComps):
                print(teamComps)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    //MARK: Delete All Team Comps Action
    @objc fileprivate func deleteAllTeamComps() {
        PersistenceManager.deleteAllTeamComps { error in
            guard let error = error else {
                self.navigationController?.popViewController(animated: true)
                return
            }
            
            self.presentErrorAlertOnMainThread(title: "Error Deleting Team Comps", message: error.rawValue)
        }
    }
}
