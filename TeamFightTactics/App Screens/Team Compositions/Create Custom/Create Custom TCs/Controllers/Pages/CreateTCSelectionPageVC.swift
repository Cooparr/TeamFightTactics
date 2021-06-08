//
//  CreateCustomTeamCompVC.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 02/06/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class CreateTCSelectionPageVC: UIViewController {
    
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
        setupNavBar(navTitle: .createTeamComp, showSettingsButton: false)
        createDismissKeyboardTapGesture()
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
extension CreateTCSelectionPageVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 20
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}


extension CreateTCSelectionPageVC: CreateTCSavePageDelegate {
    func getChampionsForTeamComp() -> [Champion] {
        return self.selectedTeamCompVC.selectedChampsForTeamComp
    }
    
    func getTraitsForTeamComp() -> [Trait] {
        return self.traitsController.traitsToDisplay
    }
}
