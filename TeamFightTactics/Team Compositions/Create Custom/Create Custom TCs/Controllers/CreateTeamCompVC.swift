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
    let champItemsController = CreateTeamCompChampItemCollectionVC()
    let createdTeamCompVC = SelectedTeamCompTableVC()
    

    //MARK: Load View
    override func loadView() {
        super.loadView()
        self.view = createCustomTCView
    }
    
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        createDismissKeyboardTapGesture()
        addChildViewControllers()
        createdTeamCompVC.delegate = self
        
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
        add(childVC: createdTeamCompVC, toStack: createCustomTCView.mainStackView)
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
            let teamCompName = alertController.textFields?[0].text ?? ""
            let customTeamComp = CustomTeamComposition(title: teamCompName, champions: self.createdTeamCompVC.customSelectedChampionsForTeamComp)
            self.saveCustomTeamComp(teamCompToSave: customTeamComp)
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }
    
    
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
    
    
    //MARK: Toggle Collection View Action
    @objc func toggleColViewAction(_ sender: UIButton) {
        sender.pulseAnimateOnTap()
        toggleChampItemCollectionView()
    }
    
    
    func toggleChampItemCollectionView() {
        champItemsController.showingItems.toggle()
        createCustomTCView.updateToggleButtonTitle(showItems: champItemsController.showingItems)
        champItemsController.collectionView.reloadDataOnMainThread()
    }
    
    
    //MARK: Sort By Button Action
    @objc func sortByButtonAction(_ sender: UIButton) {
        sender.pulseAnimateOnTap()
        
        guard let buttonTapped = CreateTCView.SortBy(rawValue: sender.tag) else {
            presentErrorAlertOnMainThread(title: "Error Sorting", message: "Couldn't sort via \(sender.titleLabel?.text ?? "selected option"). Please try again.", buttonTitle: "Okay")
            return
        }
        
        for btn in createCustomTCView.buttonsStackView.arrangedSubviews {
            if let btn = btn as? CreateTCSortButton {
                switch sender.tag {
                case btn.tag:
                    btn.isSelected = true
                default:
                    btn.isSelected = false
                }
            }            
        }
        
        switch buttonTapped {
        case .name:
            champItemsController.configureDataSourceArrayWith(champions: champItemsController.allChampions, filteredBy: .name, numberOfSections: 1)
        case .cost:
            champItemsController.configureDataSourceArrayWith(champions: champItemsController.allChampions, filteredBy: .cost, numberOfSections: Cost.allCases.count)
        case .tier:
            champItemsController.configureDataSourceArrayWith(champions: champItemsController.allChampions, filteredBy: .tier, numberOfSections: TierRating.allCases.count)
        }
        
        champItemsController.sortingBy = buttonTapped
        champItemsController.collectionView.reloadDataOnMainThread()
    }
}


extension CreateTeamCompVC: SelectedTeamCompTableVCDelegate {
    
    //MARK: Remove Traits
    func removeTraits(for champion: Champion) {
        let traitsToRemove = champion.classes + champion.origins
        
        for (index, trait) in traitsController.traitsToDisplay.enumerated().reversed() where traitsToRemove.contains(trait.name) {
            let newTraitCount = trait.count - 1
            
            if newTraitCount == 0 || newTraitCount == 1 && trait.isChosen {
                traitsController.traitsToDisplay.remove(at: index)
            } else {
                traitsController.traitsToDisplay[index].count = newTraitCount
                traitsController.traitsToDisplay[index].setTraitRank(traitCount: newTraitCount)
            }
            
            traitsController.sortDisplayTraitsByRankThenCount()
            traitsController.collectionView.reloadDataOnMainThread()
        }
    }
}
