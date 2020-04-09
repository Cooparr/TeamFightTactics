//
//  EndGameSection.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 09/04/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class EndGameSection: UIView {

    //MARK: Properties
    let endGameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "End Game"
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return lbl
    }()
    
    let endOneImage: TCDetailChampImage = TCDetailChampImage()
    let endTwoImage: TCDetailChampImage = TCDetailChampImage()
    let endThreeImage: TCDetailChampImage = TCDetailChampImage()
    let endFourImage: TCDetailChampImage = TCDetailChampImage()
    let endFiveImage: TCDetailChampImage = TCDetailChampImage()
    let endSixImage: TCDetailChampImage = TCDetailChampImage()
    let endSevenImage: TCDetailChampImage = TCDetailChampImage()
    let endEightImage: TCDetailChampImage = TCDetailChampImage()
    lazy var endGameChamps: [TCDetailChampImage] = [endOneImage, endTwoImage, endThreeImage, endFourImage, endFiveImage, endSixImage, endSevenImage, endEightImage]
    
    lazy var endGameTopStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [endOneImage, endTwoImage, endThreeImage, endFourImage])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var endGameBotStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [endFiveImage, endSixImage, endSevenImage, endEightImage])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSection()
        setupEndGameConstraints()
    }
    
    
    //MARK: Setup Section
    fileprivate func setupSection() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = CustomColor.richBlack
    }
    
    
    //MARK: Setup End Game Constraints
    fileprivate func setupEndGameConstraints() {
        addSubview(endGameLabel)
        addSubview(endGameTopStack)
        endGameTopStack.addArrangedSubview(endOneImage)
        endGameTopStack.addArrangedSubview(endTwoImage)
        endGameTopStack.addArrangedSubview(endThreeImage)
        endGameTopStack.addArrangedSubview(endFourImage)
        
        addSubview(endGameBotStack)
        endGameBotStack.addArrangedSubview(endFiveImage)
        endGameBotStack.addArrangedSubview(endSixImage)
        endGameBotStack.addArrangedSubview(endSevenImage)
        endGameBotStack.addArrangedSubview(endEightImage)
        
        
        NSLayoutConstraint.activate([
            // Label
            endGameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            endGameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            // Top Stack
            endGameTopStack.topAnchor.constraint(equalTo: endGameLabel.bottomAnchor, constant: 6),
            endGameTopStack.leadingAnchor.constraint(equalTo: endGameLabel.leadingAnchor),
        
            // Bot Stack
            endGameBotStack.topAnchor.constraint(equalTo: endGameTopStack.bottomAnchor, constant: 10),
            endGameBotStack.leadingAnchor.constraint(equalTo: endOneImage.centerXAnchor, constant: 12.5),
            endGameBotStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
