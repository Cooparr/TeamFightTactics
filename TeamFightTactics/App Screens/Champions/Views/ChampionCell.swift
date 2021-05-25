//
//  ChampionCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 30/07/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit
import SDWebImage

class ChampionCell: BaseColViewCell, ReusableCell {
    
    //MARK:- Properties
    typealias DataType = Champion
    static var reuseId: String = "championCellId"
    
    let champImage = ChampionImageView(imageSize: 70)
    let champName = BaseLabel(fontSize: 16, fontWeight: .medium)
    let costView = ChampCostView(gradientDirection: .horizontal)
    let traitsStack = BaseStack(axis: .horizontal, alignment: .center, spacing: 4)
    var traitsStackUpdater: StackViewContentUpdater<String, ChampTraitBadge>!
    let baseStats = ChampStatsStack(stackDistrib: .fillEqually, colSpacing: 4)
    private let abilityInfo = SmallAbilityView(tamic: false)
    let dividerLine = BaseView(tamic: false, backgroundColor: ThemeColor.romanSilver)
    let statsBestItemContainer = BaseView(tamic: false)
    let bestItemsStackView = BaseStack(axis: .horizontal, distribution: .fillProportionally, alignment: .center, spacing: 4)

    let champTier: BaseLabel = {
        let lbl = BaseLabel(fontSize: 12, fontWeight: .semibold, fontColor: ThemeColor.richBlack, textAlignment: .center)
        lbl.clipsToBounds = true
        lbl.layer.cornerRadius = 6.0
        lbl.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        return lbl
    }()

    
    //MARK:- Configure Cell
    func configureCell(with champ: Champion) {
        setChampInfo(champ.name, champ.imageURL, champ.cost, champ.tier)
        baseStats.setStatLabels(for: champ.stats)
        setBestItems(champ.bestItems)
        abilityInfo.configureAbilityView(champAbility: champ.ability)
        traitsStackUpdater.setItems(champ.classes + champ.origins)
    }
    
    
    //MARK:- Override Setup Cell
    override func setupCell() {
        backgroundColor = ThemeColor.richBlack
        layer.cornerRadius = 6.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.clear.cgColor
        layer.masksToBounds = true
        setupTraitStackUpdater()
    }
    
    
    //MARK:- Setup Stack Updaters
    fileprivate func setupTraitStackUpdater() {
        self.traitsStackUpdater = StackViewContentUpdater(stackView: traitsStack, makeView: {
            return ChampTraitBadge()
        }, updateForItem: { (traitName, traitBadge) in
            traitBadge.setTraitBadge(with: traitName)
        })
    }
    
    
    //MARK:- Prepare For Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        champImage.layer.borderWidth = 2
    }
    
    
    //MARK:- Set Champ Info
    fileprivate func setChampInfo(_ name: String, _ imgURL: String, _ cost: Cost, _ tier: TierRating) {
        champName.text = name
        champImage.useStandardOrSetSkin(imgURL, name.formattedName())
        costView.configureCostView(for: cost)
        champImage.setChampCostBorderColor(champCost: cost)
        tier.setTierTextAndColor(for: champTier)
    }
    
    
    //MARK: Set Best Items
    fileprivate func setBestItems(_ bestItems: [String]) {
        for (index, bestItem) in bestItems.enumerated() {
            guard let imgView = bestItemsStackView.arrangedSubviews[index] as? ItemImageView else { return }
            imgView.image = UIImage(named: bestItem.formattedName())
        }
    }
    
    
    //MARK:- Setup Cell Views
    override func setupCellViews() {
        constrainImageAndName()
        constrainCostView()
        constrainTier()
        constrainTraits()
        constrainStatsBestItemContainer()
        constrainBestItems()
        constrainDividerLine()
        constrainBaseStats()
        constrainAbilityInfo()
    }
    
    
    //MARK: Image, Name & Cost
    fileprivate func constrainImageAndName() {
        addSubviews(champImage, champName)
        NSLayoutConstraint.activate([
            champImage.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            champImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            champImage.heightAnchor.constraint(equalToConstant: 70),
            champImage.widthAnchor.constraint(equalTo: champImage.heightAnchor),
            
            champName.topAnchor.constraint(equalTo: champImage.topAnchor),
            champName.leadingAnchor.constraint(equalTo: champImage.trailingAnchor, constant: 8)
        ])
    }
    
    
    //MARK: Cost View
    fileprivate func constrainCostView() {
        addSubview(costView)
        NSLayoutConstraint.activate([
            costView.centerXAnchor.constraint(equalTo: champImage.centerXAnchor),
            costView.topAnchor.constraint(equalTo: champImage.bottomAnchor, constant: -2),
            costView.heightAnchor.constraint(equalToConstant: 13),
            costView.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    
    //MARK: Tier
    fileprivate func constrainTier() {
        addSubview(champTier)
        NSLayoutConstraint.activate([
            champTier.topAnchor.constraint(equalTo: topAnchor),
            champTier.trailingAnchor.constraint(equalTo: trailingAnchor),
            champTier.widthAnchor.constraint(equalToConstant: 60),
            champTier.heightAnchor.constraint(equalToConstant: 17)
        ])
    }
    
    
    //MARK: Traits
    fileprivate func constrainTraits() {
        addSubview(traitsStack)
        NSLayoutConstraint.activate([
            traitsStack.topAnchor.constraint(equalTo: champName.bottomAnchor, constant: 2),
            traitsStack.leadingAnchor.constraint(equalTo: champImage.trailingAnchor,constant: 8),
            traitsStack.heightAnchor.constraint(equalToConstant: 19)
        ])
    }
    
    
    //MARK: Stats & Item Container
    fileprivate func constrainStatsBestItemContainer() {
        addSubview(statsBestItemContainer)
        NSLayoutConstraint.activate([
            statsBestItemContainer.topAnchor.constraint(equalTo: traitsStack.bottomAnchor, constant: 4),
            statsBestItemContainer.leadingAnchor.constraint(equalTo: traitsStack.leadingAnchor),
            statsBestItemContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            statsBestItemContainer.bottomAnchor.constraint(equalTo: costView.bottomAnchor)
        ])
    }
    
    //MARK: Best Items
    fileprivate func constrainBestItems() {
        (1...Champion.maxNumOfItemsCanHold).forEach { _ in
            bestItemsStackView.addArrangedSubview(ItemImageView(size: 25, cornerRadius: 2.0))
        }
        
        statsBestItemContainer.addSubview(bestItemsStackView)
        NSLayoutConstraint.activate([
            bestItemsStackView.heightAnchor.constraint(equalToConstant: 25),
            bestItemsStackView.trailingAnchor.constraint(equalTo: statsBestItemContainer.trailingAnchor, constant: -10),
            bestItemsStackView.centerYAnchor.constraint(equalTo: statsBestItemContainer.centerYAnchor)
        ])
    }
    
    //MARK: Divider Line
    fileprivate func constrainDividerLine() {
        statsBestItemContainer.addSubview(dividerLine)
        NSLayoutConstraint.activate([
            dividerLine.widthAnchor.constraint(equalToConstant: 1),
            dividerLine.heightAnchor.constraint(equalToConstant: 34),
            dividerLine.trailingAnchor.constraint(equalTo: bestItemsStackView.leadingAnchor, constant: -10),
            dividerLine.topAnchor.constraint(equalTo: statsBestItemContainer.topAnchor)
        ])
    }
    
    //MARK: Stats
    fileprivate func constrainBaseStats() {
        statsBestItemContainer.addSubview(baseStats)
        NSLayoutConstraint.activate([
            baseStats.topAnchor.constraint(equalTo: statsBestItemContainer.topAnchor),
            baseStats.leadingAnchor.constraint(equalTo: statsBestItemContainer.leadingAnchor),
            baseStats.trailingAnchor.constraint(equalTo: dividerLine.leadingAnchor, constant: -4),
            baseStats.bottomAnchor.constraint(equalTo: statsBestItemContainer.bottomAnchor)
        ])
    }
    
    
    //MARK: Ability Info
    fileprivate func constrainAbilityInfo() {
        addSubview(abilityInfo)
        NSLayoutConstraint.activate([
            abilityInfo.leadingAnchor.constraint(equalTo: champImage.leadingAnchor),
            abilityInfo.topAnchor.constraint(equalTo: costView.bottomAnchor, constant: 8),
            abilityInfo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            abilityInfo.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
