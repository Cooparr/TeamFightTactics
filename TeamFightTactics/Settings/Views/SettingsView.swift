//
//  SettingsView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 18/02/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class SettingsView: UIView {

    
    //MARK:- Customization Section
    let customizationLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Customization"
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        return lbl
    }()
    
    
    //MARK: Default Tab
    let defaultTabLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Default Tab:"
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .light)
        return lbl
    }()
    
    let defaultTabButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(SettingsController.defaultTabTapped), for: .touchUpInside)
        btn.setTitleColor(CustomColor.platinum, for: .normal)
        btn.backgroundColor = CustomColor.romanSilver
        btn.layer.cornerRadius = 6
        return btn
    }()
    
    
    //MARK: Set Selector
    let setSelectorLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Display Data for:"
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .light)
        return lbl
    }()
    
    let setSelector: UISegmentedControl = {
        let segCont = UISegmentedControl(items: ["Set 1", "Set 2", "Set 3"])
        segCont.addTarget(self, action: #selector(SettingsController.fetchSetData), for: .valueChanged)
        segCont.translatesAutoresizingMaskIntoConstraints = false
        return segCont
    }()
    
    
    //MARK: Set Skins
    let setSkinsLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Use Set Skins:"
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .light)
        return lbl
    }()
    
    let setSkinsInfoLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "'Off' will slightly reduce data usage."
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.systemFont(ofSize: 10, weight: .light)
        return lbl
    }()
    
    let setSkinsSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.addTarget(self, action: #selector(SettingsController.toggleSetSkins), for: .valueChanged)
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()
    
    
    //MARK: Screen Sleep
    let screenSleepLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Allow Screen to Sleep:"
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .light)
        return lbl
    }()
    
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
        view.backgroundColor = CustomColor.romanSilver
        return view
    }()
    
    
    //MARK:- Patch Info Section
    let patchInfoLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Patch Information"
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        return lbl
    }()
    
    let setOneLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Set One"
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .light)
        lbl.textAlignment = .center
        return lbl
    }()
    
    let setOnePatchNumber: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = Constants.setOnePatchNumber
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        lbl.textAlignment = .center
        return lbl
    }()
    
    let setTwoLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Set Two"
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .light)
        lbl.textAlignment = .center
        return lbl
    }()
    
    let setTwoPatchNumber: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = Constants.setTwoPatchNumber
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        lbl.textAlignment = .center
        return lbl
    }()
    
    let setThreeLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Set Three"
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .light)
        lbl.textAlignment = .center
        return lbl
    }()
    
    let setThreePatchNumber: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = Constants.setThreePatchNumber
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        lbl.textAlignment = .center
        return lbl
    }()
    
    
    //MARK: Divider Line Two
    let dividerLineTwo: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = CustomColor.romanSilver
        return view
    }()
    
    
    //MARK:- Feedback Section
    let feedbackLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Feedback"
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        return lbl
    }()
    
    let ratingLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = """
        Leave a rating, review
        or suggestion here:
        """
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .light)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let ratingButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(SettingsController.ratingTapped), for: .touchUpInside)
        btn.setTitle("Review", for: .normal)
        btn.setTitle("Thanks!", for: .highlighted)
        btn.setTitleColor(CustomColor.platinum, for: .normal)
        btn.backgroundColor = CustomColor.romanSilver
        btn.layer.cornerRadius = 6
        return btn
    }()
    
    
    //MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = CustomColor.richBlack
        
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
        addSubview(defaultTabLabel)
        addSubview(defaultTabButton)
        
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
        addSubview(setSelectorLabel)
        addSubview(setSelector)
        
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
        addSubview(setSkinsLabel)
        addSubview(setSkinsInfoLabel)
        addSubview(setSkinsSwitch)
        
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
        addSubview(screenSleepLabel)
        addSubview(screenSleepSwitch)
        
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
        addSubview(setOnePatchNumber)
        addSubview(setTwoPatchNumber)
        addSubview(setThreePatchNumber)
        
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
            setThreePatchNumber.bottomAnchor.constraint(equalTo: setThreeLabel.bottomAnchor)
        ])
        
        addSubview(dividerLineTwo)
        NSLayoutConstraint.activate([
            dividerLineTwo.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 3/4),
            dividerLineTwo.heightAnchor.constraint(equalToConstant: 1),
            dividerLineTwo.topAnchor.constraint(equalTo: setThreePatchNumber.bottomAnchor, constant: 30),
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
        addSubview(ratingLabel)
        addSubview(ratingButton)
        
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: feedbackLabel.bottomAnchor, constant: 20),
            ratingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            ratingButton.widthAnchor.constraint(equalToConstant: 90),
            ratingButton.topAnchor.constraint(equalTo: ratingLabel.topAnchor),
            ratingButton.bottomAnchor.constraint(equalTo: ratingLabel.bottomAnchor),
            ratingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



