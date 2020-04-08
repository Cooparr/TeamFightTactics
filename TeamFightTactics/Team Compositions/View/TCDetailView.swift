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
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = CustomColor.richBlack
        scrollView.delegate = self
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
        return lbl
    }()
    
    
    //MARK: Section Properties
    let boardSection = BoardSection()
    
    
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
    
    let earlyOneImage: TCDetailChampImage = TCDetailChampImage()
    let earlyTwoImage: TCDetailChampImage = TCDetailChampImage()
    let earlyThreeImage: TCDetailChampImage = TCDetailChampImage()
    lazy var earlyGameChamps: [TCDetailChampImage] = [earlyOneImage, earlyTwoImage, earlyThreeImage]
    
    lazy var earlyGameStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: earlyGameChamps)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.spacing = 8
        return stackView
    }()
    
    
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
    
    let midOneImage: TCDetailChampImage = TCDetailChampImage()
    let midTwoImage: TCDetailChampImage = TCDetailChampImage()
    let midThreeImage: TCDetailChampImage = TCDetailChampImage()
    let midFourImage: TCDetailChampImage = TCDetailChampImage()
    let midFiveImage: TCDetailChampImage = TCDetailChampImage()
    lazy var midGameChamps: [TCDetailChampImage] = [midOneImage, midTwoImage, midThreeImage, midFourImage, midFiveImage]
    
    lazy var midGameStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: midGameChamps)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.spacing = 8
        return stackView
    }()
    
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
        scrollViewContainer.addArrangedSubview(boardSection)
        
        
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
        earlyGameView.addSubview(earlyGameStack)
        
        
        NSLayoutConstraint.activate([
            earlyGameLabel.topAnchor.constraint(equalTo: earlyGameView.topAnchor, constant: 10),
            earlyGameLabel.leadingAnchor.constraint(equalTo: earlyGameView.leadingAnchor, constant: 10),
            earlyGameStack.topAnchor.constraint(equalTo: earlyGameLabel.bottomAnchor, constant: 6),
            earlyGameStack.bottomAnchor.constraint(equalTo: earlyGameView.bottomAnchor),
            earlyGameStack.leadingAnchor.constraint(equalTo: earlyGameView.leadingAnchor, constant: 10)
        ])
    }
    
    
    //MARK: Mid Game Constraints
    fileprivate func setupMidGameConstraints() {
        midGameView.addSubview(midGameLabel)
        midGameView.addSubview(midGameStack)
        NSLayoutConstraint.activate([
            midGameLabel.topAnchor.constraint(equalTo: midGameView.topAnchor, constant: 10),
            midGameLabel.leadingAnchor.constraint(equalTo: midGameView.leadingAnchor, constant: 10),
            midGameStack.topAnchor.constraint(equalTo: midGameLabel.bottomAnchor, constant: 6),
            midGameStack.bottomAnchor.constraint(equalTo: midGameView.bottomAnchor),
            midGameStack.leadingAnchor.constraint(equalTo: midGameView.leadingAnchor, constant: 10)
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


//MARK:- ScrollView Delegate
extension TCDetailView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        }
    }
}
