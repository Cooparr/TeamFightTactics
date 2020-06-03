//
//  ChampionCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 30/07/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit
import SDWebImage

class ChampionCell: BaseCell {
    
    var champion: Champion? {
        didSet {
            guard
                let key: String = champion?.key,
                let name: String = champion?.name,
                let imgURL: String = champion?.imgURL,
                let tier: TierRating = champion?.tier,
                let patched: String = champion?.patched,
                let cost: Cost = champion?.cost,
                let health: Int = champion?.stats.health,
                let armor: Int = champion?.stats.armor,
                let magicResist: Int = champion?.stats.magicResist,
                let attackDmg: Int = champion?.stats.attackDamage,
                let attackSpd: Double = champion?.stats.attackSpeed,
                let range: Int = champion?.stats.range,
                let abilityName: String = champion?.ability.name,
                let abilityImgURL: String = champion?.ability.imgURL,
                let abilityType: Bool = champion?.ability.active,
                let abilityDescription: String = champion?.ability.abilityDescription,
                let classes: [String] = champion?.classes,
                let origins: [String] = champion?.origins,
                let bestItems: [String] = champion?.bestItems
                else { return }
            
            let manaStart: Int = champion?.ability.manaStart ?? 0
            let manaCost: Int = champion?.ability.manaCost ?? 0
            
            // Function Calls
            setChampImage(imgURL, key)
            setChampNameAndCost(name, cost)
            setTierLabel(tier)
            setPatched(patched)
            setOriginAndClasses(classes, origins)
            setStatLabelText(for: health, for: armor, for: magicResist, for: attackDmg, for: attackSpd, for: range)
            setBestItems(bestItems)
            setChampAbilityInfo(abilityName, manaStart, manaCost, abilityDescription, key, abilityImgURL, abilityType)
        }
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
        
        
        champCostIcon.tintColor = ThemeColor.platinum
        champCostLabel.textColor = ThemeColor.platinum
        if let sublayers = costView.layer.sublayers {
            for layer in sublayers {
                if layer.name == "gradientLayer" {
                    layer.removeFromSuperlayer()
                }
            }
        }
    }
    
    //MARK:- Set Champ Image
    fileprivate func setChampImage(_ imgURL: String, _ champKey: String) {
        champImage.useStandardOrSetSkin(imgURL, champKey)
    }
    
    //MARK: Set Champ Name & Cost
    fileprivate func setChampNameAndCost(_ name: String, _ cost: Cost) {
        cost.setChampImageBorder(for: champImage)
        cost.setChampCostView(for: costView, icon: champCostIcon, label: champCostLabel)
        champName.text = name
        champCostLabel.text = String(cost.rawValue)
    }
    
    //MARK: Set Tier Label And Color
    fileprivate func setTierLabel(_ tier: TierRating) {
        tier.setTierTextAndColor(for: champTier)
    }
    
    //MARK: Set Patched
    fileprivate func setPatched(_ patched: String) {
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
    
    //MARK: Set Stat Label Text Values
    fileprivate func setStatLabelText(for health: Int, for armor: Int, for magicResist: Int, for attackDmg: Int, for attackSpd: Double, for range: Int) {
        healthStat.statLabel.text = String(health)
        armorStat.statLabel.text = String(armor)
        magicResistStat.statLabel.text = String(magicResist)
        attackDamageStat.statLabel.text = String(attackDmg)
        attackSpeedStat.statLabel.text = String(attackSpd)
        rangeStat.statLabel.text = String(range)
    }
    
    //MARK: Set Best Items
    fileprivate func setBestItems(_ bestItems: [String]) {
        for (index, item) in bestItems.enumerated() {
            if let itemIcon = bestItemsStackView.arrangedSubviews[index] as? UIImageView {
                itemIcon.image = UIImage(named: item)
            }
        }
    }
    
    //MARK: Set Champ Ability Info
    fileprivate func setChampAbilityInfo(_ abilityName: String, _ manaStart: Int, _ manaCost: Int, _ abilityDescription: String, _ champKey: String, _ abilityImgURL: String, _ abilityType: Bool) {
        champAbilityName.text = abilityName
        champAbilityMana.text = "\(manaStart)/\(manaCost)"
        champAbilityDescription.text = abilityDescription
        champAbilityIcon.sd_setImage(with: URL(string: abilityImgURL))
        
        switch abilityType {
        case false:
            champAbilityMana.text = "Passive"
        case true:
            champAbilityMana.text = "\(manaStart)/\(manaCost)"
        }
    }
    
    //MARK:- Champ Name & Image
    let champName = ChampLabel(fontSize: 16, fontWeight: .medium)
    let champCostLabel = ChampLabel(fontSize: 12, fontWeight: .bold)
    
    let costView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 13))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 2.0
        return view
    }()
    
    let champCostIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(named: "Gold")
        imgView.tintColor = ThemeColor.platinum
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    let champImage: UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.layer.borderWidth = 2.0
        imgView.layer.cornerRadius = 2.0
        imgView.clipsToBounds = true
        return imgView
    }()
    
    //MARK:- Champion Patched & Tier
    let champTier: ChampLabel = {
        let lbl = ChampLabel(fontSize: 12, fontWeight: .semibold)
        lbl.textColor = ThemeColor.richBlack
        lbl.textAlignment = .center
        lbl.clipsToBounds = true
        lbl.layer.cornerRadius = 6.0
        lbl.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        return lbl
    }()
    
    let champPatched: ChampLabel = {
        let lbl = ChampLabel(fontSize: 12, fontWeight: .semibold)
        lbl.textColor = ThemeColor.richBlack
        lbl.textAlignment = .center
        lbl.clipsToBounds = true
        lbl.layer.cornerRadius = 6.0
        lbl.layer.maskedCorners = [.layerMinXMaxYCorner]
        return lbl
    }()
    
    //MARK:- Class & Origin
    let classOneBadge: ClassOriginBadge = ClassOriginBadge()
    let classTwoBadge: ClassOriginBadge = ClassOriginBadge()
    let originOneBadge: ClassOriginBadge = ClassOriginBadge()
    let originTwoBadge: ClassOriginBadge = ClassOriginBadge()
    
    lazy var classOriginStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [classOneBadge, classTwoBadge, originOneBadge, originTwoBadge])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing =  4
        return stackView
    }()
    
    
    //MARK:- Champ Stats
    let healthStat: ChampStat = ChampStat(image: UIImage(named: "HealthIcon"), iconColor: StatIconColor.health)
    let armorStat: ChampStat = ChampStat(image: UIImage(named: "ArmorIcon"), iconColor: StatIconColor.armor)
    let magicResistStat: ChampStat = ChampStat(image: UIImage(named: "MagicResistIcon"), iconColor: StatIconColor.magicResist)
    let attackDamageStat: ChampStat = ChampStat(image: UIImage(named: "AttDamageIcon"), iconColor: StatIconColor.attDamage)
    let attackSpeedStat: ChampStat = ChampStat(image: UIImage(named: "AttSpeedIcon"), iconColor: StatIconColor.attSpeed)
    let rangeStat: ChampStat = ChampStat(image: UIImage(named: "RangeIcon"), iconColor: StatIconColor.range)
    
    
    //MARK:- Divider Line
    let dividerLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ThemeColor.romanSilver
        return view
    }()
    
    //MARK:- Best Items
    let bestItemOne: BestItemImageView = BestItemImageView()
    let bestItemTwo: BestItemImageView = BestItemImageView()
    let bestItemThree: BestItemImageView = BestItemImageView()
    
    lazy var bestItemsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [bestItemOne, bestItemTwo, bestItemThree])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing =  4
        return stackView
    }()
    
    //MARK:- Champ Ability
    let champAbilityName: ChampLabel = ChampLabel(fontSize: 13, fontWeight: .semibold)
    let champAbilityMana: ChampLabel = ChampLabel(fontSize: 11, fontWeight: .regular)
    let champAbilityDescription: ChampLabel = {
        let lbl = ChampLabel(fontSize: 11, fontWeight: .regular)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    lazy var champAbilityIcon: UIImageView = {
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
        imgView.image = UIImage(named: "ManaIcon")
        imgView.tintColor = StatIconColor.mana
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    
    //MARK:- Override Setup Cell View
    override func setupCellViews() {
        
        
        //MARK: Champ Image & Cost
        addSubview(costView)
        addSubview(champImage)
        addSubview(champName)
        costView.addSubview(champCostIcon)
        costView.addSubview(champCostLabel)
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
            costView.widthAnchor.constraint(equalToConstant: 25),
            
            champCostIcon.centerYAnchor.constraint(equalTo: costView.centerYAnchor),
            champCostIcon.centerXAnchor.constraint(equalTo: costView.centerXAnchor, constant: -5),
            champCostIcon.widthAnchor.constraint(equalToConstant: 10),
            champCostLabel.centerYAnchor.constraint(equalTo: costView.centerYAnchor),
            champCostLabel.centerXAnchor.constraint(equalTo: costView.centerXAnchor, constant: 6)
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
        addSubview(healthStat)
        addSubview(armorStat)
        addSubview(magicResistStat)
        addSubview(attackDamageStat)
        addSubview(attackSpeedStat)
        addSubview(rangeStat)

        let statSpacing: CGFloat = 4
        NSLayoutConstraint.activate([
            healthStat.leadingAnchor.constraint(equalTo: classOriginStackView.leadingAnchor),
            healthStat.topAnchor.constraint(equalTo: classOriginStackView.bottomAnchor, constant: statSpacing),
            armorStat.leadingAnchor.constraint(equalTo: healthStat.trailingAnchor, constant: statSpacing),
            armorStat.topAnchor.constraint(equalTo: healthStat.topAnchor),
            magicResistStat.leadingAnchor.constraint(equalTo: armorStat.trailingAnchor, constant: statSpacing),
            magicResistStat.topAnchor.constraint(equalTo: healthStat.topAnchor),
            attackDamageStat.leadingAnchor.constraint(equalTo: classOriginStackView.leadingAnchor),
            attackDamageStat.topAnchor.constraint(equalTo: healthStat.bottomAnchor, constant: statSpacing),
            attackSpeedStat.leadingAnchor.constraint(equalTo: armorStat.leadingAnchor),
            attackSpeedStat.topAnchor.constraint(equalTo: attackDamageStat.topAnchor),
            rangeStat.leadingAnchor.constraint(equalTo: magicResistStat.leadingAnchor),
            rangeStat.topAnchor.constraint(equalTo: attackDamageStat.topAnchor)
        ])

        //MARK: Divider Line
        addSubview(dividerLine)
        NSLayoutConstraint.activate([
            dividerLine.widthAnchor.constraint(equalToConstant: 1),
            dividerLine.heightAnchor.constraint(equalToConstant: 34),
            dividerLine.leadingAnchor.constraint(equalTo: magicResistStat.trailingAnchor, constant: 4),
            dividerLine.topAnchor.constraint(equalTo: magicResistStat.topAnchor)
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
