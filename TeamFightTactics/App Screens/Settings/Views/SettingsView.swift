//
//  SettingsView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 18/02/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class SettingsView: BaseView {

    //MARK:- Customization Section
    let customizationLabel = BaseLabel(fontSize: 22, fontWeight: .medium, lblText: "Customization")
    
    
    //MARK: Default Tab
    let defaultTabLabel = BaseLabel(fontSize: 16, fontWeight: .light, lblText: "Default Tab:")
    let defaultTabButton: BaseButton = {
        let btn = BaseButton(fontSize: 18, fontWeight: .semibold, cornerRadius: 6)
        btn.addTarget(self, action: #selector(SettingsController.defaultTabTapped), for: .touchUpInside)
        return btn
    }()
    
    
    //MARK: Set Selector
    let setSelectorLabel = BaseLabel(fontSize: 16, fontWeight: .light, lblText: "Show Data for Set:")
    let setSelectorButton: BaseButton = {
        let btn = BaseButton(fontSize: 18, fontWeight: .semibold, cornerRadius: 6)
        btn.addTarget(self, action: #selector(SettingsController.setSelectorTapped), for: .touchUpInside)
        return btn
    }()
    
    
    //MARK: Set Skins
    let setSkinsLabel = BaseLabel(fontSize: 16, fontWeight: .light, lblText: "Use Set Skins:")
    let setSkinsInfoLabel = BaseLabel(fontSize: 10, fontWeight: .light, lblText: "Will slightly reduce data usage when disabled.")
    let setSkinsSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.addTarget(self, action: #selector(SettingsController.toggleSetSkins), for: .valueChanged)
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()
    
    
    //MARK: Screen Sleep
    let screenSleepLabel = BaseLabel(fontSize: 16, fontWeight: .light, lblText: "Allow Screen to Sleep:")
    let screenSleepSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.addTarget(self, action: #selector(SettingsController.toggleScreenSleep), for: .valueChanged)
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()
    
    
    //MARK: Divider Lines
    let dividerLine = BaseView(backgroundColor: ThemeColor.romanSilver)
    let dividerLineTwo = BaseView(backgroundColor: ThemeColor.romanSilver)

    
    //MARK:- Patch Info Section
    let patchInfoLabel = BaseLabel(fontSize: 22, fontWeight: .medium, lblText: "Patch Information")
    let patchInfoMainStack = BaseStack(axis: .vertical, spacing: 6)
    
    
    //MARK:- Feedback Section
    let feedbackLabel = BaseLabel(fontSize: 22, fontWeight: .medium, lblText: "Feedback")
    let ratingLabel = BaseLabel(fontSize: 16, fontWeight: .light, lblText: """
        Leave a rating, review
        or suggestion here:
        """, multiLine: true)
    
    let ratingButton: BaseButton = {
        let btn = BaseButton(fontSize: 18, fontWeight: .semibold, cornerRadius: 6)
        btn.addTarget(self, action: #selector(SettingsController.ratingTapped), for: .touchUpInside)
        btn.setTitle("Review", for: .normal)
        btn.setTitle("Thanks!", for: .highlighted)
        return btn
    }()
    
    
    //MARK:- Create Patch Info Rows
    private func createPatchInfoRows() {
        TFTSet.allCases.forEach { set in
            let rowStack = UIStackView(arrangedSubviews: createPatchLabels(set))
            rowStack.translatesAutoresizingMaskIntoConstraints = false
            rowStack.axis = .horizontal
            rowStack.distribution = .fillEqually
            rowStack.spacing = 6
            patchInfoMainStack.addArrangedSubview(rowStack)
        }
    }
    
    
    //MARK: Create Patch Labels
    private func createPatchLabels(_ setNumber: TFTSet) -> [BaseLabel] {
        let patchLabel = BaseLabel(fontSize: 16, fontWeight: .light)
        patchLabel.textAlignment = .center
        patchLabel.text = "Set \(setNumber.rawValue.removePointZero)"

        let patchNumberLabel = BaseLabel(fontSize: 16, fontWeight: .light)
        patchNumberLabel.textAlignment = .center
        patchNumberLabel.text = setNumber.getPatchNumber()
        
        return [patchLabel, patchNumberLabel]
    }
    
    
    //MARK: Setup Subviews
    override func setupSubviews() {
        layoutCustomizationSection()
        layoutPatchInfoSection()
        layoutFeedbackSection()
    }
    
    
    //MARK: Layout Customization Section
    fileprivate func layoutCustomizationSection() {
        addSubview(customizationLabel)
        NSLayoutConstraint.activate([
            customizationLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            customizationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
        
        layoutDefaultTab()
        layoutSetSelector()
        layoutSetSkins()
        layoutScreenSleep()
    }
    
    
    //MARK: Layout Default Tab
    fileprivate func layoutDefaultTab() {
        addSubviews(defaultTabLabel, defaultTabButton)
        NSLayoutConstraint.activate([
            defaultTabLabel.centerYAnchor.constraint(equalTo: defaultTabButton.centerYAnchor),
            defaultTabLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            defaultTabLabel.trailingAnchor.constraint(equalTo: centerXAnchor),
            
            defaultTabButton.heightAnchor.constraint(equalToConstant: 32),
            defaultTabButton.topAnchor.constraint(equalTo: customizationLabel.bottomAnchor, constant: 20),
            defaultTabButton.leadingAnchor.constraint(equalTo: centerXAnchor),
            defaultTabButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    
    //MARK: Layout Set Selector
    fileprivate func layoutSetSelector() {
        addSubviews(setSelectorLabel, setSelectorButton)
        NSLayoutConstraint.activate([
            setSelectorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            setSelectorLabel.topAnchor.constraint(equalTo: setSelectorButton.topAnchor),
            setSelectorLabel.bottomAnchor.constraint(equalTo: setSelectorButton.bottomAnchor),
            setSelectorLabel.widthAnchor.constraint(equalToConstant: 150),
            
            setSelectorButton.heightAnchor.constraint(equalToConstant: 32),
            setSelectorButton.leadingAnchor.constraint(equalTo: defaultTabButton.leadingAnchor),
            setSelectorButton.topAnchor.constraint(equalTo: defaultTabButton.bottomAnchor, constant: 20),
            setSelectorButton.trailingAnchor.constraint(equalTo: defaultTabButton.trailingAnchor)
        ])
    }
    
    
    //MARK: Layout Set Skins
    fileprivate func layoutSetSkins() {
        addSubviews(setSkinsLabel, setSkinsInfoLabel, setSkinsSwitch)
        NSLayoutConstraint.activate([
            setSkinsLabel.centerYAnchor.constraint(equalTo: setSkinsSwitch.centerYAnchor),
            setSkinsLabel.leadingAnchor.constraint(equalTo: setSelectorLabel.leadingAnchor),
            setSkinsLabel.trailingAnchor.constraint(equalTo: centerXAnchor),
            
            setSkinsInfoLabel.topAnchor.constraint(equalTo: setSkinsLabel.bottomAnchor),
            setSkinsInfoLabel.leadingAnchor.constraint(equalTo: setSkinsLabel.leadingAnchor),

            setSkinsSwitch.centerXAnchor.constraint(equalTo: defaultTabButton.centerXAnchor),
            setSkinsSwitch.topAnchor.constraint(equalTo: setSelectorButton.bottomAnchor, constant: 20)
        ])
    }
    
    
    //MARK: Layout Screen Sleep
    fileprivate func layoutScreenSleep() {
        addSubviews(screenSleepLabel, screenSleepSwitch)
        NSLayoutConstraint.activate([
            screenSleepLabel.centerYAnchor.constraint(equalTo: screenSleepSwitch.centerYAnchor),
            screenSleepLabel.leadingAnchor.constraint(equalTo: setSelectorLabel.leadingAnchor),
            screenSleepLabel.trailingAnchor.constraint(equalTo: centerXAnchor),

            screenSleepSwitch.centerXAnchor.constraint(equalTo: defaultTabButton.centerXAnchor),
            screenSleepSwitch.topAnchor.constraint(equalTo: setSkinsSwitch.bottomAnchor, constant: 20)
        ])
        
        
        addSubview(dividerLine)
        NSLayoutConstraint.activate([
            dividerLine.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 3/4),
            dividerLine.heightAnchor.constraint(equalToConstant: 1),
            dividerLine.topAnchor.constraint(equalTo: screenSleepSwitch.bottomAnchor, constant: 30),
            dividerLine.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    
    //MARK:- Layout Patch Information
    fileprivate func layoutPatchInfoSection() {
        addSubview(patchInfoLabel)
        NSLayoutConstraint.activate([
            patchInfoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            patchInfoLabel.topAnchor.constraint(equalTo: dividerLine.bottomAnchor, constant: 20)
        ])
        
        layoutPatchLabels()
    }
    
    
    //MARK: Layout Patch Labels
    fileprivate func layoutPatchLabels() {
        addSubview(patchInfoMainStack)
        
        createPatchInfoRows()
        NSLayoutConstraint.activate([
            patchInfoMainStack.topAnchor.constraint(equalTo: patchInfoLabel.bottomAnchor, constant: 15),
            patchInfoMainStack.leadingAnchor.constraint(equalTo: dividerLine.leadingAnchor),
            patchInfoMainStack.trailingAnchor.constraint(equalTo: dividerLine.trailingAnchor)
        ])
        
        addSubview(dividerLineTwo)
        NSLayoutConstraint.activate([
            dividerLineTwo.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 3/4),
            dividerLineTwo.heightAnchor.constraint(equalToConstant: 1),
            dividerLineTwo.topAnchor.constraint(equalTo: patchInfoMainStack.bottomAnchor, constant: 30),
            dividerLineTwo.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    
    //MARK:- Layout Feedback Section
    fileprivate func layoutFeedbackSection() {
        addSubview(feedbackLabel)
        NSLayoutConstraint.activate([
            feedbackLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            feedbackLabel.topAnchor.constraint(equalTo: dividerLineTwo.bottomAnchor, constant: 20)
        ])
        
        layoutRating()
    }
    
    
    fileprivate func layoutRating() {
        addSubviews(ratingLabel, ratingButton)
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: feedbackLabel.bottomAnchor, constant: 20),
            ratingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            ratingButton.widthAnchor.constraint(equalTo: defaultTabButton.widthAnchor),
            ratingButton.topAnchor.constraint(equalTo: ratingLabel.topAnchor),
            ratingButton.bottomAnchor.constraint(equalTo: ratingLabel.bottomAnchor),
            ratingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}
