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
    
    private let tierFlair = CellFlair()
    private let champImage = ChampionImageView(imageSize: 70)
    private let champName = BaseLabel(fontSize: 16, fontWeight: .medium)
    private let costView = ChampCostView(gradientDirection: .horizontal)
    private let traitsStack = BaseStack(axis: .horizontal, alignment: .center, spacing: 4)
    private var traitsStackUpdater: StackViewContentUpdater<String, ChampTraitBadge>!
    private(set) var baseStats = ChampStatsStack(stackDistrib: .fillEqually, colSpacing: 4)
    private let abilityInfo = SmallAbilityView(tamic: false)
    private let dividerLine = BaseView(tamic: false, backgroundColor: ThemeColor.romanSilver)
    private let statsBestItemContainer = BaseView(tamic: false)
    private let bestItemsStackView = BaseStack(axis: .horizontal, distribution: .fillProportionally, alignment: .center, spacing: 4)

    
    //MARK:- Configure Cell
    func configureCell(with champ: Champion) {
        setChampInfo(champ.name, champ.imageURL, champ.cost, champ.tier)
        traitsStackUpdater.setItems(champ.classes + champ.origins)
        setBestItems(champ.bestItems)
        baseStats.setStatLabels(for: champ.stats)
        abilityInfo.configureAbilityView(champAbility: champ.ability)
    }
    
    
    //MARK:- Override Setup Cell
    override func setupCell() {
        backgroundColor = ThemeColor.richBlack
        layer.cornerRadius = 6.0
        layer.masksToBounds = true
        setupTraitStackUpdater()
    }
    
    
    //MARK:- Setup Stack Updaters
    private func setupTraitStackUpdater() {
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
    private func setChampInfo(_ name: String, _ imgURL: String, _ cost: Cost, _ tier: TierRating) {
        champName.text = name
        champImage.useStandardOrSetSkin(imgURL, name.formattedName())
        costView.configureCostView(for: cost)
        champImage.setChampCostBorderColor(champCost: cost)
        tierFlair.updateFlair(with: tier)
    }
    
    
    //MARK: Set Best Items
    private func setBestItems(_ bestItems: [String]) {
        for (index, bestItem) in bestItems.enumerated() {
            guard let imgView = bestItemsStackView.arrangedSubviews[index] as? ItemImageView else { return }
            imgView.image = UIImage(named: bestItem.formattedName())
        }
    }
    
    
    //MARK:- Setup Cell Views
    override func setupCellViews() {
        constrainTier()
        constrainImageAndName()
        constrainCostView()
        constrainTraits()
        constrainStatsAndItemContainer()
        constrainBestItems()
        constrainDividerLine()
        constrainBaseStats()
        constrainAbilityInfo()
    }
    
    
    //MARK: Tier
    private func constrainTier() {
        contentView.addSubview(tierFlair)
        tierFlair.constrainCellFlair(to: self.contentView, width: 60, height: 17)
    }
    
    
    //MARK: Image, Name & Cost
    private func constrainImageAndName() {
        contentView.addSubviews(champImage, champName)
        NSLayoutConstraint.activate([
            champImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            champImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            champImage.heightAnchor.constraint(equalToConstant: 70),
            champImage.widthAnchor.constraint(equalTo: champImage.heightAnchor),

            champName.topAnchor.constraint(equalTo: champImage.topAnchor),
            champName.leadingAnchor.constraint(equalTo: champImage.trailingAnchor, constant: 8),
            champName.trailingAnchor.constraint(equalTo: tierFlair.leadingAnchor)
        ])
    }
    
    
    //MARK: Cost View
    private func constrainCostView() {
        contentView.addSubview(costView)
        NSLayoutConstraint.activate([
            costView.centerXAnchor.constraint(equalTo: champImage.centerXAnchor),
            costView.topAnchor.constraint(equalTo: champImage.bottomAnchor, constant: -2),
            costView.heightAnchor.constraint(equalToConstant: 13),
            costView.widthAnchor.constraint(equalToConstant: 25)
        ])
    }

    //MARK: Traits
    private func constrainTraits() {
        contentView.addSubview(traitsStack)
        NSLayoutConstraint.activate([
            traitsStack.topAnchor.constraint(equalTo: champName.bottomAnchor, constant: 2),
            traitsStack.leadingAnchor.constraint(equalTo: champName.leadingAnchor),
            traitsStack.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8),
            traitsStack.heightAnchor.constraint(equalToConstant: 19),
        ])
    }
    
    
    //MARK: Stats & Item Container
    private func constrainStatsAndItemContainer() {
        contentView.addSubview(statsBestItemContainer)
        NSLayoutConstraint.activate([
            statsBestItemContainer.topAnchor.constraint(equalTo: traitsStack.bottomAnchor, constant: 4),
            statsBestItemContainer.leadingAnchor.constraint(equalTo: traitsStack.leadingAnchor),
            statsBestItemContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            statsBestItemContainer.bottomAnchor.constraint(equalTo: costView.bottomAnchor)
        ])
    }

    //MARK: Best Items
    private func constrainBestItems() {
        (1...GameRestraints.numberOfItemsChampCanHold).forEach { _ in
            bestItemsStackView.addArrangedSubview(ItemImageView(size: 25, cornerRadius: 2.0))
        }

        statsBestItemContainer.addSubview(bestItemsStackView)
        NSLayoutConstraint.activate([
            bestItemsStackView.heightAnchor.constraint(equalToConstant: 25),
            bestItemsStackView.trailingAnchor.constraint(equalTo: statsBestItemContainer.trailingAnchor),
            bestItemsStackView.centerYAnchor.constraint(equalTo: statsBestItemContainer.centerYAnchor)
        ])
    }

    //MARK: Divider Line
    private func constrainDividerLine() {
        statsBestItemContainer.addSubview(dividerLine)
        NSLayoutConstraint.activate([
            dividerLine.widthAnchor.constraint(equalToConstant: 1),
            dividerLine.heightAnchor.constraint(equalToConstant: 34),
            dividerLine.trailingAnchor.constraint(equalTo: bestItemsStackView.leadingAnchor, constant: -10),
            dividerLine.centerYAnchor.constraint(equalTo: statsBestItemContainer.centerYAnchor)
        ])
    }
    
    //MARK: Stats
    private func constrainBaseStats() {
        statsBestItemContainer.addSubview(baseStats)
        NSLayoutConstraint.activate([
            baseStats.topAnchor.constraint(equalTo: statsBestItemContainer.topAnchor),
            baseStats.leadingAnchor.constraint(equalTo: statsBestItemContainer.leadingAnchor),
            baseStats.trailingAnchor.constraint(equalTo: dividerLine.leadingAnchor, constant: -4),
            baseStats.bottomAnchor.constraint(equalTo: statsBestItemContainer.bottomAnchor)
        ])
    }
    
    
    //MARK: Ability Info
    private func constrainAbilityInfo() {
        contentView.addSubview(abilityInfo)
        NSLayoutConstraint.activate([
            abilityInfo.leadingAnchor.constraint(equalTo: champImage.leadingAnchor),
            abilityInfo.topAnchor.constraint(equalTo: costView.bottomAnchor, constant: 8),
            abilityInfo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            abilityInfo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
