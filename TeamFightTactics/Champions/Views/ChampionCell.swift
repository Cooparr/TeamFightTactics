//
//  ChampionCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 30/07/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit
import SDWebImage

class ChampionCell: UICollectionViewCell {
    
    var champion: Champion? {
        didSet {
            guard
                let key = champion?.key,
                let name = champion?.name,
                let tier = champion?.tier,
                let cost = champion?.cost,
                let health = champion?.stats.health,
                let armor = champion?.stats.armor,
                let magicResist = champion?.stats.magicResist,
                let attackDmg = champion?.stats.attackDamage,
                let attackSpd = champion?.stats.attackSpeed,
                let range = champion?.stats.range,
                let abilityName = champion?.ability.name,
                let abilityKey = champion?.ability.key,
                let abilityType = champion?.ability.active,
                let abilityDescription = champion?.ability.abilityDescription,
                let classes = champion?.classes,
                let origins = champion?.origins,
                let bestItems = champion?.bestItems
                else { return }
            
            let manaStart = champion?.ability.manaStart ?? 0
            let manaCost = champion?.ability.manaCost ?? 0
            
            champName.text = name
            champCost.text = String(cost)
            champImage.sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.21.1/img/champion/\(key).png"))

            champHealth.text = String(health)
            champArmor.text = String(armor)
            champMagicResist.text = String(magicResist)
            champAttackDamage.text = String(attackDmg)
            champAttackSpeed.text = String(attackSpd)
            champRange.text = String(range)
            
            
            // Function Calls
            setCostColor(cost)
            setTierLabelAndColor(tier)
            setOriginAndClasses(classes, origins)
            setBestItems(bestItems)
            setChampAbilityInfo(abilityName, manaStart, manaCost, abilityDescription, abilityKey, abilityType)
        }
    }
    
    //MARK:- Override Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
        setupCellContent()
    }
    
    //MARK:- Set Cost Color
    fileprivate func setCostColor(_ cost: Int) {
        let oneCost = CustomColor.oneCost.cgColor
        let twoCost = CustomColor.twoCost.cgColor
        let threeCost = CustomColor.threeCost.cgColor
        let fourCost = CustomColor.fourCost.cgColor
        let fiveCost = CustomColor.fiveCost.cgColor
        
        switch cost {
        case 1:
            champImage.layer.borderColor = oneCost
            costView.layer.backgroundColor = oneCost
        case 2:
            champImage.layer.borderColor = twoCost
            costView.layer.backgroundColor = twoCost
        case 3:
            champImage.layer.borderColor = threeCost
            costView.layer.backgroundColor = threeCost
        case 4:
            champImage.layer.borderColor = fourCost
            costView.layer.backgroundColor = fourCost
        default:
            champImage.layer.borderColor = fiveCost
            costView.layer.backgroundColor = fiveCost
        }
    }
        
    //MARK: Set Tier Label And Color
    fileprivate func setTierLabelAndColor(_ tier: TierRating) {
        let tierText: String
        let tierColor: UIColor
        
        switch tier {
        case .sTier:
            tierText = "S Tier"
            tierColor = CustomColor.sTier
        case .aTier:
            tierText = "A Tier"
            tierColor = CustomColor.aTier
        case .bTier:
            tierText = "B Tier"
            tierColor = CustomColor.bTier
        case .cTier:
            tierText = "C Tier"
            tierColor = CustomColor.cTier
        case .dTier:
            tierText = "D Tier"
            tierColor = CustomColor.dTier
        default:
            tierText = "E Tier"
            tierColor = CustomColor.eTier
        }
        
        champTier.text = tierText
        champTier.backgroundColor = tierColor
    }
    
    //MARK: Set Origin and Class
    fileprivate func setOriginAndClasses(_ classes: [String], _ origins: [String]) {
        let classesAndOrigins = classes + origins
        
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
            if let itemIcon = bestItemsStackView.arrangedSubviews[index] as? UIImageView {
                itemIcon.image = UIImage(named: item)
            }
        }
    }
    
    //MARK: Set Champ Ability Info
    fileprivate func setChampAbilityInfo(_ abilityName: String, _ manaStart: Int, _ manaCost: Int, _ abilityDescription: String, _ abilityKey: String, _ abilityType: Bool) {
        champAbilityName.text = abilityName
        champAbilityMana.text = "\(manaStart)/\(manaCost)"
        champAbilityDescription.text = abilityDescription
        
        champAbilityIcon.sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.21.1/img/spell/\(abilityKey).png"))
        if abilityKey.hasSuffix("Passive") || abilityName == "Steel Blades" {
            champAbilityIcon.sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.21.1/img/passive/\(abilityKey).png"))
        }
        
        switch abilityType {
        case false:
            champAbilityMana.text = "Passive"
        case true:
            champAbilityMana.text = "\(manaStart)/\(manaCost)"
        }
    }
    
    //MARK:- Champ Name & Image
    let champName = ChampLabel(fontSize: 16, fontWeight: .medium)
    let champCost = ChampLabel()
    
    lazy var costView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 2.0
        return view
    }()
    
    let champCostIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(named: "Gold")
        imgView.tintColor = CustomColor.platinum
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    var champImage: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.layer.borderWidth = 2.0
        imgView.layer.cornerRadius = 2.0
        return imgView
    }()
    
    //MARK:- Champion Tier
    let champTier: ChampLabel = {
        let lbl = ChampLabel(fontSize: 12, fontWeight: .semibold)
        lbl.textColor = CustomColor.richBlack
        lbl.textAlignment = .center
        lbl.clipsToBounds = true
        lbl.layer.cornerRadius = 6.0
        lbl.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        return lbl
    }()
    
    //MARK:- Class & Origin
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
    
    
    //MARK:- Champ Stats
    let champHealth = ChampLabel()
    let champArmor = ChampLabel()
    let champMagicResist = ChampLabel()
    let champAttackDamage = ChampLabel()
    let champAttackSpeed = ChampLabel()
    let champRange = ChampLabel()
    
    let healthIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(named: "HealthIcon")
        imgView.tintColor = CustomColor.health
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    let armorIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(named: "ArmorIcon")
        imgView.tintColor = CustomColor.armor
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    let magicResistIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(named: "MagicResistIcon")
        imgView.tintColor = CustomColor.magicResist
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    let attackDamageIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(named: "AttDamageIcon")
        imgView.tintColor = CustomColor.attDamage
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    let attackSpeedIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(named: "AttSpeedIcon")
        imgView.tintColor = CustomColor.attSpeed
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    let rangeIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(named: "RangeIcon")
        imgView.tintColor = CustomColor.range
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    //MARK:- Divider Line
    let dividerLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = CustomColor.romanSilver
        return view
    }()
    
    //MARK:- Best Items
    let bestItemOne = BestItemImageView(frame: .zero)
    let bestItemTwo = BestItemImageView(frame: .zero)
    let bestItemThree = BestItemImageView(frame: .zero)
    
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
    let champAbilityName = ChampLabel(fontSize: 13, fontWeight: .semibold)
    let champAbilityMana = ChampLabel(fontSize: 11, fontWeight: .regular)
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
        imgView.layer.borderColor = CustomColor.romanSilver.cgColor
        imgView.layer.borderWidth = 1.0
        imgView.layer.cornerRadius = 2.0
        return imgView
    }()
    
    let champAbilityManaIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(named: "ManaIcon")
        imgView.tintColor = CustomColor.mana
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    //MARK:- Setup Cell
    fileprivate func setupCell() {
        backgroundColor = CustomColor.richBlack
        layer.cornerRadius = 6.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.clear.cgColor
        layer.masksToBounds = true
    }
    
    //MARK:- Setup Cell Content
    fileprivate func setupCellContent() {
        
        
        //MARK: Champ Image & Cost
        addSubview(champImage)
        addSubview(champName)
        addSubview(costView)
        costView.addSubview(champCostIcon)
        costView.addSubview(champCost)
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
            champCost.centerYAnchor.constraint(equalTo: costView.centerYAnchor),
            champCost.centerXAnchor.constraint(equalTo: costView.centerXAnchor, constant: 6)
        ])
        

        //MARK: Champ Tier
        addSubview(champTier)
        NSLayoutConstraint.activate([
            champTier.topAnchor.constraint(equalTo: topAnchor),
            champTier.trailingAnchor.constraint(equalTo: trailingAnchor),
            champTier.widthAnchor.constraint(equalToConstant: 60),
            champTier.heightAnchor.constraint(equalToConstant: 17)
        ])
        
        
        //MARK: Class & Origin
        addSubview(classOriginStackView)
        NSLayoutConstraint.activate([
            classOriginStackView.topAnchor.constraint(equalTo: champName.bottomAnchor, constant: 2),
            classOriginStackView.leadingAnchor.constraint(equalTo: champImage.trailingAnchor,constant: 8),
            classOriginStackView.heightAnchor.constraint(equalToConstant: 19)
        ])
        
        
        //MARK: Champ Stats
        addSubview(healthIcon)
        addSubview(champHealth)
        addSubview(armorIcon)
        addSubview(champArmor)
        addSubview(magicResistIcon)
        addSubview(champMagicResist)
        addSubview(attackDamageIcon)
        addSubview(champAttackDamage)
        addSubview(attackSpeedIcon)
        addSubview(champAttackSpeed)
        addSubview(rangeIcon)
        addSubview(champRange)
        addSubview(dividerLine)
        
        let statIconSize: CGFloat = 15
        let statLabelWidth: CGFloat = 38
        let statSpacing: CGFloat = 4
        NSLayoutConstraint.activate([
            healthIcon.leadingAnchor.constraint(equalTo: classOriginStackView.leadingAnchor),
            healthIcon.topAnchor.constraint(equalTo: classOriginStackView.bottomAnchor, constant: statSpacing),
            healthIcon.heightAnchor.constraint(equalToConstant: statIconSize),
            healthIcon.widthAnchor.constraint(equalTo: healthIcon.heightAnchor),
            
            champHealth.leadingAnchor.constraint(equalTo: healthIcon.trailingAnchor, constant: statSpacing),
            champHealth.topAnchor.constraint(equalTo: healthIcon.topAnchor),
            champHealth.bottomAnchor.constraint(equalTo: healthIcon.bottomAnchor),
            champHealth.widthAnchor.constraint(equalToConstant: statLabelWidth),
            
            
            armorIcon.leadingAnchor.constraint(equalTo: champHealth.trailingAnchor, constant: statSpacing),
            armorIcon.topAnchor.constraint(equalTo: healthIcon.topAnchor),
            armorIcon.heightAnchor.constraint(equalToConstant: statIconSize),
            armorIcon.widthAnchor.constraint(equalTo: armorIcon.heightAnchor),
            
            champArmor.leadingAnchor.constraint(equalTo: armorIcon.trailingAnchor, constant: statSpacing),
            champArmor.topAnchor.constraint(equalTo: armorIcon.topAnchor),
            champArmor.bottomAnchor.constraint(equalTo: armorIcon.bottomAnchor),
            champArmor.widthAnchor.constraint(equalToConstant: statLabelWidth),
            
            
            magicResistIcon.leadingAnchor.constraint(equalTo: champArmor.trailingAnchor, constant: statSpacing),
            magicResistIcon.topAnchor.constraint(equalTo: healthIcon.topAnchor),
            magicResistIcon.heightAnchor.constraint(equalToConstant: statIconSize),
            magicResistIcon.widthAnchor.constraint(equalTo: magicResistIcon.heightAnchor),
            
            champMagicResist.leadingAnchor.constraint(equalTo: magicResistIcon.trailingAnchor, constant: statSpacing),
            champMagicResist.topAnchor.constraint(equalTo: magicResistIcon.topAnchor),
            champMagicResist.bottomAnchor.constraint(equalTo: magicResistIcon.bottomAnchor),
            champMagicResist.widthAnchor.constraint(equalToConstant: 25),
            
            
            attackDamageIcon.topAnchor.constraint(equalTo: healthIcon.bottomAnchor, constant: statSpacing),
            attackDamageIcon.leadingAnchor.constraint(equalTo: classOriginStackView.leadingAnchor),
            attackDamageIcon.heightAnchor.constraint(equalToConstant: statIconSize),
            attackDamageIcon.widthAnchor.constraint(equalTo: attackDamageIcon.heightAnchor),
            
            champAttackDamage.leadingAnchor.constraint(equalTo: attackDamageIcon.trailingAnchor, constant: statSpacing),
            champAttackDamage.topAnchor.constraint(equalTo: attackDamageIcon.topAnchor),
            champAttackDamage.bottomAnchor.constraint(equalTo: attackDamageIcon.bottomAnchor),
            champAttackDamage.widthAnchor.constraint(equalToConstant: statLabelWidth),
            
            
            attackSpeedIcon.bottomAnchor.constraint(equalTo: attackDamageIcon.bottomAnchor),
            attackSpeedIcon.leadingAnchor.constraint(equalTo: armorIcon.leadingAnchor),
            attackSpeedIcon.heightAnchor.constraint(equalToConstant: statIconSize),
            attackSpeedIcon.widthAnchor.constraint(equalTo: attackSpeedIcon.heightAnchor),
            
            champAttackSpeed.leadingAnchor.constraint(equalTo: attackSpeedIcon.trailingAnchor, constant: statSpacing),
            champAttackSpeed.topAnchor.constraint(equalTo: attackSpeedIcon.topAnchor),
            champAttackSpeed.bottomAnchor.constraint(equalTo: attackSpeedIcon.bottomAnchor),
            champAttackSpeed.widthAnchor.constraint(equalToConstant: statLabelWidth),
            
            
            rangeIcon.bottomAnchor.constraint(equalTo: attackSpeedIcon.bottomAnchor),
            rangeIcon.leadingAnchor.constraint(equalTo: magicResistIcon.leadingAnchor),
            rangeIcon.heightAnchor.constraint(equalToConstant: statIconSize),
            rangeIcon.widthAnchor.constraint(equalTo: rangeIcon.heightAnchor),
            
            champRange.leadingAnchor.constraint(equalTo: rangeIcon.trailingAnchor, constant: statSpacing),
            champRange.topAnchor.constraint(equalTo: rangeIcon.topAnchor),
            champRange.bottomAnchor.constraint(equalTo: rangeIcon.bottomAnchor),
            champRange.widthAnchor.constraint(equalToConstant: 25)
        ])

        //MARK: Divider Line
        NSLayoutConstraint.activate([
            dividerLine.widthAnchor.constraint(equalToConstant: 1),
            dividerLine.heightAnchor.constraint(equalToConstant: 34),
            dividerLine.leadingAnchor.constraint(equalTo: champMagicResist.trailingAnchor, constant: 10),
            dividerLine.topAnchor.constraint(equalTo: champMagicResist.topAnchor)
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
//        addSubview(spellpowerIcon)
//        addSubview(champAbilitySpellpower)
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
            
            //        spellpowerIcon.leadingAnchor.constraint(equalTo: champAbilityMana.trailingAnchor, constant: 8),
            //        spellpowerIcon.centerYAnchor.constraint(equalTo: champAbilityName.centerYAnchor),
            //        spellpowerIcon.heightAnchor.constraint(equalToConstant: 10),
            //        spellpowerIcon.widthAnchor.constraint(equalTo: spellpowerIcon.heightAnchor),
            
            //        champAbilitySpellpower.leadingAnchor.constraint(equalTo: spellpowerIcon.trailingAnchor, constant: 4),
            //        champAbilitySpellpower.centerYAnchor.constraint(equalTo: spellpowerIcon.centerYAnchor),
            
            champAbilityDescription.topAnchor.constraint(equalTo: champAbilityName.bottomAnchor, constant: 2),
            champAbilityDescription.leadingAnchor.constraint(equalTo: champAbilityName.leadingAnchor),
            champAbilityDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    // Required
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
