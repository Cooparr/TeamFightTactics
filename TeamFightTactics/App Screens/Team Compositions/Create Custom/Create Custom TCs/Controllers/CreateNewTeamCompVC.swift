//
//  CreateNewTeamCompVC.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 26/11/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class CreateNewTeamCompVC: UIViewController {
    
    //MARK:- Properties
    static let maxTeamCompSize = 9
    static let numOfChampOccurencesPerTeamComp = 2
    
    private let createCustomTCView = CreateTCView()
    private let champItemSelectionVC = ChampItemSelectionVC()
    private(set) var traitsController = CreateTeamCompTraitsVC()
    private(set) var selectedTeamCompVC = SelectedTeamCompVC()
    
    
    //MARK:- Load View
    override func loadView() {
        super.loadView()
        self.view = createCustomTCView
    }
    
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewControllers()
        assignDelegates()
        configureNavBar()
        createDismissKeyboardTapGesture()
    }
        
    //MARK:- Configure Nav Bar
    func configureNavBar() {
        setupNavBar(navTitle: .createTeamComp, showSettingsButton: false)
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTeamCompTapped))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    
    //MARK: Create Dismiss Keyboard Tap Gesture
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    
    //MARK: Add Child View Controllers
    private func addChildViewControllers() {
        add(childVC: champItemSelectionVC, toStack: createCustomTCView.mainStackView)
        add(childVC: traitsController, toStack: createCustomTCView.mainStackView)
        add(childVC: selectedTeamCompVC, toStack: createCustomTCView.mainStackView)
    }
    
    
    //MARK: Assign Delegates
    private func assignDelegates() {
        selectedTeamCompVC.selectedTCDelegate = traitsController
        selectedTeamCompVC.createTCDelegate = champItemSelectionVC
        
        champItemSelectionVC.selectionVCDelegate = selectedTeamCompVC
        champItemSelectionVC.traitControllerDelegate = traitsController
        champItemSelectionVC.createTCTraitsDelegate = selectedTeamCompVC
    }
    
    
    //MARK: Save Team Comp Button Action
    @objc func saveTeamCompTapped() {
        presentSaveTeamCompAlertController()
    }
    
    
    //MARK: Present Save Alert Controller
    func presentSaveTeamCompAlertController() {
        let alertController = UIAlertController(title: "Save Team Comp", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            let title = alertController.textFields?[0].text ?? ""
            let desc = alertController.textFields?[1].text
            self?.saveAction(teamCompTitle: title, teamCompDesc: desc)
        }
        
        alertController.addTextField(configurationHandler: configureTeamCompNameTextField)
        alertController.addTextField(configurationHandler: configureTeamDescriptionTextField)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    
    
    //MARK: Save Action
    private func saveAction(teamCompTitle: String, teamCompDesc: String?) {
        let champs = self.selectedTeamCompVC.selectedChampsForTeamComp
        let traits = self.traitsController.traitsToDisplay
        let customTeamComp = CustomTeamComposition(title: teamCompTitle, description: teamCompDesc, champions: champs, traits: traits)
        self.saveCustomTeamComp(teamCompToSave: customTeamComp)
    }
    
    
    //MARK: Save Custom Team Comp
    private func saveCustomTeamComp(teamCompToSave: CustomTeamComposition) {
        PersistenceManager.createTeamComp(teamComp: teamCompToSave) { [weak self] result in
            switch result {
            case .success:
                self?.navigationController?.popViewController(animated: true)
            case .failure(let error):
                self?.presentErrorAlertOnMainThread(title: "Error Saving Team Comp", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    //MARK: Configure Name Team Comp Textfield
    func configureTeamCompNameTextField(textField: UITextField) {
        textField.placeholder = "Name this Team Comp"
        textField.textAlignment = .center
        textField.textColor = ThemeColor.platinum
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize = 12
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.tintColor = ThemeColor.platinum
        textField.layer.borderColor = ThemeColor.romanSilver.cgColor
        textField.delegate = self
    }
    
    //MARK: Configure Describe Team Comp Textfield
    func configureTeamDescriptionTextField(textField: UITextField) {
        textField.placeholder = "Describe this team comp?"
        textField.textColor = ThemeColor.platinum
        textField.font = UIFont.preferredFont(forTextStyle: .body)
    }
}


//MARK: UITextfield Delegate Methods
extension CreateNewTeamCompVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 20
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}
