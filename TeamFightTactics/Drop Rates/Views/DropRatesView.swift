//
//  DropRatesView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 15/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class DropRatesView: UIView {
    
    
    //MARK:- Properties
    let descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = ThemeColor.platinum
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .light)
        lbl.text = "Below lists the total number of a particular champion within the pool. Along with a table displaying the probability of finding a particular tier of champion depending on your level."
        return lbl
    }()
    
    let dropRatesViewStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 15
        return stack
    }()
    
    let totalChampPoolStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private let probabilityTableCont: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
    
    let collectionViewContHeight: CGFloat = 400
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(DropRateCell.self, forCellWithReuseIdentifier: ReuseId.dropRateCell)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = ThemeColor.charcoal
        return collectionView
    }()

    let levelLabelStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .center
        return stack
    }()
    
    let tierLabelStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        return stack
    }()
    
    
    //MARK:- Override Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ThemeColor.richBlack
        
        setupDescriptionLabel()
        setupDropRateMainStack()

        createStackTierLabels()
        createStackLevelLabels()
        setupProbabilityTableContainer()
    }
    
    
    //MARK:- Desc Label Constraints
    fileprivate func setupDescriptionLabel() {
        addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    
    //MARK:- Setup Main Stack View
    fileprivate func setupDropRateMainStack() {
        let padding: CGFloat = 15
        addSubview(dropRatesViewStack)
        dropRatesViewStack.addArrangedSubview(totalChampPoolStack)
        dropRatesViewStack.addArrangedSubview(probabilityTableCont)
        totalChampPoolStack.layoutMargins = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        totalChampPoolStack.isLayoutMarginsRelativeArrangement = true
        
        NSLayoutConstraint.activate([
            dropRatesViewStack.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: padding),
            dropRatesViewStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            dropRatesViewStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            dropRatesViewStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
    }
    
    
    //MARK:- Create Pool View
    func createPoolView(_ dropRate: DropRate, _ index: Int, _ poolValue: String) {
        let totalView = DropRatePoolTotalView()
        dropRate.tier.setBackgroundColor(for: totalView.champTierLabel)
        totalView.champTierLabel.text = "\(index + 1)"
        totalChampPoolStack.addArrangedSubview(totalView)
        totalView.poolTotalLabel.text = poolValue
    }

    
    //MARK: Update Pool Value
    func updatePoolValue(_ index: Int, _ poolValue: String) {
        guard let currentView = totalChampPoolStack.arrangedSubviews[index] as? DropRatePoolTotalView else { return }
        if currentView.poolTotalLabel.text != poolValue {
            currentView.poolTotalLabel.text = poolValue
        }
    }
    
    
    //MARK:- Create Stack Tier Labels
    fileprivate func createStackTierLabels() {
        let tierLabels = (1...5).map { _ in DropRateLabel() }
        
        for (index, tierLabel) in tierLabels.enumerated() {
            tierLabel.text = "Tier \(index + 1)"
            tierLabel.heightAnchor.constraint(equalToConstant: collectionViewContHeight/10).isActive = true
            tierLabelStack.addArrangedSubview(tierLabel)
        }
    }
    
    
    //MARK:- Create Stack Level Labels
    fileprivate func createStackLevelLabels() {
        let levelLabels = (1...10).map { _ in DropRateLabel() }
        
        for (index, levelLabel) in levelLabels.enumerated() {
            switch index {
            case 0:
                levelLabel.text = nil
            default:
                levelLabel.text = "Lv  \(index)"
            }
            
            levelLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
            levelLabelStack.addArrangedSubview(levelLabel)
        }
    }
    
    
    //MARK:- Setup Probability Table Container
    fileprivate func setupProbabilityTableContainer() {
        probabilityTableCont.addSubview(collectionView)
        probabilityTableCont.addSubview(levelLabelStack)
        probabilityTableCont.addSubview(tierLabelStack)
        NSLayoutConstraint.activate([
            probabilityTableCont.widthAnchor.constraint(equalTo: dropRatesViewStack.widthAnchor),
            probabilityTableCont.heightAnchor.constraint(equalToConstant: collectionViewContHeight),
            
            levelLabelStack.leadingAnchor.constraint(equalTo: probabilityTableCont.leadingAnchor),
            levelLabelStack.topAnchor.constraint(equalTo: probabilityTableCont.topAnchor),
            levelLabelStack.bottomAnchor.constraint(equalTo: probabilityTableCont.bottomAnchor),
            
            tierLabelStack.widthAnchor.constraint(equalTo: collectionView.widthAnchor),
            tierLabelStack.topAnchor.constraint(equalTo: probabilityTableCont.topAnchor),
            tierLabelStack.trailingAnchor.constraint(equalTo: probabilityTableCont.trailingAnchor),
            tierLabelStack.bottomAnchor.constraint(equalTo: collectionView.topAnchor),
            
            collectionView.widthAnchor.constraint(equalTo: probabilityTableCont.widthAnchor, multiplier: 5/6),
            collectionView.heightAnchor.constraint(equalTo: probabilityTableCont.heightAnchor, multiplier: 9/10),
            collectionView.trailingAnchor.constraint(equalTo: probabilityTableCont.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: probabilityTableCont.bottomAnchor),
        ])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
