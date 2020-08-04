//
//  ChampionCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 30/07/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit
import SDWebImage

class ChampionCell: BaseCell, ReusableCell {
    
    //MARK:- Properties
    typealias DataType = Champion
    static var reuseId: String = "championCellId"
    
    let champName = BaseLabel(fontSize: 16, fontWeight: .medium)
    let costView = ChampCostView()
    let traitsStack = ChampTraitStack()
    let baseStats = ChampStatsStack()
    let abilityInfo = ChampAbilityView()
    
    let champImage: UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.layer.borderWidth = 2.0
        imgView.layer.cornerRadius = 2.0
        imgView.clipsToBounds = true
        return imgView
    }()
    
    
    //MARK: Champion Patched & Tier
    let champTier: BaseLabel = {
        let lbl = BaseLabel(fontSize: 12, fontWeight: .semibold, fontColor: ThemeColor.richBlack)
        lbl.textAlignment = .center
        lbl.clipsToBounds = true
        lbl.layer.cornerRadius = 6.0
        lbl.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        return lbl
    }()
    
    let champPatched: BaseLabel = {
        let lbl = BaseLabel(fontSize: 12, fontWeight: .semibold, fontColor: ThemeColor.richBlack)
        lbl.textAlignment = .center
        lbl.clipsToBounds = true
        lbl.layer.cornerRadius = 6.0
        lbl.layer.maskedCorners = [.layerMinXMaxYCorner]
        return lbl
    }()
    
    
    //MARK: Divider Line
    let dividerLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ThemeColor.romanSilver
        return view
    }()
    
    
    //MARK: Best Items
    let bestItemsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [BestItemImageView(), BestItemImageView(), BestItemImageView()])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing =  4
        return stackView
    }()
    
    
    //MARK:- Configure Cell
    func configureCell(with champ: Champion) {
        setChampInfo(champ.key, champ.name, champ.imgURL, champ.cost, champ.tier)
        setPatched(champ.patched)
        traitsStack.setTraitBadges(champ.classes, champ.origins)
        baseStats.setStatLabels(for: champ.stats)
        setBestItems(champ.bestItems)
        abilityInfo.setAbilityInfo(for: champ.ability)
    }
    
    
    //MARK:- Override Setup Cell
    override func setupCell() {
        backgroundColor = ThemeColor.richBlack
        layer.cornerRadius = 6.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.clear.cgColor
        layer.masksToBounds = true
    }
    
    
    //MARK:- Prepare For Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        champImage.layer.borderWidth = 2
        
        
        costView.costIcon.tintColor = ThemeColor.platinum
        costView.costLabel.textColor = ThemeColor.platinum
        if let sublayers = costView.layer.sublayers {
            for layer in sublayers {
                if layer.name == "gradientLayer" {
                    layer.removeFromSuperlayer()
                }
            }
        }
    }
    
    
    //MARK:- Set Champ Info
    fileprivate func setChampInfo(_ champKey: String, _ name: String, _ imgURL: String, _ cost: Cost, _ tier: TierRating) {
        champName.text = name
        champImage.useStandardOrSetSkin(imgURL, champKey)
        costView.configureCostView(for: cost)
        cost.setChampImageBorder(for: champImage)
        tier.setTierTextAndColor(for: champTier)
    }
    
    
    //MARK: Set Patched
    fileprivate func setPatched(_ patched: String?) {
        guard let patched = patched else { return }
        switch patched {
        case "buff":
            champPatched.text = "Buff"
            champPatched.backgroundColor = TierRatingColor.buffed
        case "nerf":
            champPatched.text = "Nerf"
            champPatched.backgroundColor = TierRatingColor.nerfed
        default:
            champPatched.backgroundColor = .clear
        }
    }
    
    
    //MARK: Set Best Items
    fileprivate func setBestItems(_ bestItems: [String]) {
        for (index, bestItem) in bestItems.enumerated() {
            if let view = bestItemsStackView.arrangedSubviews[index] as? BestItemImageView {
                view.image = UIImage(named: bestItem)
            }
        }
    }
    
    
    //MARK:- Setup Cell Views
    override func setupCellViews() {
        constrainImageAndName()
        constrainCostView()
        constrainTierAndPatched()
        constrainTraits()
        constrainBaseStats()
        constrainDividerLine()
        constrainBestItems()
        constrainAbilityInfo()
    }
    
    
    //MARK: Image, Name & Cost
    fileprivate func constrainImageAndName() {
        addSubview(champImage)
        addSubview(champName)
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
    
    
    //MARK: Tier & Patched
    fileprivate func constrainTierAndPatched() {
        let flairWidth: CGFloat = 60
        let flairHeight: CGFloat = 17
        addSubview(champPatched)
        addSubview(champTier)
        NSLayoutConstraint.activate([
            champTier.topAnchor.constraint(equalTo: topAnchor),
            champTier.trailingAnchor.constraint(equalTo: trailingAnchor),
            champTier.widthAnchor.constraint(equalToConstant: flairWidth),
            champTier.heightAnchor.constraint(equalToConstant: flairHeight),
            
            champPatched.topAnchor.constraint(equalTo: topAnchor),
            champPatched.trailingAnchor.constraint(equalTo: champTier.leadingAnchor, constant: 5),
            champPatched.widthAnchor.constraint(equalToConstant: flairWidth),
            champPatched.heightAnchor.constraint(equalToConstant: flairHeight)
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
    
    
    //MARK: Stats
    fileprivate func constrainBaseStats() {
        addSubview(baseStats)
        NSLayoutConstraint.activate([
            baseStats.topAnchor.constraint(equalTo: traitsStack.bottomAnchor, constant: 4),
            baseStats.leadingAnchor.constraint(equalTo: traitsStack.leadingAnchor),
            baseStats.bottomAnchor.constraint(equalTo: costView.bottomAnchor)
        ])
    }
    
    
    //MARK: Divider Line
    fileprivate func constrainDividerLine() {
        addSubview(dividerLine)
        NSLayoutConstraint.activate([
            dividerLine.widthAnchor.constraint(equalToConstant: 1),
            dividerLine.heightAnchor.constraint(equalToConstant: 34),
            dividerLine.leadingAnchor.constraint(equalTo: baseStats.trailingAnchor, constant: 4),
            dividerLine.topAnchor.constraint(equalTo: baseStats.topAnchor)
        ])
    }
    
    
    //MARK: Best Items
    fileprivate func constrainBestItems() {
        addSubview(bestItemsStackView)
        NSLayoutConstraint.activate([
            bestItemsStackView.heightAnchor.constraint(equalToConstant: 25),
            bestItemsStackView.leadingAnchor.constraint(equalTo: dividerLine.trailingAnchor, constant: 10),
            bestItemsStackView.centerYAnchor.constraint(equalTo: dividerLine.centerYAnchor)
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
