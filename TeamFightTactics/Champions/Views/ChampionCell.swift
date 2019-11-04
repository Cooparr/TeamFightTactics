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
    fileprivate func setTierLabelAndColor(_ tier: Int) {
        switch tier {
        case 0:
            champTier.text = "S Tier"
            champTier.backgroundColor = CustomColor.sTier
        case 1:
            champTier.text = "A Tier"
            champTier.backgroundColor = CustomColor.aTier
        case 2:
            champTier.text = "B Tier"
            champTier.backgroundColor = CustomColor.bTier
        case 3:
            champTier.text = "C Tier"
            champTier.backgroundColor = CustomColor.cTier
        case 4:
            champTier.text = "D Tier"
            champTier.backgroundColor = CustomColor.dTier
        default:
            champTier.text = "E Tier"
            champTier.backgroundColor = CustomColor.eTier
        }
    }
    
    //MARK: Set Origin and Class
    fileprivate func setOriginAndClasses(_ classes: [String], _ origins: [String]) {
        classOneLabel.text = classes[0]
        classOneIcon.image = UIImage(named: "\(classes[0])")
        originOneLabel.text = origins[0]
        originOneIcon.image = UIImage(named: "\(origins[0])")
        
        if classes.count > 1 {            
            classTwoLabel.text = classes[1]
            classTwoIcon.image = UIImage(named: "\(classes[1])")
            classTwoView.isHidden = false
        }
        
        if origins.count > 1 {
            originTwoLabel.text = origins[1]
            originTwoIcon.image = UIImage(named: "\(origins[1])")
            originTwoView.isHidden = false
        }
    }
    
    //MARK: Set Best Items
    fileprivate func setBestItems(_ bestItems: [String]) {
        switch bestItems.count {
        case 3:
            bestItemThree.image = UIImage(named: bestItems[2])
            bestItemTwo.image = UIImage(named: bestItems[1])
            bestItemOne.image = UIImage(named: bestItems[0])
            bestItemThree.isHidden = false
            bestItemTwo.isHidden = false
            bestItemOne.isHidden = false
        case 2:
            bestItemTwo.image = UIImage(named: bestItems[1])
            bestItemOne.image = UIImage(named: bestItems[0])
            bestItemTwo.isHidden = false
            bestItemOne.isHidden = false
        case 1:
            bestItemOne.image = UIImage(named: bestItems[0])
            bestItemOne.isHidden = false
        default:
            bestItemOne.isHidden = true
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
    var champImage: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.layer.borderWidth = 2.0
        imgView.layer.cornerRadius = 2.0
        return imgView
    }()
    
    lazy var costView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 2.0
        return view
    }()
    
    let champCost: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.boldSystemFont(ofSize: 12)
        return lbl
    }()
    
    let champCostIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(named: "Gold")
        imgView.tintColor = CustomColor.platinum
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    let champName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return lbl
    }()
    
    //MARK:- Champion Tier
    let champTier: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = CustomColor.richBlack
        lbl.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        lbl.textAlignment = .center
        lbl.clipsToBounds = true
        lbl.layer.cornerRadius = 6.0
        lbl.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        return lbl
    }()
    
    //MARK:- Class & Origin
    let classOneIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.tintColor = CustomColor.platinum
        return imgView
    }()
    
    let classOneLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.systemFont(ofSize: 12)
        return lbl
    }()
    
    let classTwoIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.tintColor = CustomColor.platinum
        return imgView
    }()
    
    let classTwoLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.systemFont(ofSize: 12)
        return lbl
    }()
    
    let originOneIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.tintColor = CustomColor.platinum
        return imgView
    }()
    
    let originOneLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.systemFont(ofSize: 12)
        return lbl
    }()
    
    let originTwoIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.tintColor = CustomColor.platinum
        return imgView
    }()
    
    let originTwoLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.systemFont(ofSize: 12)
        return lbl
    }()
    
    let classOneView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = CustomColor.romanSilver
        view.layer.cornerRadius = 2.0
        return view
    }()
    
    let classTwoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = CustomColor.romanSilver
        view.layer.cornerRadius = 2.0
        view.isHidden = true
        return view
    }()
    
    let originOneView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = CustomColor.romanSilver
        view.layer.cornerRadius = 2.0
        return view
    }()
    
    let originTwoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = CustomColor.romanSilver
        view.layer.cornerRadius = 2.0
        view.isHidden = true
        return view
    }()
    
    lazy var classOriginStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [classOneView, classTwoView, originOneView, originTwoView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing =  4
        return stackView
    }()
    
    
    //MARK:- Champ Stats
    let champHealth: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.boldSystemFont(ofSize: 12)
        return lbl
    }()
    
    let champArmor: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.boldSystemFont(ofSize: 12)
        return lbl
    }()
    
    let champMagicResist: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.boldSystemFont(ofSize: 12)
        return lbl
    }()
    
    let champAttackDamage: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.boldSystemFont(ofSize: 12)
        return lbl
    }()
    
    let champAttackSpeed: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.boldSystemFont(ofSize: 12)
        return lbl
    }()
    
    let champRange: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.boldSystemFont(ofSize: 12)
        return lbl
    }()
    
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
    let bestItemOne: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleAspectFit
        imgView.layer.borderColor = CustomColor.romanSilver.cgColor
        imgView.layer.borderWidth = 1.0
        imgView.layer.cornerRadius = 2.0
        imgView.layer.masksToBounds = true
        return imgView
    }()
    
    let bestItemTwo: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleAspectFit
        imgView.layer.borderColor = CustomColor.romanSilver.cgColor
        imgView.layer.borderWidth = 1.0
        imgView.layer.cornerRadius = 2.0
        imgView.layer.masksToBounds = true
        imgView.isHidden = true
        return imgView
    }()
    
    let bestItemThree: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleAspectFit
        imgView.layer.borderColor = CustomColor.romanSilver.cgColor
        imgView.layer.borderWidth = 1.0
        imgView.layer.cornerRadius = 2.0
        imgView.layer.masksToBounds = true
        imgView.isHidden = true
        return imgView
    }()
    
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
    
    let champAbilityName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        return lbl
    }()
    
    let manaIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(named: "ManaIcon")
        imgView.tintColor = CustomColor.mana
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
//    let spellpowerIcon: UIImageView = {
//        let imgView = UIImageView()
//        imgView.translatesAutoresizingMaskIntoConstraints = false
//        imgView.image = UIImage(named: "SpellPowerIcon")
//        imgView.tintColor = CustomColor.spellPowerColor
//        imgView.contentMode = .scaleAspectFit
//        return imgView
//    }()
    
    let champAbilityMana: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.systemFont(ofSize: 11)
        return lbl
    }()
    
//    let champAbilitySpellpower: UILabel = {
//        let lbl = UILabel()
//        lbl.translatesAutoresizingMaskIntoConstraints = false
//        lbl.text = "???"
//        lbl.textColor = CustomColor.platinum
//        lbl.font = UIFont.systemFont(ofSize: 11)
//        return lbl
//    }()
    
    let champAbilityDescription: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 11)
        lbl.textColor = CustomColor.platinum
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        return lbl
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
        
        
        classOneView.addSubview(classOneIcon)
        classOneView.addSubview(classOneLabel)
        classTwoView.addSubview(classTwoIcon)
        classTwoView.addSubview(classTwoLabel)
        originOneView.addSubview(originOneIcon)
        originOneView.addSubview(originOneLabel)
        originTwoView.addSubview(originTwoIcon)
        originTwoView.addSubview(originTwoLabel)
        
        let iconHeight: CGFloat = 17
        let iconWidth: CGFloat = 15
        let leadSpacing: CGFloat = 2
        let trailSpacing: CGFloat = -4
        NSLayoutConstraint.activate([
            classOneIcon.heightAnchor.constraint(equalToConstant: iconHeight),
            classOneIcon.widthAnchor.constraint(equalToConstant: iconWidth),
            classOneIcon.leadingAnchor.constraint(equalTo: classOneView.leadingAnchor, constant: leadSpacing),
            classOneIcon.topAnchor.constraint(equalTo: classOneView.topAnchor),
            classOneIcon.trailingAnchor.constraint(equalTo: classOneLabel.leadingAnchor),
            classOneIcon.bottomAnchor.constraint(equalTo: classOneView.bottomAnchor),
            classOneLabel.leadingAnchor.constraint(equalTo: classOneIcon.trailingAnchor),
            classOneLabel.topAnchor.constraint(equalTo: classOneView.topAnchor),
            classOneLabel.trailingAnchor.constraint(equalTo: classOneView.trailingAnchor, constant: trailSpacing),
            classOneLabel.bottomAnchor.constraint(equalTo: classOneView.bottomAnchor),
            
            classTwoIcon.heightAnchor.constraint(equalToConstant: iconHeight),
            classTwoIcon.widthAnchor.constraint(equalToConstant: iconWidth),
            classTwoIcon.leadingAnchor.constraint(equalTo: classTwoView.leadingAnchor, constant: leadSpacing),
            classTwoIcon.topAnchor.constraint(equalTo: classTwoView.topAnchor),
            classTwoIcon.trailingAnchor.constraint(equalTo: classTwoLabel.leadingAnchor),
            classTwoIcon.bottomAnchor.constraint(equalTo: classTwoView.bottomAnchor),
            classTwoLabel.leadingAnchor.constraint(equalTo: classTwoIcon.trailingAnchor),
            classTwoLabel.topAnchor.constraint(equalTo: classTwoView.topAnchor),
            classTwoLabel.trailingAnchor.constraint(equalTo: classTwoView.trailingAnchor, constant: trailSpacing),
            classTwoLabel.bottomAnchor.constraint(equalTo: classTwoView.bottomAnchor),
            
            
            originOneIcon.heightAnchor.constraint(equalToConstant: iconHeight),
            originOneIcon.widthAnchor.constraint(equalToConstant: iconWidth),
            originOneIcon.leadingAnchor.constraint(equalTo: originOneView.leadingAnchor, constant: leadSpacing),
            originOneIcon.topAnchor.constraint(equalTo: originOneView.topAnchor),
            originOneIcon.trailingAnchor.constraint(equalTo: originOneLabel.leadingAnchor),
            originOneIcon.bottomAnchor.constraint(equalTo: originOneView.bottomAnchor),
            originOneLabel.leadingAnchor.constraint(equalTo: originOneIcon.trailingAnchor),
            originOneLabel.topAnchor.constraint(equalTo: originOneView.topAnchor),
            originOneLabel.trailingAnchor.constraint(equalTo: originOneView.trailingAnchor, constant: trailSpacing),
            originOneLabel.bottomAnchor.constraint(equalTo: originOneView.bottomAnchor),
            
            originTwoIcon.heightAnchor.constraint(equalToConstant: iconHeight),
            originTwoIcon.widthAnchor.constraint(equalToConstant: iconWidth),
            originTwoIcon.leadingAnchor.constraint(equalTo: originTwoView.leadingAnchor, constant: leadSpacing),
            originTwoIcon.topAnchor.constraint(equalTo: originTwoView.topAnchor),
            originTwoIcon.trailingAnchor.constraint(equalTo: originTwoLabel.leadingAnchor),
            originTwoIcon.bottomAnchor.constraint(equalTo: originTwoView.bottomAnchor),
            originTwoLabel.leadingAnchor.constraint(equalTo: originTwoIcon.trailingAnchor),
            originTwoLabel.topAnchor.constraint(equalTo: originTwoView.topAnchor),
            originTwoLabel.trailingAnchor.constraint(equalTo: originTwoView.trailingAnchor, constant: trailSpacing),
            originTwoLabel.bottomAnchor.constraint(equalTo: originTwoView.bottomAnchor)
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
        let itemWidthHeight: CGFloat = 25
        addSubview(bestItemsStackView)
        NSLayoutConstraint.activate([
            bestItemsStackView.heightAnchor.constraint(equalToConstant: itemWidthHeight),
            bestItemsStackView.leadingAnchor.constraint(equalTo: dividerLine.trailingAnchor, constant: 10),
            bestItemsStackView.centerYAnchor.constraint(equalTo: dividerLine.centerYAnchor),
            
            bestItemOne.widthAnchor.constraint(equalToConstant: itemWidthHeight),
            bestItemTwo.widthAnchor.constraint(equalToConstant: itemWidthHeight),
            bestItemThree.widthAnchor.constraint(equalToConstant: itemWidthHeight)
        ])
        
        
        //MARK: Champ Ability
        addSubview(champAbilityIcon)
        addSubview(champAbilityName)
        addSubview(manaIcon)
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
            
            manaIcon.leadingAnchor.constraint(equalTo: champAbilityName.trailingAnchor, constant: 8),
            manaIcon.centerYAnchor.constraint(equalTo: champAbilityName.centerYAnchor),
            manaIcon.heightAnchor.constraint(equalToConstant: 10),
            manaIcon.widthAnchor.constraint(equalTo: manaIcon.heightAnchor),
            
            champAbilityMana.leadingAnchor.constraint(equalTo: manaIcon.trailingAnchor, constant: 2),
            champAbilityMana.centerYAnchor.constraint(equalTo: manaIcon.centerYAnchor),
            
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
