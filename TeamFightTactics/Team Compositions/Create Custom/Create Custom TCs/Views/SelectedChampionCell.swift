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
    static var reuseId: String = "SelectedChampionCell"
    
    #warning("Do i prefer this way of creating instances?")
    var championNameLabel: BaseLabel!
    var championImageView: UIImageView!
    var itemsStackView: UIStackView!
    
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
        
        setupChampionImageView()
        setupChampionNameLabel()
    }
    
    
    //MARK: Setup Champion Image View
    fileprivate func setupChampionImageView() {
        championImageView = UIImageView()
        championImageView.translatesAutoresizingMaskIntoConstraints = false
        championImageView.contentMode = .scaleAspectFit
        championImageView.clipsToBounds = true
        championImageView.layer.cornerRadius = 3
        
        
        contentView.addSubview(championImageView)
        let championImageViewHeightConstraint = championImageView.heightAnchor.constraint(equalToConstant: 50)
        championImageViewHeightConstraint.priority = UILayoutPriority(rawValue: 999)
        
        NSLayoutConstraint.activate([
            championImageViewHeightConstraint,
            championImageView.widthAnchor.constraint(equalTo: championImageView.heightAnchor),
            championImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            championImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            championImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            championImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    
    //MARK: Setup Champion Name Label
    fileprivate func setupChampionNameLabel() {
        championNameLabel = BaseLabel(fontSize: 18, fontWeight: .regular, fontColor: ThemeColor.platinum)
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
        itemsStackView = UIStackView()
        itemsStackView.translatesAutoresizingMaskIntoConstraints = false
        itemsStackView.axis = .horizontal
        itemsStackView.distribution = .fillEqually
        itemsStackView.spacing = 5
        
        for _ in 1...3 {
            let btn = UIButton()
            btn.backgroundColor = .red
            btn.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
            btn.setImage(UIImage(named: "hush"), for: .normal)
            
            itemsStackView.addArrangedSubview(btn)
        }
        
        contentView.addSubview(itemsStackView)
        NSLayoutConstraint.activate([
            itemsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            itemsStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            itemsStackView.heightAnchor.constraint(equalToConstant: 35),
            itemsStackView.widthAnchor.constraint(equalToConstant: (35 * 3) + 15)
        ])
    }
    
    
    //MARK: Button Tap Action
    @objc func buttonTap(sender: AnyObject) {
        buttonTappedAction?(self)
    }
}
