//
//  CreateTCSavePageView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 09/06/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class CreateTCSavePageView: UIView {
    
    //MARK:- Properties
    let contentsStack = BaseStack(axis: .vertical, distribution: .fill, alignment: .leading, spacing: 20)
    let nameSectionContainerView: BaseView = {
        let view = BaseView(tamic: false, backgroundColor: ThemeColor.charcoal, cornerRadius: 10)
        view.layer.borderWidth = 0.5
        view.layer.borderColor = ThemeColor.romanSilver.cgColor
        return view
    }()
    
    let nameLabel = BaseLabel(textStyleFont: .headline, text: "Name Team Composition")
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
    
    private let descSectionContainerView: BaseView = {
        let view = BaseView(tamic: false, backgroundColor: ThemeColor.charcoal, cornerRadius: 10)
        view.layer.borderWidth = 0.5
        view.layer.borderColor = ThemeColor.romanSilver.cgColor
        return view
    }()
    
    let descriptionMaxCharacters = 140
    let descLabel = BaseLabel(textStyleFont: .headline, text: "Describe Team Composition")
    lazy var descCountLabel: BaseLabel = {
        let lbl = BaseLabel(fontSize: 13, fontWeight: .regular, fontColor: ThemeColor.romanSilver, lblText: "\(descriptionMaxCharacters)", textAlignment: .center)
        lbl.backgroundColor = ThemeColor.richBlack
        lbl.layer.cornerRadius = 10
        lbl.layer.cornerCurve = .continuous
        lbl.clipsToBounds = true
        return lbl
    }()
    
    lazy var descTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = ThemeColor.richBlack
        textView.layer.cornerRadius = 10
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.tintColor = ThemeColor.platinum
        textView.delegate = self
        textView.addDoneButtonOnKeyboard()
        return textView
    }()
    
    let saveButton: BaseButton = {
        let btn = BaseButton(textStyle: .headline, cornerRadius: 10)
        btn.setTitle("Save Team Comp", for: .normal)
        return btn
    }()
    
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ThemeColor.richBlack
        constrainContentStackView()
        constrainNameView()
        constrainDescView()
    }
    
    
    //MARK:- Constrain StackView & Save Button
    private func constrainContentStackView() {
        addSubview(contentsStack)
        contentsStack.addArrangedSubviews(nameSectionContainerView, descSectionContainerView, saveButton)
        contentsStack.pinSubviewWithPadding(to: self, top: 10, leading: 10, trailing: -10, bottom: -40)
        
        NSLayoutConstraint.activate([
            nameSectionContainerView.widthAnchor.constraint(equalTo: contentsStack.widthAnchor),
            descSectionContainerView.widthAnchor.constraint(equalTo: contentsStack.widthAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.widthAnchor.constraint(equalTo: contentsStack.widthAnchor)
        ])
    }
    
    
    //MARK: Constrain Name View
    private func constrainNameView() {
        nameSectionContainerView.addSubviews(nameLabel, nameTextField)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: nameSectionContainerView.topAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: nameSectionContainerView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: nameSectionContainerView.trailingAnchor, constant: -10),
            nameLabel.bottomAnchor.constraint(equalTo: nameTextField.topAnchor, constant: -5),
            nameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])

        NSLayoutConstraint.activate([
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            nameTextField.leadingAnchor.constraint(equalTo: nameSectionContainerView.leadingAnchor, constant: 10),
            nameTextField.trailingAnchor.constraint(equalTo: nameSectionContainerView.trailingAnchor, constant: -10),
            nameTextField.bottomAnchor.constraint(equalTo: nameSectionContainerView.bottomAnchor, constant: -10)
        ])
    }
    
    
    //MARK: Constrain Desc View
    private func constrainDescView() {
        descSectionContainerView.addSubviews(descLabel, descTextView, descCountLabel)
        NSLayoutConstraint.activate([
            descLabel.topAnchor.constraint(equalTo: descSectionContainerView.topAnchor, constant: 5),
            descLabel.leadingAnchor.constraint(equalTo: descSectionContainerView.leadingAnchor, constant: 10),
            descLabel.trailingAnchor.constraint(equalTo: descSectionContainerView.trailingAnchor, constant: -10),
            descLabel.heightAnchor.constraint(equalToConstant: 40)
        ])

        NSLayoutConstraint.activate([
            descCountLabel.widthAnchor.constraint(equalToConstant: 45),
            descCountLabel.heightAnchor.constraint(equalToConstant: 25),
            descCountLabel.centerYAnchor.constraint(equalTo: descLabel.centerYAnchor),
            descCountLabel.trailingAnchor.constraint(equalTo: descSectionContainerView.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            descTextView.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 5),
            descTextView.leadingAnchor.constraint(equalTo: descSectionContainerView.leadingAnchor, constant: 10),
            descTextView.trailingAnchor.constraint(equalTo: descSectionContainerView.trailingAnchor, constant: -10),
            descTextView.bottomAnchor.constraint(equalTo: descSectionContainerView.bottomAnchor, constant: -10)
        ])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: UITextView Delegates
extension CreateTCSavePageView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        descCountLabel.text = "\(descriptionMaxCharacters - textView.text.count)"
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textView.text.count + (text.count - range.length) <= descriptionMaxCharacters
    }
}
