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
    let defaultTabButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(SettingsController.defaultTabTapped), for: .touchUpInside)
        btn.setTitleColor(ThemeColor.platinum, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 15)
        btn.backgroundColor = ThemeColor.romanSilver
        btn.layer.cornerRadius = 6
        return btn
    }()
    
    
    //MARK: Set Selector
    let setSelectorLabel = BaseLabel(fontSize: 16, fontWeight: .light, lblText: "Display Data for:")
    let setSelector: UISegmentedControl = {
        let segCont = UISegmentedControl(items: ["Set 1", "Set 2", "Set 3", "Set 4"])
        segCont.addTarget(self, action: #selector(SettingsController.fetchSetData), for: .valueChanged)
        segCont.translatesAutoresizingMaskIntoConstraints = false
        segCont.selectedSegmentTintColor = ThemeColor.romanSilver
        let selectedFontColor = [NSAttributedString.Key.foregroundColor: ThemeColor.romanSilver]
        let unselectedFontColor = [NSAttributedString.Key.foregroundColor: ThemeColor.platinum]
        segCont.setTitleTextAttributes(selectedFontColor, for:.normal)
        segCont.setTitleTextAttributes(unselectedFontColor, for:.selected)
        return segCont
    }()
    
    
    //MARK: Set Skins
    let setSkinsLabel = BaseLabel(fontSize: 16, fontWeight: .light, lblText: "Use Set Skins:")
    let setSkinsInfoLabel = BaseLabel(fontSize: 10, fontWeight: .light, lblText: "'Off' will slightly reduce data usage.")
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
    
    
    //MARK: Divider Line
    let dividerLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ThemeColor.romanSilver
        return view
    }()
    
    
    //MARK:- Patch Info Section
    let patchInfoLabel: BaseLabel = {
        let lbl = BaseLabel(fontSize: 22, fontWeight: .medium)
        lbl.text = "Patch Information"
        return lbl
    }()
    
    let setOneLabel: BaseLabel = {
        let lbl = BaseLabel(fontSize: 16, fontWeight: .light)
        lbl.text = "Set One"
        lbl.textAlignment = .center
        return lbl
    }()
    
    let setOnePatchNumber: BaseLabel = {
        let lbl = BaseLabel(fontSize: 16, fontWeight: .light)
        lbl.text = PatchNumber.setOne
        lbl.textAlignment = .center
        return lbl
    }()
    
    let setTwoLabel: BaseLabel = {
        let lbl = BaseLabel(fontSize: 16, fontWeight: .light)
        lbl.text = "Set Two"
        lbl.textAlignment = .center
        return lbl
    }()
    
    let setTwoPatchNumber: BaseLabel = {
        let lbl = BaseLabel(fontSize: 16, fontWeight: .light)
        lbl.text = PatchNumber.setTwo
        lbl.textAlignment = .center
        return lbl
    }()
    
    let setThreeLabel: BaseLabel = {
        let lbl = BaseLabel(fontSize: 16, fontWeight: .light)
        lbl.text = "Set Three"
        lbl.textAlignment = .center
        return lbl
    }()
    
    let setThreePatchNumber: BaseLabel = {
        let lbl = BaseLabel(fontSize: 16, fontWeight: .light)
        lbl.text = PatchNumber.setThree
        lbl.textAlignment = .center
        return lbl
    }()
    
    let setFourLabel: BaseLabel = {
        let lbl = BaseLabel(fontSize: 16, fontWeight: .light)
        lbl.text = "Set Four"
        lbl.textAlignment = .center
        return lbl
    }()
    
    let setFourPatchNumber: BaseLabel = {
        let lbl = BaseLabel(fontSize: 16, fontWeight: .light)
        lbl.text = PatchNumber.setFour
        lbl.textAlignment = .center
        return lbl
    }()
    
    
    //MARK: Divider Line Two
    let dividerLineTwo: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ThemeColor.romanSilver
        return view
    }()
    
    
    //MARK:- Feedback Section
    let feedbackLabel = BaseLabel(fontSize: 22, fontWeight: .medium, lblText: "Feedback")
    let ratingLabel = BaseLabel(fontSize: 16, fontWeight: .light, lblText: """
        Leave a rating, review
        or suggestion here:
        """, multiLine: true)
    
    let ratingButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(SettingsController.ratingTapped), for: .touchUpInside)
        btn.setTitle("Review", for: .normal)
        btn.setTitle("Thanks!", for: .highlighted)
        btn.setTitleColor(ThemeColor.platinum, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 15)
        btn.backgroundColor = ThemeColor.romanSilver
        btn.layer.cornerRadius = 6
        return btn
    }()
    
    
    //MARK:- Setup View
    override func setupView() {
        backgroundColor = ThemeColor.richBlack
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
        addSubviews(setSelectorLabel, setSelector)
        NSLayoutConstraint.activate([
            setSelectorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            setSelectorLabel.topAnchor.constraint(equalTo: setSelector.topAnchor),
            setSelectorLabel.trailingAnchor.constraint(equalTo: centerXAnchor),
            setSelectorLabel.bottomAnchor.constraint(equalTo: setSelector.bottomAnchor),
            
            setSelector.leadingAnchor.constraint(equalTo: centerXAnchor),
            setSelector.topAnchor.constraint(equalTo: defaultTabButton.bottomAnchor, constant: 20),
            setSelector.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
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

            setSkinsSwitch.centerXAnchor.constraint(equalTo: setSelector.centerXAnchor),
            setSkinsSwitch.topAnchor.constraint(equalTo: setSelector.bottomAnchor, constant: 20)
        ])
    }
    
    
    //MARK: Layout Screen Sleep
    fileprivate func layoutScreenSleep() {
        addSubviews(screenSleepLabel, screenSleepSwitch)
        NSLayoutConstraint.activate([
            screenSleepLabel.centerYAnchor.constraint(equalTo: screenSleepSwitch.centerYAnchor),
            screenSleepLabel.leadingAnchor.constraint(equalTo: setSelectorLabel.leadingAnchor),
            screenSleepLabel.trailingAnchor.constraint(equalTo: centerXAnchor),

            screenSleepSwitch.centerXAnchor.constraint(equalTo: setSelector.centerXAnchor),
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
        addSubview(setOneLabel)
        addSubview(setTwoLabel)
        addSubview(setThreeLabel)
        addSubview(setFourLabel)
        addSubview(setOnePatchNumber)
        addSubview(setTwoPatchNumber)
        addSubview(setThreePatchNumber)
        addSubview(setFourPatchNumber)
        
        NSLayoutConstraint.activate([
            setOneLabel.leadingAnchor.constraint(equalTo: dividerLine.leadingAnchor),
            setOneLabel.topAnchor.constraint(equalTo: patchInfoLabel.bottomAnchor, constant: 20),
            setOneLabel.trailingAnchor.constraint(equalTo: centerXAnchor),
            
            setOnePatchNumber.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 10),
            setOnePatchNumber.topAnchor.constraint(equalTo: setOneLabel.topAnchor),
            setOnePatchNumber.trailingAnchor.constraint(equalTo: dividerLine.trailingAnchor),
            setOnePatchNumber.bottomAnchor.constraint(equalTo: setOneLabel.bottomAnchor),
            
            setTwoLabel.leadingAnchor.constraint(equalTo: dividerLine.leadingAnchor),
            setTwoLabel.topAnchor.constraint(equalTo: setOneLabel.bottomAnchor, constant: 10),
            setTwoLabel.trailingAnchor.constraint(equalTo: centerXAnchor),
            
            setTwoPatchNumber.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 10),
            setTwoPatchNumber.topAnchor.constraint(equalTo: setTwoLabel.topAnchor),
            setTwoPatchNumber.trailingAnchor.constraint(equalTo: dividerLine.trailingAnchor),
            setTwoPatchNumber.bottomAnchor.constraint(equalTo: setTwoLabel.bottomAnchor),
            
            setThreeLabel.leadingAnchor.constraint(equalTo: dividerLine.leadingAnchor),
            setThreeLabel.topAnchor.constraint(equalTo: setTwoLabel.bottomAnchor, constant: 10),
            setThreeLabel.trailingAnchor.constraint(equalTo: centerXAnchor),
            
            setThreePatchNumber.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 10),
            setThreePatchNumber.topAnchor.constraint(equalTo: setThreeLabel.topAnchor),
            setThreePatchNumber.trailingAnchor.constraint(equalTo: dividerLine.trailingAnchor),
            setThreePatchNumber.bottomAnchor.constraint(equalTo: setThreeLabel.bottomAnchor),
            
            setFourLabel.leadingAnchor.constraint(equalTo: dividerLine.leadingAnchor),
            setFourLabel.topAnchor.constraint(equalTo: setThreeLabel.bottomAnchor, constant: 10),
            setFourLabel.trailingAnchor.constraint(equalTo: centerXAnchor),
            
            setFourPatchNumber.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 10),
            setFourPatchNumber.topAnchor.constraint(equalTo: setFourLabel.topAnchor),
            setFourPatchNumber.trailingAnchor.constraint(equalTo: dividerLine.trailingAnchor),
            setFourPatchNumber.bottomAnchor.constraint(equalTo: setFourLabel.bottomAnchor)
        ])
        
        addSubview(dividerLineTwo)
        NSLayoutConstraint.activate([
            dividerLineTwo.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 3/4),
            dividerLineTwo.heightAnchor.constraint(equalToConstant: 1),
            dividerLineTwo.topAnchor.constraint(equalTo: setFourPatchNumber.bottomAnchor, constant: 30),
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
            
            ratingButton.widthAnchor.constraint(equalToConstant: 90),
            ratingButton.topAnchor.constraint(equalTo: ratingLabel.topAnchor),
            ratingButton.bottomAnchor.constraint(equalTo: ratingLabel.bottomAnchor),
            ratingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}



