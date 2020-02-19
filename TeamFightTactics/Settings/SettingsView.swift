//
//  SettingsView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 18/02/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class SettingsView: UIView {

    //MARK:- Properties
    let setSelectorLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Display Data for:"
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return lbl
    }()
    
    let setSelector: UISegmentedControl = {
        let segCont = UISegmentedControl(items: ["Set 1", "Set 2", "Set 3"])
        segCont.addTarget(self, action: #selector(SettingsController.fetchSetData), for: .valueChanged)
        segCont.translatesAutoresizingMaskIntoConstraints = false
        segCont.setEnabled(false, forSegmentAt: 2)
        return segCont
    }()
    
    let screenSleepLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Allow Screen to Sleep:"
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return lbl
    }()
    
    let screenSleepToggle: UISwitch = {
        let toggle = UISwitch()
        toggle.addTarget(self, action: #selector(SettingsController.toggleScreenSleep), for: .valueChanged)
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()
    
    let setOneLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Set One"
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        lbl.textAlignment = .center
        lbl.backgroundColor = CustomColor.romanSilver
        lbl.layer.cornerRadius = 2
        lbl.layer.masksToBounds = true
        return lbl
    }()
    
    let setOnePatchNumber: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "9.21"
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return lbl
    }()
    
    let setTwoLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Set Two"
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        lbl.textAlignment = .center
        lbl.backgroundColor = CustomColor.romanSilver
        lbl.layer.cornerRadius = 2
        lbl.layer.masksToBounds = true
        return lbl
    }()
    
    let setTwoPatchNumber: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "10.2"
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return lbl
    }()
    
    let setThreeLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Set Three"
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        lbl.textAlignment = .center
        lbl.backgroundColor = CustomColor.romanSilver
        lbl.layer.cornerRadius = 2
        lbl.layer.masksToBounds = true
        return lbl
    }()
    
    let setThreePatchNumber: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Pending"
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return lbl
    }()
    
    
    
    
    
    //MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = CustomColor.richBlack
        layoutSetSelector()
        layoutScreenSleep()
//        layoutPatchInformation()
    }
    
    
    //MARK: Layout Set Selector
    fileprivate func layoutSetSelector() {
        addSubview(setSelectorLabel)
        addSubview(setSelector)
        
        NSLayoutConstraint.activate([
            setSelectorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            setSelectorLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            setSelectorLabel.trailingAnchor.constraint(equalTo: centerXAnchor),
            setSelectorLabel.bottomAnchor.constraint(equalTo: setSelector.bottomAnchor),
            
            setSelector.leadingAnchor.constraint(equalTo: centerXAnchor),
            setSelector.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            setSelector.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    //MARK: Layout Screen Sleep
    fileprivate func layoutScreenSleep() {
        addSubview(screenSleepLabel)
        addSubview(screenSleepToggle)
        
        NSLayoutConstraint.activate([
            screenSleepLabel.leadingAnchor.constraint(equalTo: setSelectorLabel.leadingAnchor),
            screenSleepLabel.topAnchor.constraint(equalTo: screenSleepToggle.topAnchor),
            screenSleepLabel.trailingAnchor.constraint(equalTo: centerXAnchor),

            screenSleepToggle.centerXAnchor.constraint(equalTo: setSelector.centerXAnchor),
            screenSleepToggle.topAnchor.constraint(equalTo: setSelector.bottomAnchor, constant: 20),
        ])
    }
    
    
    //MARK:- Layout Patch Information
    fileprivate func layoutPatchInformation() {
        setOnePatchNumber.backgroundColor = .red
        setTwoPatchNumber.backgroundColor = .red
        setThreePatchNumber.backgroundColor = .red
        
        addSubview(setOneLabel)
        addSubview(setTwoLabel)
        addSubview(setThreeLabel)
        addSubview(setOnePatchNumber)
        addSubview(setTwoPatchNumber)
        addSubview(setThreePatchNumber)
        
        let height: CGFloat = 24
        let width: CGFloat = 100
        NSLayoutConstraint.activate([
            setOneLabel.heightAnchor.constraint(equalToConstant: height),
            setOneLabel.widthAnchor.constraint(equalToConstant: width),
            setOneLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            setOneLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),

            setOnePatchNumber.topAnchor.constraint(equalTo: setOneLabel.topAnchor),
            setOnePatchNumber.leadingAnchor.constraint(equalTo: setOneLabel.trailingAnchor, constant: 10),
            setOnePatchNumber.bottomAnchor.constraint(equalTo: setOneLabel.bottomAnchor),

            setTwoLabel.heightAnchor.constraint(equalToConstant: height),
            setTwoLabel.widthAnchor.constraint(equalToConstant: width),
            setTwoLabel.topAnchor.constraint(equalTo: setOneLabel.bottomAnchor, constant: 10),
            setTwoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),

            setTwoPatchNumber.topAnchor.constraint(equalTo: setTwoLabel.topAnchor),
            setTwoPatchNumber.leadingAnchor.constraint(equalTo: setTwoLabel.trailingAnchor, constant: 10),
            setTwoPatchNumber.bottomAnchor.constraint(equalTo: setTwoLabel.bottomAnchor),

            setThreeLabel.heightAnchor.constraint(equalToConstant: height),
            setThreeLabel.widthAnchor.constraint(equalToConstant: width),
            setThreeLabel.topAnchor.constraint(equalTo: setTwoLabel.bottomAnchor, constant: 10),
            setThreeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),

            setThreePatchNumber.topAnchor.constraint(equalTo: setThreeLabel.topAnchor),
            setThreePatchNumber.leadingAnchor.constraint(equalTo: setThreeLabel.trailingAnchor, constant: 10),
            setThreePatchNumber.bottomAnchor.constraint(equalTo: setThreeLabel.bottomAnchor)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
