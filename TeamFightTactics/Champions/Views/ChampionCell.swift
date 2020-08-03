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
    
    //MARK: Champ Name & Image
    let champName = BaseLabel(fontSize: 16, fontWeight: .medium)
    let costView = ChampCostView()
    
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
    
    //MARK: Class & Origin
    let classOneBadge = ClassOriginBadge()
    let classTwoBadge = ClassOriginBadge()
    let originOneBadge = ClassOriginBadge()
    let originTwoBadge = ClassOriginBadge()
    
    lazy var classOriginStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [classOneBadge, classTwoBadge, originOneBadge, originTwoBadge])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing =  4
        return stackView
    }()
    
    
    //MARK: Champ Stats
    let statsVerticalStack = ChampStatsStack()
    
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
    
    //MARK: Champ Ability
    let champAbilityName = BaseLabel(fontSize: 13, fontWeight: .semibold)
    let champAbilityMana = BaseLabel(fontSize: 11, fontWeight: .regular)
    let champAbilityDescription = BaseLabel(fontSize: 11, fontWeight: .regular, multiLine: true)
    
    let champAbilityIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleAspectFit
        imgView.layer.borderColor = ThemeColor.romanSilver.cgColor
        imgView.layer.borderWidth = 1.0
        imgView.layer.cornerRadius = 2.0
        return imgView
    }()
    
    let champAbilityManaIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = StatIcon.mana
        imgView.tintColor = StatIconColor.mana
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    
    //MARK:- Configure Cell
    func configureCell(with champ: Champion) {
        setChampInfo(champ.key, champ.name, champ.imgURL, champ.cost, champ.tier)
        setPatched(champ.patched)
        setOriginAndClasses(champ.classes, champ.origins)
        statsVerticalStack.setStatLabels(for: champ.stats)
        setBestItems(champ.bestItems)
        setAbilityInfo(for: champ.ability)
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
    
    //MARK: Set Origin and Class
    fileprivate func setOriginAndClasses(_ classes: [String], _ origins: [String]) {
        let classesAndOrigins = [classes, origins].flatMap({$0})
        
        classOriginStackView.arrangedSubviews.forEach({ $0.isHidden = true })
        for (i, type) in classesAndOrigins.enumerated() {
            if let badge = classOriginStackView.arrangedSubviews[i] as? ClassOriginBadge {
                badge.typeLabel.text = type
                badge.typeIcon.image = UIImage(named: "\(type)")
                badge.isHidden = false
            }
        }
    }
    
    //MARK: Set Best Items
    fileprivate func setBestItems(_ bestItems: [String]) {
        for (index, item) in bestItems.enumerated() {
            if let itemIcon = bestItemsStackView.arrangedSubviews[index] as? BestItemImageView {
                itemIcon.image = UIImage(named: item)
            }
        }
    }
    
    //MARK: Set Champ Ability Info
    fileprivate func setAbilityInfo(for champAbility: ChampionAbility) {
        champAbilityName.text = champAbility.name
        champAbilityDescription.text = champAbility.description
        champAbilityIcon.sd_setImage(with: URL(string: champAbility.imgURL))
        
        switch champAbility.active {
        case false:
            champAbilityMana.text = "Passive"
        case true:
            if let manaStart = champAbility.manaStart, let manaCost = champAbility.manaCost {
                champAbilityMana.text = "\(manaStart)/\(manaCost)"
            }
        }
    }
    
    //MARK:- Override Setup Cell View
    override func setupCellViews() {
        
        
        //MARK: Champ Image & Cost
        addSubview(costView)
        addSubview(champImage)
        addSubview(champName)
        NSLayoutConstraint.activate([
            champImage.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            champImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            champImage.heightAnchor.constraint(equalToConstant: 70),
            champImage.widthAnchor.constraint(equalTo: champImage.heightAnchor),
            
            champName.topAnchor.constraint(equalTo: champImage.topAnchor),
            champName.leadingAnchor.constraint(equalTo: champImage.trailingAnchor, constant: 8),
            
            costView.centerXAnchor.constraint(equalTo: champImage.centerXAnchor),
            costView.topAnchor.constraint(equalTo: champImage.bottomAnchor, constant: -2),
            costView.heightAnchor.constraint(equalToConstant: 13),
            costView.widthAnchor.constraint(equalToConstant: 25)
        ])
        

        //MARK: Champ Patched & Tier
        addSubview(champPatched)
        addSubview(champTier)
        let flairWidth: CGFloat = 60
        let flairHeight: CGFloat = 17
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
        
        
        //MARK: Class & Origin
        addSubview(classOriginStackView)
        NSLayoutConstraint.activate([
            classOriginStackView.topAnchor.constraint(equalTo: champName.bottomAnchor, constant: 2),
            classOriginStackView.leadingAnchor.constraint(equalTo: champImage.trailingAnchor,constant: 8),
            classOriginStackView.heightAnchor.constraint(equalToConstant: 19)
        ])
        
        
        //MARK: Champ Stats
        addSubview(statsVerticalStack)
        NSLayoutConstraint.activate([
            statsVerticalStack.topAnchor.constraint(equalTo: classOriginStackView.bottomAnchor, constant: 4),
            statsVerticalStack.leadingAnchor.constraint(equalTo: classOriginStackView.leadingAnchor),
            statsVerticalStack.bottomAnchor.constraint(equalTo: costView.bottomAnchor)
        ])
        
        
        //MARK: Divider Line
        addSubview(dividerLine)
        NSLayoutConstraint.activate([
            dividerLine.widthAnchor.constraint(equalToConstant: 1),
            dividerLine.heightAnchor.constraint(equalToConstant: 34),
            dividerLine.leadingAnchor.constraint(equalTo: statsVerticalStack.trailingAnchor, constant: 4),
            dividerLine.topAnchor.constraint(equalTo: statsVerticalStack.topAnchor)
        ])
        
        
        //MARK: Best Items
        addSubview(bestItemsStackView)
        NSLayoutConstraint.activate([
            bestItemsStackView.heightAnchor.constraint(equalToConstant: 25),
            bestItemsStackView.leadingAnchor.constraint(equalTo: dividerLine.trailingAnchor, constant: 10),
            bestItemsStackView.centerYAnchor.constraint(equalTo: dividerLine.centerYAnchor)
        ])
        
        
        //MARK: Champ Ability
        addSubview(champAbilityIcon)
        addSubview(champAbilityName)
        addSubview(champAbilityManaIcon)
        addSubview(champAbilityMana)
        addSubview(champAbilityDescription)
        NSLayoutConstraint.activate([
            champAbilityIcon.leadingAnchor.constraint(equalTo: champImage.leadingAnchor),
            champAbilityIcon.heightAnchor.constraint(equalToConstant: 30),
            champAbilityIcon.widthAnchor.constraint(equalTo: champAbilityIcon.heightAnchor),
            champAbilityIcon.topAnchor.constraint(equalTo: costView.bottomAnchor, constant: 8),
            
            champAbilityName.leadingAnchor.constraint(equalTo: champAbilityIcon.trailingAnchor, constant: 6),
            champAbilityName.topAnchor.constraint(equalTo: champAbilityIcon.topAnchor),
            
            champAbilityManaIcon.leadingAnchor.constraint(equalTo: champAbilityName.trailingAnchor, constant: 8),
            champAbilityManaIcon.centerYAnchor.constraint(equalTo: champAbilityName.centerYAnchor),
            champAbilityManaIcon.heightAnchor.constraint(equalToConstant: 10),
            champAbilityManaIcon.widthAnchor.constraint(equalTo: champAbilityManaIcon.heightAnchor),
            
            champAbilityMana.leadingAnchor.constraint(equalTo: champAbilityManaIcon.trailingAnchor, constant: 2),
            champAbilityMana.centerYAnchor.constraint(equalTo: champAbilityManaIcon.centerYAnchor),
            
            champAbilityDescription.topAnchor.constraint(equalTo: champAbilityName.bottomAnchor, constant: 2),
            champAbilityDescription.leadingAnchor.constraint(equalTo: champAbilityName.leadingAnchor),
            champAbilityDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
}
