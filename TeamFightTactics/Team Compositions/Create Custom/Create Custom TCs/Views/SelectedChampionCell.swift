//
//  CreateSelectedChampionCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 14/12/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class SelectedChampionCell: BaseTableViewCell, ReusableCell {
    
    //MARK:- Properties
    typealias DataType = Champion
    static var reuseId: String = "selectedChampionCellId"
    let championNameLabel = BaseLabel(fontSize: 18, fontWeight: .regular, fontColor: ThemeColor.platinum)
    let championImageView = ChampionImageView(frame: .zero)
    let itemsStackView = BaseStack(axis: .horizontal, distribution: .fillEqually, spacing: 5)
    
    var buttonTappedAction: ((SelectedChampionCell) -> Void)?
    
    
    //MARK:- Configure Cell
    func configureCell(with champion: Champion) {
        championImageView.useStandardOrSetSkin(champion.imgURL, champion.key)
        championImageView.setChampCostBorderColor(champCost: champion.cost)
        championNameLabel.text = champion.name
    }
    
    
    //MARK:- Setup Cell
    override func setupCell() {
        backgroundColor = ThemeColor.charcoal
        
        setupChampionImageView(padding: 8.0)
        setupChampionNameLabel()
    }
    
    
    //MARK: Setup Champion Image View
    fileprivate func setupChampionImageView(padding: CGFloat) {
        contentView.addSubview(championImageView)
        let championImageViewHeightConstraint = championImageView.heightAnchor.constraint(equalToConstant: 50)
        championImageViewHeightConstraint.priority = UILayoutPriority(rawValue: 999)
        
        NSLayoutConstraint.activate([
            championImageViewHeightConstraint,
            championImageView.widthAnchor.constraint(equalTo: championImageView.heightAnchor),
            championImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            championImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            championImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            championImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    
    //MARK: Setup Champion Name Label
    fileprivate func setupChampionNameLabel() {
        contentView.addSubview(championNameLabel)
        NSLayoutConstraint.activate([
            championNameLabel.topAnchor.constraint(equalTo: championImageView.topAnchor),
            championNameLabel.leadingAnchor.constraint(equalTo: championImageView.trailingAnchor, constant: 10),
            championNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            championNameLabel.bottomAnchor.constraint(equalTo: championImageView.bottomAnchor)
        ])
    }
    
    
    //MARK: Setup Items Stack View
    fileprivate func setupItemsStackView() {
        for _ in 1...3 {
            let btn = UIButton()
            btn.backgroundColor = .red
            btn.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
            btn.setImage(UIImage(named: "hush"), for: .normal)
            
            itemsStackView.addArrangedSubview(btn)
        }
        
        let padding: CGFloat = 5
        let stackHeight: CGFloat = 35
        let numberOfImages: CGFloat = 3
        contentView.addSubview(itemsStackView)
        NSLayoutConstraint.activate([
            itemsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            itemsStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            itemsStackView.heightAnchor.constraint(equalToConstant: stackHeight),
            itemsStackView.widthAnchor.constraint(equalToConstant: (stackHeight * numberOfImages) + (numberOfImages * padding))
        ])
    }
    
    
    //MARK: Button Tap Action
    @objc func buttonTap(sender: AnyObject) {
        buttonTappedAction?(self)
    }
}
