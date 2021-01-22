//
//  PopUpChampImageSection.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 13/10/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class PopUpChampImageSection: BaseView {
    
    //MARK:- Properties
    let champName = BaseLabel(fontSize: 24, fontWeight: .semibold)
    let champCostLabel = BaseLabel(fontSize: 20, fontWeight: .semibold)
    let traitsStack = BaseStack(axis: .vertical, distribution: .fill, alignment: .leading, spacing: 8)
    let champTierRibbon = GeneralImageView(frame: .zero)
    let champCostIcon = IconImageView(icon: StatIcon.gold, tintColor: ThemeColor.platinum)
    
    let champImage: ChampionImageView = {
        let imgView = ChampionImageView(frame: .zero)
        imgView.contentMode = .scaleAspectFill
        imgView.layer.cornerRadius = 5
        imgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return imgView
    }()
    
    
    //MARK: Configure Champ Image Section
    func configureChampImageSection(champion: Champion) {
        setTierRibbonAndBackgroundColor(champion.cost)
        setTraitBadges(champion.classes, champion.origins)
        champName.text = champion.name
        champCostLabel.text = "\(champion.cost.rawValue)"
        champImage.sd_setImage(with: URL(string: champion.splashImg), placeholderImage: PlaceholderImage.champ)
    }
    
    
    //MARK: Override Setup View
    override func setupView() {
        heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5, constant: 42).isActive = true
    }
    
    
    //MARK: Override Setup Subviews
    override func setupSubviews() {
        addSubviews(champCostLabel, champCostIcon,champName, champImage, champTierRibbon, traitsStack)
        constrainChampImageAndRibbon()
        constrainName()
        constrainCost()
        constrainTraitsStack()
    }
    
    
    //MARK: Setup Trait Badges
    #warning("Duplicate function - already in ChampTraitStack Class - Inhertience might fix this!")
    fileprivate func setTraitBadges(_ classes: [String], _ origins: [String]) {
        for _ in 1...4 {
            traitsStack.addArrangedSubview(PopUpChampTraitBadge(cornerRadius: 2))
        }
        
        let traits = [classes, origins].flatMap { $0 }
        traitsStack.arrangedSubviews.forEach({ $0.isHidden = true })
        for (index, trait) in traits.enumerated() {
            if let badge = traitsStack.arrangedSubviews[index] as? PopUpChampTraitBadge {
                badge.typeLabel.text = trait
                badge.typeIcon.image = UIImage(named: "\(trait)")
                badge.isHidden = false
            }
        }
    }
    
    
    //MARK: Set Tier Ribbon & Background Color
    fileprivate func setTierRibbonAndBackgroundColor(_ champCost: Cost) {
        switch champCost {
        case .one:
            backgroundColor = UIColor(cgColor: ChampCostColor.one)
            break
        case .two:
            backgroundColor = UIColor(cgColor: ChampCostColor.two)
            champTierRibbon.image = TierRibbon.two
        case .three:
            backgroundColor = UIColor(cgColor: ChampCostColor.three)
            champTierRibbon.image = TierRibbon.three
        case .four:
            backgroundColor = UIColor(cgColor: ChampCostColor.four)
            champTierRibbon.image = TierRibbon.four
        case .five:
            backgroundColor = UIColor(cgColor: ChampCostColor.five)
            champTierRibbon.image = TierRibbon.five
        case .six, .seven:
            champName.textColor = ThemeColor.charcoal
            champCostIcon.tintColor = ThemeColor.charcoal
            champCostLabel.textColor = ThemeColor.charcoal
            champTierRibbon.image = TierRibbon.five
            
            let gradientView = GradientView(frame: self.bounds, gradientColors: ChampCostRainbowColor.rainbow, gradientDirection: .topLeftToBottomRight, colorLocations: [0.2, 0.4, 0.6, 0.8, 1.0])
            self.insertSubview(gradientView, at: 0)
        }
    }
    
    
    //MARK: Constrain Champ Image & Ribbon
    fileprivate func constrainChampImageAndRibbon() {
        NSLayoutConstraint.activate([
            champImage.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            champImage.widthAnchor.constraint(equalTo: widthAnchor, constant: -8),
            champImage.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            champImage.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            champTierRibbon.centerXAnchor.constraint(equalTo: champImage.centerXAnchor),
            champTierRibbon.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
    
    
    //MARK: Constrain Champ Name
    fileprivate func constrainName() {
        NSLayoutConstraint.activate([
            champName.bottomAnchor.constraint(equalTo: bottomAnchor),
            champName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            champName.heightAnchor.constraint(equalToConstant: 38)
        ])
    }
    
    
    //MARK: Constrain Cost
    fileprivate func constrainCost() {
        NSLayoutConstraint.activate([
            champCostLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            champCostLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            champCostLabel.heightAnchor.constraint(equalToConstant: 38)
        ])
        
        NSLayoutConstraint.activate([
            champCostIcon.centerYAnchor.constraint(equalTo: champCostLabel.centerYAnchor),
            champCostIcon.trailingAnchor.constraint(equalTo: champCostLabel.leadingAnchor, constant: -2),
            champCostIcon.heightAnchor.constraint(equalToConstant: 20),
            champCostIcon.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    
    //MARK: Constrain Traits Stack
    fileprivate func constrainTraitsStack() {
        NSLayoutConstraint.activate([
            traitsStack.bottomAnchor.constraint(equalTo: champImage.bottomAnchor, constant: -8),
            traitsStack.leadingAnchor.constraint(equalTo: champImage.leadingAnchor, constant: 6)
        ])
    }
}
