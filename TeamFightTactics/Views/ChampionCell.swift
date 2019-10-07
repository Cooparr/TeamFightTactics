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
    
    let placeholderImage = UIImage(named: "Neeko.png")

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
                let abilityType = champion?.ability.active,
                let abilityDescription = champion?.ability.abilityDescription,
                let classes = champion?.classes,
                let origins = champion?.origins,
                let bestItems = champion?.bestItems
                else { return }
            
            let manaStart = champion?.ability.manaStart ?? 0
            let manaCost = champion?.ability.manaCost ?? 0
            
//                //Spell power is iffy becasue its of type: AbilityStat, Best Items is an array of differing counts also iffy
//            guard let spellPower = champion?.ability.stats else { return }
            
//            print(name)
//            for spell in spellPower {
            // Remember this vv
//                guard case Value.string(let spellString) = spell.value else { break }
//
//                // This is just horrible / Feels Bad, should scrap / think of alternative
//                print(spellString)
//                switch spell.type {
//                case "Damage": // General
//                    champAbilitySpellpower.text = spellString
//                case "Number of Spiderlings": // Elise
//                    champAbilitySpellpower.text = spellString
//                case "Max Health Damage": // Vayne
//                    champAbilitySpellpower.text = spellString
//                case "Damage Multiplier": // Graves
//                    champAbilitySpellpower.text = spellString
//                case "Mana Steal": // Kassadin
//                    champAbilitySpellpower.text = spellString
//                case "Charge Damage": // Trist
//                    champAbilitySpellpower.text = spellString
//                case "Total Damage": // Garen
//                    champAbilitySpellpower.text = spellString
//                case "HoT total heal": // Nidalee
//                    champAbilitySpellpower.text = spellString
//                default:
//                    champAbilitySpellpower.text = "???"
//                    print(name)
//                    print("No Match")
//                    print(spell)
//                }
//            }

////            For each works better than simple for loop
////            spellPower.forEach { (spell) in
////            }
//
//            print("----\n")
            
            
            champName.text = name
            champCost.text = String(cost)
            champImage.sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.13.1/img/champion/\(key).png"), placeholderImage: placeholderImage)

            champHealth.text = String(health)
            champArmor.text = String(armor)
            champMagicResist.text = String(magicResist)
            champAttackDamage.text = String(attackDmg)
            champAttackSpeed.text = String(attackSpd)
            champRange.text = String(range)

            champAbilityName.text = abilityName
            champAbilityMana.text = "\(manaStart)/\(manaCost)"
            champAbilityDescription.text = abilityDescription
            champAbilityIcon.sd_setImage(with: URL(string: "https://solomid-resources.s3.amazonaws.com/blitz/tft/champion_abilities/\(key).png"), placeholderImage: placeholderImage)

            // Function Calls
            setCostColor(cost)
            setTierLabelAndColor(tier)
            setOriginAndClasses(classes, origins)
            setBestItems(bestItems)
            setManaLabel(abilityType, manaStart, manaCost)
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
//            bestItemsLabel.isHidden = false
        case 2:
            bestItemTwo.image = UIImage(named: bestItems[1])
            bestItemOne.image = UIImage(named: bestItems[0])
            bestItemTwo.isHidden = false
            bestItemOne.isHidden = false
//            bestItemsLabel.isHidden = false
        case 1:
            bestItemOne.image = UIImage(named: bestItems[0])
            bestItemOne.isHidden = false
//            bestItemsLabel.isHidden = false
        default:
            bestItemOne.isHidden = true
//            bestItemsLabel.isHidden = true
        }
    }
    
    //MARK: Set Mana Label
    fileprivate func setManaLabel(_ abilityType: Bool, _ manaStart: Int, _ manaCost: Int) {
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
//    let bestItemsLabel: UILabel = {
//        let lbl = UILabel()
//        lbl.translatesAutoresizingMaskIntoConstraints = false
//        lbl.text = "Best Items"
//        lbl.textColor = CustomColor.platinum
//        lbl.font = UIFont.systemFont(ofSize: 11)
//        lbl.textAlignment = .center
//        return lbl
//    }()
    
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

        champImage.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        champImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        champImage.heightAnchor.constraint(equalToConstant: 70).isActive = true
        champImage.widthAnchor.constraint(equalTo: champImage.heightAnchor).isActive = true
        
        champName.topAnchor.constraint(equalTo: champImage.topAnchor).isActive = true
        champName.leadingAnchor.constraint(equalTo: champImage.trailingAnchor, constant: 8).isActive = true
        
        costView.centerXAnchor.constraint(equalTo: champImage.centerXAnchor).isActive = true
        costView.topAnchor.constraint(equalTo: champImage.bottomAnchor, constant: -2).isActive = true
        costView.heightAnchor.constraint(equalToConstant: 13).isActive = true
        costView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        champCostIcon.centerYAnchor.constraint(equalTo: costView.centerYAnchor).isActive = true
        champCostIcon.centerXAnchor.constraint(equalTo: costView.centerXAnchor, constant: -5).isActive = true
        champCostIcon.widthAnchor.constraint(equalToConstant: 10).isActive = true
        champCost.centerYAnchor.constraint(equalTo: costView.centerYAnchor).isActive = true
        champCost.centerXAnchor.constraint(equalTo: costView.centerXAnchor, constant: 6).isActive = true

        //MARK: Champ Tier
        addSubview(champTier)
        champTier.topAnchor.constraint(equalTo: topAnchor).isActive = true
        champTier.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        champTier.widthAnchor.constraint(equalToConstant: 60).isActive = true
        champTier.heightAnchor.constraint(equalToConstant: 17).isActive = true
        
        
        //MARK: Class & Origin
        addSubview(classOriginStackView)
        classOriginStackView.topAnchor.constraint(equalTo: champName.bottomAnchor, constant: 2).isActive = true
        classOriginStackView.leadingAnchor.constraint(equalTo: champImage.trailingAnchor,constant: 8).isActive = true
        classOriginStackView.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
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
        classOneIcon.heightAnchor.constraint(equalToConstant: iconHeight).isActive = true
        classOneIcon.widthAnchor.constraint(equalToConstant: iconWidth).isActive = true
        classOneIcon.leadingAnchor.constraint(equalTo: classOneView.leadingAnchor, constant: leadSpacing).isActive = true
        classOneIcon.topAnchor.constraint(equalTo: classOneView.topAnchor).isActive = true
        classOneIcon.trailingAnchor.constraint(equalTo: classOneLabel.leadingAnchor).isActive = true
        classOneIcon.bottomAnchor.constraint(equalTo: classOneView.bottomAnchor).isActive = true
        classOneLabel.leadingAnchor.constraint(equalTo: classOneIcon.trailingAnchor).isActive = true
        classOneLabel.topAnchor.constraint(equalTo: classOneView.topAnchor).isActive = true
        classOneLabel.trailingAnchor.constraint(equalTo: classOneView.trailingAnchor, constant: trailSpacing).isActive = true
        classOneLabel.bottomAnchor.constraint(equalTo: classOneView.bottomAnchor).isActive = true
        
        classTwoIcon.heightAnchor.constraint(equalToConstant: iconHeight).isActive = true
        classTwoIcon.widthAnchor.constraint(equalToConstant: iconWidth).isActive = true
        classTwoIcon.leadingAnchor.constraint(equalTo: classTwoView.leadingAnchor, constant: leadSpacing).isActive = true
        classTwoIcon.topAnchor.constraint(equalTo: classTwoView.topAnchor).isActive = true
        classTwoIcon.trailingAnchor.constraint(equalTo: classTwoLabel.leadingAnchor).isActive = true
        classTwoIcon.bottomAnchor.constraint(equalTo: classTwoView.bottomAnchor).isActive = true
        classTwoLabel.leadingAnchor.constraint(equalTo: classTwoIcon.trailingAnchor).isActive = true
        classTwoLabel.topAnchor.constraint(equalTo: classTwoView.topAnchor).isActive = true
        classTwoLabel.trailingAnchor.constraint(equalTo: classTwoView.trailingAnchor, constant: trailSpacing).isActive = true
        classTwoLabel.bottomAnchor.constraint(equalTo: classTwoView.bottomAnchor).isActive = true
        
        
        originOneIcon.heightAnchor.constraint(equalToConstant: iconHeight).isActive = true
        originOneIcon.widthAnchor.constraint(equalToConstant: iconWidth).isActive = true
        originOneIcon.leadingAnchor.constraint(equalTo: originOneView.leadingAnchor, constant: leadSpacing).isActive = true
        originOneIcon.topAnchor.constraint(equalTo: originOneView.topAnchor).isActive = true
        originOneIcon.trailingAnchor.constraint(equalTo: originOneLabel.leadingAnchor).isActive = true
        originOneIcon.bottomAnchor.constraint(equalTo: originOneView.bottomAnchor).isActive = true
        originOneLabel.leadingAnchor.constraint(equalTo: originOneIcon.trailingAnchor).isActive = true
        originOneLabel.topAnchor.constraint(equalTo: originOneView.topAnchor).isActive = true
        originOneLabel.trailingAnchor.constraint(equalTo: originOneView.trailingAnchor, constant: trailSpacing).isActive = true
        originOneLabel.bottomAnchor.constraint(equalTo: originOneView.bottomAnchor).isActive = true
        
        originTwoIcon.heightAnchor.constraint(equalToConstant: iconHeight).isActive = true
        originTwoIcon.widthAnchor.constraint(equalToConstant: iconWidth).isActive = true
        originTwoIcon.leadingAnchor.constraint(equalTo: originTwoView.leadingAnchor, constant: leadSpacing).isActive = true
        originTwoIcon.topAnchor.constraint(equalTo: originTwoView.topAnchor).isActive = true
        originTwoIcon.trailingAnchor.constraint(equalTo: originTwoLabel.leadingAnchor).isActive = true
        originTwoIcon.bottomAnchor.constraint(equalTo: originTwoView.bottomAnchor).isActive = true
        originTwoLabel.leadingAnchor.constraint(equalTo: originTwoIcon.trailingAnchor).isActive = true
        originTwoLabel.topAnchor.constraint(equalTo: originTwoView.topAnchor).isActive = true
        originTwoLabel.trailingAnchor.constraint(equalTo: originTwoView.trailingAnchor, constant: trailSpacing).isActive = true
        originTwoLabel.bottomAnchor.constraint(equalTo: originTwoView.bottomAnchor).isActive = true
        
        
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
        healthIcon.leadingAnchor.constraint(equalTo: classOriginStackView.leadingAnchor).isActive = true
        healthIcon.topAnchor.constraint(equalTo: classOriginStackView.bottomAnchor, constant: statSpacing).isActive = true
        healthIcon.heightAnchor.constraint(equalToConstant: statIconSize).isActive = true
        healthIcon.widthAnchor.constraint(equalTo: healthIcon.heightAnchor).isActive = true

        champHealth.leadingAnchor.constraint(equalTo: healthIcon.trailingAnchor, constant: statSpacing).isActive = true
        champHealth.topAnchor.constraint(equalTo: healthIcon.topAnchor).isActive = true
        champHealth.bottomAnchor.constraint(equalTo: healthIcon.bottomAnchor).isActive = true
        champHealth.widthAnchor.constraint(equalToConstant: statLabelWidth).isActive = true


        armorIcon.leadingAnchor.constraint(equalTo: champHealth.trailingAnchor, constant: statSpacing).isActive = true
        armorIcon.topAnchor.constraint(equalTo: healthIcon.topAnchor).isActive = true
        armorIcon.heightAnchor.constraint(equalToConstant: statIconSize).isActive = true
        armorIcon.widthAnchor.constraint(equalTo: armorIcon.heightAnchor).isActive = true

        champArmor.leadingAnchor.constraint(equalTo: armorIcon.trailingAnchor, constant: statSpacing).isActive = true
        champArmor.topAnchor.constraint(equalTo: armorIcon.topAnchor).isActive = true
        champArmor.bottomAnchor.constraint(equalTo: armorIcon.bottomAnchor).isActive = true
        champArmor.widthAnchor.constraint(equalToConstant: statLabelWidth).isActive = true


        magicResistIcon.leadingAnchor.constraint(equalTo: champArmor.trailingAnchor, constant: statSpacing).isActive = true
        magicResistIcon.topAnchor.constraint(equalTo: healthIcon.topAnchor).isActive = true
        magicResistIcon.heightAnchor.constraint(equalToConstant: statIconSize).isActive = true
        magicResistIcon.widthAnchor.constraint(equalTo: magicResistIcon.heightAnchor).isActive = true

        champMagicResist.leadingAnchor.constraint(equalTo: magicResistIcon.trailingAnchor, constant: statSpacing).isActive = true
        champMagicResist.topAnchor.constraint(equalTo: magicResistIcon.topAnchor).isActive = true
        champMagicResist.bottomAnchor.constraint(equalTo: magicResistIcon.bottomAnchor).isActive = true
        champMagicResist.widthAnchor.constraint(equalToConstant: 25).isActive = true

        
        attackDamageIcon.topAnchor.constraint(equalTo: healthIcon.bottomAnchor, constant: statSpacing).isActive = true
        attackDamageIcon.leadingAnchor.constraint(equalTo: classOriginStackView.leadingAnchor).isActive = true
        attackDamageIcon.heightAnchor.constraint(equalToConstant: statIconSize).isActive = true
        attackDamageIcon.widthAnchor.constraint(equalTo: attackDamageIcon.heightAnchor).isActive = true

        champAttackDamage.leadingAnchor.constraint(equalTo: attackDamageIcon.trailingAnchor, constant: statSpacing).isActive = true
        champAttackDamage.topAnchor.constraint(equalTo: attackDamageIcon.topAnchor).isActive = true
        champAttackDamage.bottomAnchor.constraint(equalTo: attackDamageIcon.bottomAnchor).isActive = true
        champAttackDamage.widthAnchor.constraint(equalToConstant: statLabelWidth).isActive = true


        attackSpeedIcon.bottomAnchor.constraint(equalTo: attackDamageIcon.bottomAnchor).isActive = true
        attackSpeedIcon.leadingAnchor.constraint(equalTo: armorIcon.leadingAnchor).isActive = true
        attackSpeedIcon.heightAnchor.constraint(equalToConstant: statIconSize).isActive = true
        attackSpeedIcon.widthAnchor.constraint(equalTo: attackSpeedIcon.heightAnchor).isActive = true

        champAttackSpeed.leadingAnchor.constraint(equalTo: attackSpeedIcon.trailingAnchor, constant: statSpacing).isActive = true
        champAttackSpeed.topAnchor.constraint(equalTo: attackSpeedIcon.topAnchor).isActive = true
        champAttackSpeed.bottomAnchor.constraint(equalTo: attackSpeedIcon.bottomAnchor).isActive = true
        champAttackSpeed.widthAnchor.constraint(equalToConstant: statLabelWidth).isActive = true


        rangeIcon.bottomAnchor.constraint(equalTo: attackSpeedIcon.bottomAnchor).isActive = true
        rangeIcon.leadingAnchor.constraint(equalTo: magicResistIcon.leadingAnchor).isActive = true
        rangeIcon.heightAnchor.constraint(equalToConstant: statIconSize).isActive = true
        rangeIcon.widthAnchor.constraint(equalTo: rangeIcon.heightAnchor).isActive = true

        champRange.leadingAnchor.constraint(equalTo: rangeIcon.trailingAnchor, constant: statSpacing).isActive = true
        champRange.topAnchor.constraint(equalTo: rangeIcon.topAnchor).isActive = true
        champRange.bottomAnchor.constraint(equalTo: rangeIcon.bottomAnchor).isActive = true
        champRange.widthAnchor.constraint(equalToConstant: 25).isActive = true


        //MARK: Divider Line
        dividerLine.widthAnchor.constraint(equalToConstant: 1).isActive = true
        dividerLine.heightAnchor.constraint(equalToConstant: 34).isActive = true
        dividerLine.leadingAnchor.constraint(equalTo: champMagicResist.trailingAnchor, constant: 10).isActive = true
        dividerLine.topAnchor.constraint(equalTo: champMagicResist.topAnchor).isActive = true
        
        
        //MARK: Best Items
        let itemWidthHeight: CGFloat = 25
        let stackviewSpacer: CGFloat = 10
        addSubview(bestItemsStackView)
//        addSubview(bestItemsLabel)
//
//        bestItemsLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        bestItemsLabel.leadingAnchor.constraint(equalTo: dividerLine.trailingAnchor).isActive = true
//        bestItemsLabel.bottomAnchor.constraint(equalTo: bestItemsStackView.topAnchor).isActive = true

//        bestItemsStackView.centerXAnchor.constraint(equalTo: bestItemsLabel.centerXAnchor).isActive = true
        bestItemsStackView.heightAnchor.constraint(equalToConstant: itemWidthHeight).isActive = true
        bestItemsStackView.leadingAnchor.constraint(equalTo: dividerLine.trailingAnchor, constant: stackviewSpacer).isActive = true
        bestItemsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -stackviewSpacer).isActive = true
        bestItemsStackView.centerYAnchor.constraint(equalTo: dividerLine.centerYAnchor).isActive = true

        bestItemOne.widthAnchor.constraint(equalToConstant: itemWidthHeight).isActive = true
        bestItemTwo.widthAnchor.constraint(equalToConstant: itemWidthHeight).isActive = true
        bestItemThree.widthAnchor.constraint(equalToConstant: itemWidthHeight).isActive = true
        
        //MARK: Champ Ability
        addSubview(champAbilityIcon)
        addSubview(champAbilityName)
        addSubview(manaIcon)
        addSubview(champAbilityMana)
//        addSubview(spellpowerIcon)
//        addSubview(champAbilitySpellpower)
        addSubview(champAbilityDescription)
        
        champAbilityIcon.leadingAnchor.constraint(equalTo: champImage.leadingAnchor).isActive = true
        champAbilityIcon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        champAbilityIcon.widthAnchor.constraint(equalTo: champAbilityIcon.heightAnchor).isActive = true
        champAbilityIcon.topAnchor.constraint(equalTo: costView.bottomAnchor, constant: 8).isActive = true
        
        champAbilityName.leadingAnchor.constraint(equalTo: champAbilityIcon.trailingAnchor, constant: 6).isActive = true
        champAbilityName.topAnchor.constraint(equalTo: champAbilityIcon.topAnchor).isActive = true
        
        manaIcon.leadingAnchor.constraint(equalTo: champAbilityName.trailingAnchor, constant: 8).isActive = true
        manaIcon.centerYAnchor.constraint(equalTo: champAbilityName.centerYAnchor).isActive = true
        manaIcon.heightAnchor.constraint(equalToConstant: 10).isActive = true
        manaIcon.widthAnchor.constraint(equalTo: manaIcon.heightAnchor).isActive = true

        champAbilityMana.leadingAnchor.constraint(equalTo: manaIcon.trailingAnchor, constant: 2).isActive = true
        champAbilityMana.centerYAnchor.constraint(equalTo: manaIcon.centerYAnchor).isActive = true

//        spellpowerIcon.leadingAnchor.constraint(equalTo: champAbilityMana.trailingAnchor, constant: 8).isActive = true
//        spellpowerIcon.centerYAnchor.constraint(equalTo: champAbilityName.centerYAnchor).isActive = true
//        spellpowerIcon.heightAnchor.constraint(equalToConstant: 10).isActive = true
//        spellpowerIcon.widthAnchor.constraint(equalTo: spellpowerIcon.heightAnchor).isActive = true

//        champAbilitySpellpower.leadingAnchor.constraint(equalTo: spellpowerIcon.trailingAnchor, constant: 4).isActive = true
//        champAbilitySpellpower.centerYAnchor.constraint(equalTo: spellpowerIcon.centerYAnchor).isActive = true

        champAbilityDescription.topAnchor.constraint(equalTo: champAbilityName.bottomAnchor, constant: 2).isActive = true
        champAbilityDescription.leadingAnchor.constraint(equalTo: champAbilityName.leadingAnchor).isActive = true
        champAbilityDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
    }
    
    // Required
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
