//
//  DropRatesView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 15/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class DropRatesView: BaseView {
    
    
    //MARK:- Properties
    let scrollViewContainer = BaseStack(axis: .vertical, alignment: .center, spacing: 15)
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = ThemeColor.richBlack
        scrollView.indicatorStyle = .white
        return scrollView
    }()

    let totalChampPoolStack = BaseStack(axis: .horizontal, distribution: .equalSpacing, alignment: .center)
    let levelLabelStack = BaseStack(axis: .vertical, distribution: .fillEqually, alignment: .center)
    let tierLabelStack = BaseStack(axis: .horizontal, distribution: .fillEqually, alignment: .center)
    let descriptionLabel: BaseLabel = {
        let lbl = BaseLabel(fontSize: 16, fontWeight: .light, multiLine: true)
        lbl.textAlignment = .center
        lbl.text = "Below lists the total number of a particular champion within the pool. Along with a table displaying the probability of finding a particular tier of champion depending on your level."
        return lbl
    }()
    
    private let probabilityTableCont = BaseView(tamic: false)
    let collectionViewContHeight: CGFloat = 400
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(DropRateCell.self, forCellWithReuseIdentifier: DropRateCell.reuseId)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = ThemeColor.charcoal
        return collectionView
    }()
    
    
    //MARK:- Setup View
    override func setupView() {
        configureStackTierLabels()
        configureStackLevelLabels()
    }
    
    
    //MARK: Setup Subviews
    override func setupSubviews() {
        setupScrollViewAndContainer()
        setupDescriptionLabel()
        setupPoolStack()
        setupProbabilityTableContainer()
    }
    
    
    //MARK:- Create Pool View
    func createPoolView(_ dropRate: DropRate, _ index: Int, _ poolValue: String) {
        let totalView = DropRatePoolTotalView(backgroundColor: ThemeColor.charcoal, cornerRadius: 6)
        totalView.champTierLabel.backgroundColor = setLabelBackgroundColor(for: dropRate.tier)
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
    
    
    //MARK:- Configure Stack Tier Labels
    fileprivate func configureStackTierLabels() {
        let tierLabels = createHeaderLabels(amount: 5)
        for (index, tierLabel) in tierLabels.enumerated() {
            let lblText = "Tier \(index + 1)"
            tierLabel.text = lblText
            tierLabel.backgroundColor = setLabelBackgroundColor(for: DropRate.Tier(fromRawValue: lblText))
            tierLabel.heightAnchor.constraint(equalToConstant: collectionViewContHeight / 10).isActive = true
            tierLabelStack.addArrangedSubview(tierLabel)
        }
    }
    
    
    //MARK:- Configure Stack Level Labels
    fileprivate func configureStackLevelLabels() {
        let levelLabels = createHeaderLabels(amount: 10)
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
    
    
    //MARK:- Create Header Labels
    fileprivate func createHeaderLabels(amount: Int) -> [BaseLabel] {
        let headerLabels: [BaseLabel] = (1...amount).map { _ in
            let lbl = BaseLabel(fontSize: 15, fontWeight: .bold)
            lbl.backgroundColor = ThemeColor.charcoal
            lbl.textAlignment = .center
            return lbl
        }
        return headerLabels
    }
    
    
    //MARK:- Set Label Background Color
    private func setLabelBackgroundColor(for tier: DropRate.Tier) -> UIColor {
        switch tier {
        case .one:
            return UIColor(cgColor: ChampCostColor.one)
        case .two:
            return UIColor(cgColor: ChampCostColor.two)
        case .three:
            return UIColor(cgColor: ChampCostColor.three)
        case .four:
            return UIColor(cgColor: ChampCostColor.four)
        case .five:
            return UIColor(cgColor: ChampCostColor.five)
        }
    }
    
    
    //MARK:- Setup Scroll View & Container
    fileprivate func setupScrollViewAndContainer() {
        addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        scrollView.pinSubview(to: self)
        scrollViewContainer.addArrangedSubviews(descriptionLabel, totalChampPoolStack, probabilityTableCont)
        NSLayoutConstraint.activate([
            scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15),
            scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -15),
            scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    
    //MARK:- Setup Desc Label Constraints
    fileprivate func setupDescriptionLabel() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: scrollViewContainer.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor, constant: -15),
        ])
    }
    
    
    //MARK:- Setup Pool Stack Constraints
    fileprivate func setupPoolStack() {
        NSLayoutConstraint.activate([
            totalChampPoolStack.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor, constant: 30),
            totalChampPoolStack.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor, constant: -30)
        ])
    }
    
    
    //MARK:- Setup Probability Table Container
    fileprivate func setupProbabilityTableContainer() {
        probabilityTableCont.addSubviews(collectionView, levelLabelStack, tierLabelStack)
        NSLayoutConstraint.activate([
            probabilityTableCont.heightAnchor.constraint(equalToConstant: collectionViewContHeight),
            probabilityTableCont.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor, constant: 15),
            probabilityTableCont.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor, constant: -15),
            
            
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
}
