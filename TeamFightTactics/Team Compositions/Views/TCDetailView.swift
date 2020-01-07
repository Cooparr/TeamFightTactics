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
    
    lazy var earlyGameStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [earlyOneImage, earlyTwoImage, earlyThreeImage])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.spacing = 8
        stackView.arrangedSubviews.forEach({$0.isHidden = true})
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
    lazy var midGameStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [midOneImage, midTwoImage, midThreeImage, midFourImage, midFiveImage])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.spacing = 8
        stackView.arrangedSubviews.forEach({$0.isHidden = true})
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
    
    let endOneImage: TCDetailChampImage = TCDetailChampImage()
    let endTwoImage: TCDetailChampImage = TCDetailChampImage()
    let endThreeImage: TCDetailChampImage = TCDetailChampImage()
    let endFourImage: TCDetailChampImage = TCDetailChampImage()
    let endFiveImage: TCDetailChampImage = TCDetailChampImage()
    let endSixImage: TCDetailChampImage = TCDetailChampImage()
    let endSevenImage: TCDetailChampImage = TCDetailChampImage()
    let endEightImage: TCDetailChampImage = TCDetailChampImage()
    
    
    //MARK: TFT Board Map
    let boardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        view.backgroundColor = CustomColor.richBlack
        return view
    }()
    
    let boardMap: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = CustomColor.richBlack
        return view
    }()
    
    let boardLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Board Positioning"
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return lbl
    }()
    
    // Row 1
    let slot0: TCDetailBoardSlot = TCDetailBoardSlot()
    let slot1: TCDetailBoardSlot = TCDetailBoardSlot()
    let slot2: TCDetailBoardSlot = TCDetailBoardSlot()
    let slot3: TCDetailBoardSlot = TCDetailBoardSlot()
    let slot4: TCDetailBoardSlot = TCDetailBoardSlot()
    let slot5: TCDetailBoardSlot = TCDetailBoardSlot()
    let slot6: TCDetailBoardSlot = TCDetailBoardSlot()
    
    // Row 2
    let slot7: TCDetailBoardSlot = TCDetailBoardSlot()
    let slot8: TCDetailBoardSlot = TCDetailBoardSlot()
    let slot9: TCDetailBoardSlot = TCDetailBoardSlot()
    let slot10: TCDetailBoardSlot = TCDetailBoardSlot()
    let slot11: TCDetailBoardSlot = TCDetailBoardSlot()
    let slot12: TCDetailBoardSlot = TCDetailBoardSlot()
    let slot13: TCDetailBoardSlot = TCDetailBoardSlot()
    
    // Row 3
    let slot14: TCDetailBoardSlot = TCDetailBoardSlot()
    let slot15: TCDetailBoardSlot = TCDetailBoardSlot()
    let slot16: TCDetailBoardSlot = TCDetailBoardSlot()
    let slot17: TCDetailBoardSlot = TCDetailBoardSlot()
    let slot18: TCDetailBoardSlot = TCDetailBoardSlot()
    let slot19: TCDetailBoardSlot = TCDetailBoardSlot()
    let slot20: TCDetailBoardSlot = TCDetailBoardSlot()
    
    // Row 4
    let slot21: TCDetailBoardSlot = TCDetailBoardSlot()
    let slot22: TCDetailBoardSlot = TCDetailBoardSlot()
    let slot23: TCDetailBoardSlot = TCDetailBoardSlot()
    let slot24: TCDetailBoardSlot = TCDetailBoardSlot()
    let slot25: TCDetailBoardSlot = TCDetailBoardSlot()
    let slot26: TCDetailBoardSlot = TCDetailBoardSlot()
    let slot27: TCDetailBoardSlot = TCDetailBoardSlot()
    
    lazy var boardSlots: [TCDetailBoardSlot] = [slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9, slot10, slot11, slot12, slot13, slot14, slot15, slot16, slot17, slot18, slot19, slot20, slot21, slot22, slot23, slot24, slot25, slot26, slot27]
    
    //MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupScrollViewConstraints()
        setupTierLabelConstraints()
        setupEarlyGameConstraints()
        setupMidGameConstraints()
        setupEndGameConstraints()
        setupBoardConstraints()
    }
    
    
    //MARK: Scroll View Constraints
    fileprivate func setupScrollViewConstraints() {
        addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.addArrangedSubview(earlyGameView)
        scrollViewContainer.addArrangedSubview(midGameView)
        scrollViewContainer.addArrangedSubview(endGameView)
        scrollViewContainer.addArrangedSubview(boardView)
        
        
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
    
    
    //MARK: Board Constraints
    fileprivate func setupBoardConstraints() {
        
        // Label
        boardView.addSubview(boardLabel)
        NSLayoutConstraint.activate([
            boardLabel.topAnchor.constraint(equalTo: boardView.topAnchor, constant: 10),
            boardLabel.leadingAnchor.constraint(equalTo: boardView.leadingAnchor, constant: 10),
        ])
        
        // Map Container
        boardView.addSubview(boardMap)
        NSLayoutConstraint.activate([
            boardMap.centerXAnchor.constraint(equalTo: boardView.centerXAnchor),
            boardMap.topAnchor.constraint(equalTo: boardLabel.bottomAnchor, constant: 6)
        ])
        
        
        // Row 1
        let boardSpacing: CGFloat = -2
        let tightenHexagons: CGFloat = -8
        boardMap.addSubview(slot0)
        boardMap.addSubview(slot1)
        boardMap.addSubview(slot2)
        boardMap.addSubview(slot3)
        boardMap.addSubview(slot4)
        boardMap.addSubview(slot5)
        boardMap.addSubview(slot6)
        NSLayoutConstraint.activate([
            slot0.topAnchor.constraint(equalTo: boardMap.topAnchor),
            slot0.leadingAnchor.constraint(equalTo: boardMap.leadingAnchor),
            
            slot1.leadingAnchor.constraint(equalTo: slot0.trailingAnchor, constant: boardSpacing),
            slot1.topAnchor.constraint(equalTo: slot0.topAnchor),
            
            slot2.leadingAnchor.constraint(equalTo: slot1.trailingAnchor, constant: boardSpacing),
            slot2.topAnchor.constraint(equalTo: slot1.topAnchor),
            
            slot3.leadingAnchor.constraint(equalTo: slot2.trailingAnchor, constant: boardSpacing),
            slot3.topAnchor.constraint(equalTo: slot2.topAnchor),
            
            slot4.leadingAnchor.constraint(equalTo: slot3.trailingAnchor, constant: boardSpacing),
            slot4.topAnchor.constraint(equalTo: slot3.topAnchor),
            
            slot5.leadingAnchor.constraint(equalTo: slot4.trailingAnchor, constant: boardSpacing),
            slot5.topAnchor.constraint(equalTo: slot4.topAnchor),
            
            slot6.leadingAnchor.constraint(equalTo: slot5.trailingAnchor, constant: boardSpacing),
            slot6.topAnchor.constraint(equalTo: slot5.topAnchor)
            
        ])
        
        
        // Row 2
        boardMap.addSubview(slot7)
        boardMap.addSubview(slot8)
        boardMap.addSubview(slot9)
        boardMap.addSubview(slot10)
        boardMap.addSubview(slot11)
        boardMap.addSubview(slot12)
        boardMap.addSubview(slot13)
        NSLayoutConstraint.activate([
            slot7.topAnchor.constraint(equalTo: slot0.bottomAnchor, constant: tightenHexagons),
            slot7.leadingAnchor.constraint(equalTo: slot0.centerXAnchor, constant: -1),
            
            slot8.leadingAnchor.constraint(equalTo: slot7.trailingAnchor, constant: boardSpacing),
            slot8.topAnchor.constraint(equalTo: slot7.topAnchor),
            
            slot9.leadingAnchor.constraint(equalTo: slot8.trailingAnchor, constant: boardSpacing),
            slot9.topAnchor.constraint(equalTo: slot8.topAnchor),
            
            slot10.leadingAnchor.constraint(equalTo: slot9.trailingAnchor, constant: boardSpacing),
            slot10.topAnchor.constraint(equalTo: slot9.topAnchor),
            
            slot11.leadingAnchor.constraint(equalTo: slot10.trailingAnchor, constant: boardSpacing),
            slot11.topAnchor.constraint(equalTo: slot10.topAnchor),
            
            slot12.leadingAnchor.constraint(equalTo: slot11.trailingAnchor, constant: boardSpacing),
            slot12.topAnchor.constraint(equalTo: slot11.topAnchor),
            
            slot13.leadingAnchor.constraint(equalTo: slot12.trailingAnchor, constant: boardSpacing),
            slot13.topAnchor.constraint(equalTo: slot12.topAnchor)
        ])
        
        
        // Row 3
        boardMap.addSubview(slot14)
        boardMap.addSubview(slot15)
        boardMap.addSubview(slot16)
        boardMap.addSubview(slot17)
        boardMap.addSubview(slot18)
        boardMap.addSubview(slot19)
        boardMap.addSubview(slot20)
        NSLayoutConstraint.activate([
            slot14.topAnchor.constraint(equalTo: slot7.bottomAnchor, constant: tightenHexagons),
            slot14.leadingAnchor.constraint(equalTo: slot0.leadingAnchor),
            
            slot15.leadingAnchor.constraint(equalTo: slot14.trailingAnchor, constant: boardSpacing),
            slot15.topAnchor.constraint(equalTo: slot14.topAnchor),
            
            slot16.leadingAnchor.constraint(equalTo: slot15.trailingAnchor, constant: boardSpacing),
            slot16.topAnchor.constraint(equalTo: slot15.topAnchor),
            
            slot17.leadingAnchor.constraint(equalTo: slot16.trailingAnchor, constant: boardSpacing),
            slot17.topAnchor.constraint(equalTo: slot16.topAnchor),
            
            slot18.leadingAnchor.constraint(equalTo: slot17.trailingAnchor, constant: boardSpacing),
            slot18.topAnchor.constraint(equalTo: slot17.topAnchor),
            
            slot19.leadingAnchor.constraint(equalTo: slot18.trailingAnchor, constant: boardSpacing),
            slot19.topAnchor.constraint(equalTo: slot18.topAnchor),
            
            slot20.leadingAnchor.constraint(equalTo: slot19.trailingAnchor, constant: boardSpacing),
            slot20.topAnchor.constraint(equalTo: slot19.topAnchor)
        ])
        
        
        // Row 4
        boardMap.addSubview(slot21)
        boardMap.addSubview(slot22)
        boardMap.addSubview(slot23)
        boardMap.addSubview(slot24)
        boardMap.addSubview(slot25)
        boardMap.addSubview(slot26)
        boardMap.addSubview(slot27)
        NSLayoutConstraint.activate([
            slot21.topAnchor.constraint(equalTo: slot14.bottomAnchor, constant: tightenHexagons),
            slot21.leadingAnchor.constraint(equalTo: slot7.leadingAnchor),
            
            slot22.leadingAnchor.constraint(equalTo: slot21.trailingAnchor, constant: boardSpacing),
            slot22.topAnchor.constraint(equalTo: slot21.topAnchor),
            
            slot23.leadingAnchor.constraint(equalTo: slot22.trailingAnchor, constant: boardSpacing),
            slot23.topAnchor.constraint(equalTo: slot22.topAnchor),
            
            slot24.leadingAnchor.constraint(equalTo: slot23.trailingAnchor, constant: boardSpacing),
            slot24.topAnchor.constraint(equalTo: slot23.topAnchor),
            
            slot25.leadingAnchor.constraint(equalTo: slot24.trailingAnchor, constant: boardSpacing),
            slot25.topAnchor.constraint(equalTo: slot24.topAnchor),
            
            slot26.leadingAnchor.constraint(equalTo: slot25.trailingAnchor, constant: boardSpacing),
            slot26.topAnchor.constraint(equalTo: slot25.topAnchor),
            
            slot27.leadingAnchor.constraint(equalTo: slot26.trailingAnchor, constant: boardSpacing),
            slot27.topAnchor.constraint(equalTo: slot26.topAnchor),
            
            slot27.trailingAnchor.constraint(equalTo: boardMap.trailingAnchor),
            slot27.bottomAnchor.constraint(equalTo: boardMap.bottomAnchor)
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
