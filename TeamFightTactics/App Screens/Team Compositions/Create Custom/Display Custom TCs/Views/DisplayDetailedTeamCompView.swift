//
//  DisplayDetailedTeamCompView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 02/03/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class DisplayDetailedTeamCompView: BaseView {
    
    //MARK: Properties
    private let scrollView = UIScrollView()
    private let contentStackView = BaseStack(axis: .vertical, distribution: .fill, alignment: .fill, spacing: 30)
    private let descriptionLabel = BaseLabel(fontSize: 14, fontWeight: .regular, textAlignment: .center, multiLine: true)
    private let traitsStackView = BaseStack(axis: .vertical, spacing: 8)
    private let champImgViewStacks = ChampImagesStackView(axis: .vertical, spacing: 20)
    
    
    //MARK: Configure Detail View
    func configureDetailView(desc: String?, champImgViews: [TCDetailEndGameChampView], traitTiles: [TCDetailTraitInfo]) {
        descriptionLabel.text = desc
        champImgViewStacks.addChampViewsToStack(champViews: champImgViews)
        traitTiles.forEach { traitsStackView.addArrangedSubview($0) }
    }
    
    
    //MARK: Override Setup View
    override func setupView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        scrollView.pinSubview(to: self)
        scrollView.addSubview(contentStackView)
        
        contentStackView.pinSubviewWithPadding(to: scrollView, allSides: 10)
        contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -20).isActive = true
        contentStackView.addArrangedSubviews(descriptionLabel, champImgViewStacks, traitsStackView)
    }
}
