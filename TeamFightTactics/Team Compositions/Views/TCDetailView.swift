//
//  TCDetailView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 11/12/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCDetailView: UIView {
    
    //MARK: Scroll View & Container
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = CustomColor.richBlack
        return scrollView
    }()
    
    let scrollViewContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    
    //MARK: Tier Label
    let teamCompTier: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = CustomColor.richBlack
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        lbl.textAlignment = .center
        lbl.clipsToBounds = true
        lbl.layer.cornerRadius = 10.0
        lbl.layer.maskedCorners = [.layerMinXMaxYCorner]
        
        lbl.text = "S Tier"
        lbl.backgroundColor = CustomColor.aTier
        
        return lbl
    }()
    
    
    //MARK: Early Game Champs
    let earlyGameView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = CustomColor.richBlack
        return view
    }()
    
    let earlyGameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Early Game"
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return lbl
    }()
    
    let earlyOneImage = TCDetailChampImage()
    let earlyTwoImage = TCDetailChampImage()
    let earlyThreeImage = TCDetailChampImage()
    
    
    //MARK: Mid Game Champs
    let midGameView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = CustomColor.richBlack
        return view
    }()
    
    let midGameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Mid Game"
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return lbl
    }()
    
    let midOneImage = TCDetailChampImage()
    let midTwoImage = TCDetailChampImage()
    let midThreeImage = TCDetailChampImage()
    let midFourImage = TCDetailChampImage()
    let midFiveImage = TCDetailChampImage()
    
    
    //MARK: End Game Champs
    let endGameView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = CustomColor.richBlack
        return view
    }()
    
    let endGameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "End Game"
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return lbl
    }()
    
    let endGameTopStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    let endGameBotStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    let endOneImage = TCDetailChampImage()
    let endTwoImage = TCDetailChampImage()
    let endThreeImage = TCDetailChampImage()
    let endFourImage = TCDetailChampImage()
    let endFiveImage = TCDetailChampImage()
    let endSixImage = TCDetailChampImage()
    let endSevenImage = TCDetailChampImage()
    let endEightImage = TCDetailChampImage()
    
    
    //MARK: WORKING ON IT
    let blueView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 2000).isActive = true
        view.backgroundColor = .blue
        return view
    }()
    
    
    //MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupScrollViewConstraints()
        setupTierLabelConstraints()
        setupEarlyGameConstraints()
        setupMidGameConstraints()
        setupEndGameConstraints()
    }
    
    
    //MARK: Scroll View Constraints
    fileprivate func setupScrollViewConstraints() {
        addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.addArrangedSubview(earlyGameView)
        scrollViewContainer.addArrangedSubview(midGameView)
        scrollViewContainer.addArrangedSubview(endGameView)
        scrollViewContainer.addArrangedSubview(blueView)
        
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    
    //MARK: Tier Label Constraints
    fileprivate func setupTierLabelConstraints() {
        earlyGameView.addSubview(teamCompTier)
        NSLayoutConstraint.activate([
            teamCompTier.widthAnchor.constraint(equalToConstant: 100),
            teamCompTier.heightAnchor.constraint(equalToConstant: 20),
            teamCompTier.topAnchor.constraint(equalTo: scrollView.topAnchor),
            teamCompTier.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ])
    }

    
    //MARK: Early Game Constraints
    fileprivate func setupEarlyGameConstraints() {
        earlyGameView.addSubview(earlyGameLabel)
        earlyGameView.addSubview(earlyOneImage)
        earlyGameView.addSubview(earlyTwoImage)
        earlyGameView.addSubview(earlyThreeImage)
        NSLayoutConstraint.activate([
            earlyGameLabel.topAnchor.constraint(equalTo: earlyGameView.topAnchor, constant: 10),
            earlyGameLabel.leadingAnchor.constraint(equalTo: earlyGameView.leadingAnchor, constant: 10),
            
            earlyOneImage.topAnchor.constraint(equalTo: earlyGameLabel.bottomAnchor, constant: 6),
            earlyOneImage.leadingAnchor.constraint(equalTo: earlyGameLabel.leadingAnchor),
            
            earlyTwoImage.topAnchor.constraint(equalTo: earlyOneImage.topAnchor),
            earlyTwoImage.leadingAnchor.constraint(equalTo: earlyOneImage.trailingAnchor, constant: 8),
            
            earlyThreeImage.topAnchor.constraint(equalTo: earlyTwoImage.topAnchor),
            earlyThreeImage.leadingAnchor.constraint(equalTo: earlyTwoImage.trailingAnchor, constant: 8),
            earlyThreeImage.bottomAnchor.constraint(equalTo: earlyGameView.bottomAnchor)
        ])
    }
    
    
    //MARK: Mid Game Constraints
    fileprivate func setupMidGameConstraints() {
        midGameView.addSubview(midGameLabel)
        midGameView.addSubview(midOneImage)
        midGameView.addSubview(midTwoImage)
        midGameView.addSubview(midThreeImage)
        midGameView.addSubview(midFourImage)
        midGameView.addSubview(midFiveImage)
        NSLayoutConstraint.activate([
            midGameLabel.topAnchor.constraint(equalTo: midGameView.topAnchor, constant: 10),
            midGameLabel.leadingAnchor.constraint(equalTo: midGameView.leadingAnchor, constant: 10),
            
            midOneImage.topAnchor.constraint(equalTo: midGameLabel.bottomAnchor, constant: 6),
            midOneImage.leadingAnchor.constraint(equalTo: midGameLabel.leadingAnchor),
            
            midTwoImage.topAnchor.constraint(equalTo: midOneImage.topAnchor),
            midTwoImage.leadingAnchor.constraint(equalTo: midOneImage.trailingAnchor, constant: 8),
            
            midThreeImage.topAnchor.constraint(equalTo: midTwoImage.topAnchor),
            midThreeImage.leadingAnchor.constraint(equalTo: midTwoImage.trailingAnchor, constant: 8),
            
            midFourImage.topAnchor.constraint(equalTo: midThreeImage.topAnchor),
            midFourImage.leadingAnchor.constraint(equalTo: midThreeImage.trailingAnchor, constant: 8),
            
            midFiveImage.topAnchor.constraint(equalTo: midFourImage.topAnchor),
            midFiveImage.leadingAnchor.constraint(equalTo: midFourImage.trailingAnchor, constant: 8),
            midFiveImage.bottomAnchor.constraint(equalTo: midGameView.bottomAnchor)
        ])
    }
    
    
    //MARK: End Game Constraints
    fileprivate func setupEndGameConstraints() {
        endGameView.addSubview(endGameLabel)
        endGameView.addSubview(endGameTopStack)
        endGameTopStack.addArrangedSubview(endOneImage)
        endGameTopStack.addArrangedSubview(endTwoImage)
        endGameTopStack.addArrangedSubview(endThreeImage)
        endGameTopStack.addArrangedSubview(endFourImage)
        
        endGameView.addSubview(endGameBotStack)
        endGameBotStack.addArrangedSubview(endFiveImage)
        endGameBotStack.addArrangedSubview(endSixImage)
        endGameBotStack.addArrangedSubview(endSevenImage)
        endGameBotStack.addArrangedSubview(endEightImage)
        
        
        NSLayoutConstraint.activate([
            // Label
            endGameLabel.topAnchor.constraint(equalTo: endGameView.topAnchor, constant: 10),
            endGameLabel.leadingAnchor.constraint(equalTo: endGameView.leadingAnchor, constant: 10),
            
            // Top Stack
            endGameTopStack.topAnchor.constraint(equalTo: endGameLabel.bottomAnchor, constant: 6),
            endGameTopStack.leadingAnchor.constraint(equalTo: endGameLabel.leadingAnchor),
        
            // Bot Stack
            endGameBotStack.topAnchor.constraint(equalTo: endGameTopStack.bottomAnchor, constant: 10),
            endGameBotStack.leadingAnchor.constraint(equalTo: endOneImage.centerXAnchor, constant: 12.5),
            endGameBotStack.bottomAnchor.constraint(equalTo: endGameView.bottomAnchor)
        ])
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



