//
//  PageTwoCreateTCVC.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 02/06/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

protocol CreateTCSavePageDelegate: AnyObject {
    func getChampionsForTeamComp() -> [Champion]
    func getTraitsForTeamComp() -> [Trait]
}

class CreateTCSavePageVC: UIViewController {
    
    //MARK: Properties
    private(set) var savePageView = CreateTCSavePageView()
    weak var saveDelegate: CreateTCSavePageDelegate?

    
    //MARK: Load View
    override func loadView() {
        super.loadView()
        self.view = savePageView
    }
    
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDismissKeyboardTapGesture()
        addKeyboardObservers()
        savePageView.nameTextField.delegate = self
        savePageView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    
    //MARK:- Add Keyboard Observers
    private func addKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    
    //MARK: Keyboard Observer Actions
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            savePageView.descTextView.contentInset = .zero
        } else {
            let saveButtonHeightAndPadding: CGFloat = 110
            savePageView.descTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: (keyboardViewEndFrame.height - view.safeAreaInsets.bottom) - saveButtonHeightAndPadding, right: 0)
        }

        savePageView.descTextView.scrollIndicatorInsets = savePageView.descTextView.contentInset

        let selectedRange = savePageView.descTextView.selectedRange
        savePageView.descTextView.scrollRangeToVisible(selectedRange)
    }
    
    
    //MARK: Create Dismiss Keyboard Tap Gesture
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    
    //MARK:- Save Button Tap Action
    @objc func saveButtonTapped(button: UIButton) {
        button.pulseAnimateOnTap()
        guard let teamCompTitle = savePageView.nameTextField.text else { return }
        let teamCompDesc = savePageView.descTextView.text
        guard let teamCompChamps = saveDelegate?.getChampionsForTeamComp() else { return }
        guard let teamCompTraits = saveDelegate?.getTraitsForTeamComp() else { return }
        let teamCompToSave = CustomTeamComposition(title: teamCompTitle, description: teamCompDesc, champions: teamCompChamps, traits: teamCompTraits)
        
        PersistenceManager.createTeamComp(teamComp: teamCompToSave) { [weak self] result in
            switch result {
            case .success:
                self?.navigationController?.popToRootViewController(animated: true)
                
            case.failure(let error):
                self?.presentErrorAlertOnMainThread(title: "Error Saving Team Comp", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}

//MARK: UITextField Delegate Methods
extension CreateTCSavePageVC: UITextFieldDelegate {
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 20
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}
