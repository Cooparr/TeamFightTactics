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
    weak var saveDelegate: CreateTCSavePageDelegate?
    let nameView: BaseView = {
        let view = BaseView(tamic: false, backgroundColor: ThemeColor.charcoal, cornerRadius: 10)
        view.layer.borderWidth = 0.5
        view.layer.borderColor = ThemeColor.romanSilver.cgColor
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = ThemeColor.platinum
        label.text = "Name Team Composition"
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = ThemeColor.richBlack
        textField.placeholder = "e.g. Six Brawlers"
        textField.textAlignment = .center
        textField.textColor = ThemeColor.platinum
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize = 12
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.tintColor = ThemeColor.platinum
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    let descView: BaseView = {
        let view = BaseView(tamic: false, backgroundColor: ThemeColor.charcoal, cornerRadius: 10)
        view.layer.borderWidth = 0.5
        view.layer.borderColor = ThemeColor.romanSilver.cgColor
        return view
    }()
    
    let descLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.preferredFont(forTextStyle: .headline)
        lbl.textColor = ThemeColor.platinum
        lbl.text = "Describe Team Composition"
        return lbl
    }()    
    
    let descTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = ThemeColor.richBlack
        textView.layer.cornerRadius = 10
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.tintColor = ThemeColor.platinum
        textView.addDoneButtonOnKeyboard()
        return textView
    }()
    
    let saveButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = ThemeColor.romanSilver
        btn.setTitle("Save Team Comp", for: .normal)
        btn.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        btn.setTitleColor(ThemeColor.platinum, for: .normal)
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = ThemeColor.richBlack
        createDismissKeyboardTapGesture()
        
        
        addKeyboardObservers()
        
        nameTextField.delegate = self
        
        constrainNameView()
        constrainSaveButton()
        constrainDescView()
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    
    //MARK:- Constraint Code
    private func constrainNameView() {
        view.addSubview(nameView)
        NSLayoutConstraint.activate([
            nameView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            nameView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            nameView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        nameView.addSubviews(nameLabel, nameTextField)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: nameView.topAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: nameView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: nameView.trailingAnchor, constant: -10),
            nameLabel.bottomAnchor.constraint(equalTo: nameTextField.topAnchor, constant: -5),
            nameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            nameTextField.leadingAnchor.constraint(equalTo: nameView.leadingAnchor, constant: 10),
            nameTextField.trailingAnchor.constraint(equalTo: nameView.trailingAnchor, constant: -10),
            nameTextField.bottomAnchor.constraint(equalTo: nameView.bottomAnchor, constant: -10)
        ])
    }
    
    
    private func constrainSaveButton() {
        view.addSubview(saveButton)
        NSLayoutConstraint.activate([
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ])
    }
    
    private func constrainDescView() {
        view.addSubview(descView)
        NSLayoutConstraint.activate([
            descView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 20),
            descView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            descView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -20)
        ])
        
        descView.addSubviews(descLabel, descTextView)
        NSLayoutConstraint.activate([
            descLabel.topAnchor.constraint(equalTo: descView.topAnchor, constant: 5),
            descLabel.leadingAnchor.constraint(equalTo: descView.leadingAnchor, constant: 10),
            descLabel.trailingAnchor.constraint(equalTo: descView.trailingAnchor, constant: -10),
            descLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            descTextView.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 5),
            descTextView.leadingAnchor.constraint(equalTo: descView.leadingAnchor, constant: 10),
            descTextView.trailingAnchor.constraint(equalTo: descView.trailingAnchor, constant: -10),
            descTextView.bottomAnchor.constraint(equalTo: descView.bottomAnchor, constant: -10)
        ])
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
            descTextView.contentInset = .zero
        } else {
            let saveButtonHeightAndPadding: CGFloat = 110
            descTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: (keyboardViewEndFrame.height - view.safeAreaInsets.bottom) - saveButtonHeightAndPadding, right: 0)
        }

        descTextView.scrollIndicatorInsets = descTextView.contentInset

        let selectedRange = descTextView.selectedRange
        descTextView.scrollRangeToVisible(selectedRange)
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
        guard let teamCompTitle = nameTextField.text else { return }
        let teamCompDesc = descTextView.text
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

//MARK: UITextfield Delegate Methods
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
