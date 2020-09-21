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
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = ThemeColor.richBlack
        scrollView.indicatorStyle = .white
        return scrollView
    }()
    
    let scrollViewContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .center
        return stackView
    }()
    
    let descriptionLabel: BaseLabel = {
        let lbl = BaseLabel(fontSize: 16, fontWeight: .light, multiLine: true)
        lbl.textAlignment = .center
        lbl.text = "Below lists the total number of a particular champion within the pool. Along with a table displaying the probability of finding a particular tier of champion depending on your level."
        return lbl
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
        collectionView.register(DropRateCell.self, forCellWithReuseIdentifier: DropRateCell.reuseId)
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
    
    
    //MARK:- Configure Stack Tier Labels
    fileprivate func configureStackTierLabels() {
        let tierLabels = createHeaderLabels(amount: 5)
        for (index, tierLabel) in tierLabels.enumerated() {
            tierLabel.text = "Tier \(index + 1)"
            setTierLabelBackgroundColor(tierLabel: tierLabel, tierIndex: index)
            tierLabel.heightAnchor.constraint(equalToConstant: collectionViewContHeight / 10).isActive = true
            tierLabelStack.addArrangedSubview(tierLabel)
        }
    }
    
    //MARK: Set Tier Label Background Color
    fileprivate func setTierLabelBackgroundColor(tierLabel: UILabel, tierIndex: Int) {
        switch tierIndex {
        case 0:
            tierLabel.backgroundColor = UIColor(cgColor: ChampCostColor.oneCost)
        case 1:
            tierLabel.backgroundColor = UIColor(cgColor: ChampCostColor.twoCost)
        case 2:
            tierLabel.backgroundColor = UIColor(cgColor: ChampCostColor.threeCost)
        case 3:
            tierLabel.backgroundColor = UIColor(cgColor: ChampCostColor.fourCost)
        default:
            tierLabel.backgroundColor = UIColor(cgColor: ChampCostColor.fiveCost)
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
    
    
    //MARK:- Setup Scroll View & Container
    fileprivate func setupScrollViewAndContainer() {
        addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        scrollView.pinSubview(to: self)
        
        scrollViewContainer.addArrangedSubview(descriptionLabel)
        scrollViewContainer.addArrangedSubview(totalChampPoolStack)
        scrollViewContainer.addArrangedSubview(probabilityTableCont)
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
