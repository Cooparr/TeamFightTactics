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

    var champion: ChampionObject? {
        didSet {
            guard
                let imgKey = champion?.key,
                let name = champion?.name,
                let cost = champion?.cost,
                let health = champion?.stats.defense.health,
                let armor = champion?.stats.defense.armor,
                let magicResist = champion?.stats.defense.magicResist,
                let attackDmg = champion?.stats.offense.damage,
                let attackSpd = champion?.stats.offense.attackSpeed,
                let range = champion?.stats.offense.range,
                let abilityDescription = champion?.ability.abilityDescription,
                
                
//                //Spell power is iffy becasue its of type: AbilityStat, Best Items is an array of differing counts also iffy
//                let spellPower = champion?.ability.stats,
//                let bestItems = champion?.items,

                let classes = champion?.championsClass,
                let origins = champion?.origin
                else { return }
            
            
            let manaStart = champion?.ability.manaStart ?? 0
            let manaCost = champion?.ability.manaCost ?? 0
            
            
            champName.text = name
            champCost.text = String(cost)
            champImage.sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.13.1/img/champion/\(imgKey).png"), placeholderImage: placeholderImage)

            champHealth.text = String(health)
            champArmor.text = String(armor)
            champMagicResist.text = String(magicResist)
            champAttackDamage.text = String(attackDmg)
            champAttackSpeed.text = String(attackSpd)
            champRange.text = String(range)

            champAbilityMana.text = "\(manaStart)/\(manaCost)"
            champAbilityDescription.text = abilityDescription
            champAbilityIcon.sd_setImage(with: URL(string: "https://solomid-resources.s3.amazonaws.com/blitz/tft/champion_abilities/\(imgKey).png"), placeholderImage: placeholderImage)


            //Need to sort out class & origin two label/views
            classOneLabel.text = classes[0]
            originOneLabel.text = origins[0]
            setCostColor(cost)
        }
    }
    
    //MARK:- Init & Functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
        setupCellContent()
    }
    
    // Set Cost Color
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
    
    
    //MARK:- Champ Name & Image
    var champImage: UIImageView = {
        let cI = UIImageView()
        cI.translatesAutoresizingMaskIntoConstraints = false
        cI.contentMode = .scaleAspectFit
        cI.layer.borderWidth = 2.0
        cI.layer.cornerRadius = 2.0
        return cI
    }()
    
    lazy var costView: UIView = {
        let cV = UIView()
        cV.translatesAutoresizingMaskIntoConstraints = false
        cV.layer.cornerRadius = 2.0
        return cV
    }()
    
    let champCost: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.boldSystemFont(ofSize: 12)
        return lbl
    }()
    
    let champCostIcon: UIImageView = {
        let cI = UIImageView()
        cI.translatesAutoresizingMaskIntoConstraints = false
        cI.image = UIImage(named: "Gold")?.withRenderingMode(.alwaysTemplate)
        cI.tintColor = CustomColor.platinum
        cI.contentMode = .scaleAspectFit
        return cI
    }()
    
    let champName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = CustomColor.platinum
        return lbl
    }()
    
    //MARK:- Class & Origin
    let classOneIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(named: "Shapeshifter")?.withRenderingMode(.alwaysTemplate)
        imgView.contentMode = .scaleAspectFit
        imgView.tintColor = CustomColor.platinum
        return imgView
    }()
    
    let classOneLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.systemFont(ofSize: 10)
        return lbl
    }()
    
    let classTwoIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
//        imgView.image = UIImage(named: "Shapeshifter")?.withRenderingMode(.alwaysTemplate)
        imgView.contentMode = .scaleAspectFit
        imgView.tintColor = CustomColor.platinum
        return imgView
    }()
    
    let classTwoLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.systemFont(ofSize: 10)
        return lbl
    }()
    
    let originOneIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(named: "Demon")?.withRenderingMode(.alwaysTemplate)
        imgView.contentMode = .scaleAspectFit
        imgView.tintColor = CustomColor.platinum
        return imgView
    }()
    
    let originOneLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.systemFont(ofSize: 10)
        return lbl
    }()
    
    let originTwoIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
//        imgView.image = UIImage(named: "Imperial")?.withRenderingMode(.alwaysTemplate)
        imgView.contentMode = .scaleAspectFit
        imgView.tintColor = CustomColor.platinum
        return imgView
    }()
    
    let originTwoLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.systemFont(ofSize: 10)
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
        return view
    }()
    
    lazy var classOriginStackView: UIStackView = {
        let sV = UIStackView(arrangedSubviews: [classOneView, classTwoView, originOneView, originTwoView])
        sV.translatesAutoresizingMaskIntoConstraints = false
        sV.axis = .horizontal
        sV.distribution = .fillProportionally
        sV.alignment = .center
        sV.spacing =  4
        return sV
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
        let hI = UIImageView()
        hI.translatesAutoresizingMaskIntoConstraints = false
        hI.image = UIImage(named: "HealthIcon")?.withRenderingMode(.alwaysTemplate)
        hI.tintColor = CustomColor.healthColor
        hI.contentMode = .scaleAspectFit
        return hI
    }()
    
    let armorIcon: UIImageView = {
        let aI = UIImageView()
        aI.translatesAutoresizingMaskIntoConstraints = false
        aI.image = UIImage(named: "ArmorIcon")?.withRenderingMode(.alwaysTemplate)
        aI.tintColor = CustomColor.armorColor
        aI.contentMode = .scaleAspectFit
        return aI
    }()
    
    let magicResistIcon: UIImageView = {
        let mrI = UIImageView()
        mrI.translatesAutoresizingMaskIntoConstraints = false
        mrI.image = UIImage(named: "MagicResistIcon")?.withRenderingMode(.alwaysTemplate)
        mrI.tintColor = CustomColor.magicResistColor
        mrI.contentMode = .scaleAspectFit
        return mrI
    }()
    
    let attackDamageIcon: UIImageView = {
        let adI = UIImageView()
        adI.translatesAutoresizingMaskIntoConstraints = false
        adI.image = UIImage(named: "AttDamageIcon")?.withRenderingMode(.alwaysTemplate)
        adI.tintColor = CustomColor.attDamageColor
        adI.contentMode = .scaleAspectFit
        return adI
    }()
    
    let attackSpeedIcon: UIImageView = {
        let asI = UIImageView()
        asI.translatesAutoresizingMaskIntoConstraints = false
        asI.image = UIImage(named: "AttSpeedIcon")?.withRenderingMode(.alwaysTemplate)
        asI.tintColor = CustomColor.attSpeedColor
        asI.contentMode = .scaleAspectFit
        return asI
    }()
    
    let rangeIcon: UIImageView = {
        let rI = UIImageView()
        rI.translatesAutoresizingMaskIntoConstraints = false
        rI.image = UIImage(named: "RangeIcon")?.withRenderingMode(.alwaysTemplate)
        rI.tintColor = CustomColor.rangeColor
        rI.contentMode = .scaleAspectFit
        return rI
    }()
    
    
    //MARK:- Divider Line
    let dividerLine: UIView = {
        let dL = UIView()
        dL.translatesAutoresizingMaskIntoConstraints = false
        dL.backgroundColor = CustomColor.romanSilver
        return dL
    }()
    
    
    //MARK:- Best Items
    let bestItems: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Best Items"
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.systemFont(ofSize: 10)
        lbl.textAlignment = .center
        return lbl
    }()
    
    let bestItemOne: UIImageView = {
        let bI1 = UIImageView()
        bI1.translatesAutoresizingMaskIntoConstraints = false
        bI1.image = UIImage(named: "PhantomDancer")
        bI1.contentMode = .scaleAspectFit
        bI1.layer.borderColor = CustomColor.romanSilver.cgColor
        bI1.layer.borderWidth = 1.0
        bI1.layer.cornerRadius = 2.0
        return bI1
    }()
    
    let bestItemTwo: UIImageView = {
        let bI2 = UIImageView()
        bI2.translatesAutoresizingMaskIntoConstraints = false
        bI2.image = UIImage(named: "Morellonomicon")
        bI2.contentMode = .scaleAspectFit
        bI2.layer.borderColor = CustomColor.romanSilver.cgColor
        bI2.layer.borderWidth = 1.0
        bI2.layer.cornerRadius = 2.0
        return bI2
    }()
    
    let bestItemThree: UIImageView = {
        let bI3 = UIImageView()
        bI3.translatesAutoresizingMaskIntoConstraints = false
        bI3.image = UIImage(named: "DragonsClaw")
        bI3.contentMode = .scaleAspectFit
        bI3.layer.borderColor = CustomColor.romanSilver.cgColor
        bI3.layer.borderWidth = 1.0
        bI3.layer.cornerRadius = 2.0
        return bI3
    }()
    
    //MARK:- Champ Ability
    lazy var champAbilityIcon: UIImageView = {
        let cAI = UIImageView()
        cAI.translatesAutoresizingMaskIntoConstraints = false
        cAI.contentMode = .scaleAspectFit
        cAI.layer.borderColor = CustomColor.romanSilver.cgColor
        cAI.layer.borderWidth = 1.0
        cAI.layer.cornerRadius = 2.0
        return cAI
    }()
    
    let manaIcon: UIImageView = {
        let mI = UIImageView()
        mI.translatesAutoresizingMaskIntoConstraints = false
        mI.image = UIImage(named: "ManaIcon")?.withRenderingMode(.alwaysTemplate)
        mI.tintColor = CustomColor.manaColor
        mI.contentMode = .scaleAspectFit
        return mI
    }()
    
    let spellpowerIcon: UIImageView = {
        let spI = UIImageView()
        spI.translatesAutoresizingMaskIntoConstraints = false
        spI.image = UIImage(named: "SpellPowerIcon")?.withRenderingMode(.alwaysTemplate)
        spI.tintColor = CustomColor.spellPowerColor
        spI.contentMode = .scaleAspectFit
        return spI
    }()
    
    let champAbilityMana: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.systemFont(ofSize: 10)
        return lbl
    }()
    
    let champAbilitySpellpower: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "300"
        lbl.textColor = CustomColor.platinum
        lbl.font = UIFont.systemFont(ofSize: 10)
        return lbl
    }()
    
    let champAbilityDescription: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 10)
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
        // Champ Image & Cost
        addSubview(champImage)
        addSubview(champName)
        addSubview(costView)
        costView.addSubview(champCostIcon)
        costView.addSubview(champCost)

        champImage.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        champImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        champImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        champImage.widthAnchor.constraint(equalTo: champImage.heightAnchor).isActive = true
        
        champName.topAnchor.constraint(equalTo: champImage.topAnchor).isActive = true
        champName.leadingAnchor.constraint(equalTo: champImage.trailingAnchor, constant: 8).isActive = true
        
        costView.centerXAnchor.constraint(equalTo: champImage.centerXAnchor).isActive = true
        costView.centerYAnchor.constraint(equalTo: champImage.bottomAnchor, constant: -1).isActive = true
        costView.heightAnchor.constraint(equalToConstant: 13).isActive = true
        costView.widthAnchor.constraint(equalToConstant: 23).isActive = true
        
        champCostIcon.centerYAnchor.constraint(equalTo: costView.centerYAnchor).isActive = true
        champCostIcon.centerXAnchor.constraint(equalTo: costView.centerXAnchor, constant: -5).isActive = true
        champCostIcon.widthAnchor.constraint(equalToConstant: 10).isActive = true
        champCost.centerYAnchor.constraint(equalTo: costView.centerYAnchor).isActive = true
        champCost.centerXAnchor.constraint(equalTo: costView.centerXAnchor, constant: 5).isActive = true

        
        // Class & Origin
        addSubview(classOriginStackView)
        classOriginStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        classOriginStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        classOriginStackView.heightAnchor.constraint(equalToConstant: 19).isActive = true
//        classOriginStackView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
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
        
        
        // Champ Stats
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
        healthIcon.topAnchor.constraint(equalTo: classOriginStackView.bottomAnchor,constant: 6).isActive = true
        healthIcon.leadingAnchor.constraint(equalTo: champImage.trailingAnchor, constant: 8).isActive = true
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
        champMagicResist.widthAnchor.constraint(equalToConstant: statLabelWidth).isActive = true

        
        attackDamageIcon.topAnchor.constraint(equalTo: healthIcon.bottomAnchor, constant: statSpacing).isActive = true
        attackDamageIcon.leadingAnchor.constraint(equalTo: champName.leadingAnchor).isActive = true
        attackDamageIcon.heightAnchor.constraint(equalToConstant: statIconSize).isActive = true
        attackDamageIcon.widthAnchor.constraint(equalTo: attackDamageIcon.heightAnchor).isActive = true
        
        champAttackDamage.leadingAnchor.constraint(equalTo: attackDamageIcon.trailingAnchor, constant: statSpacing).isActive = true
        champAttackDamage.topAnchor.constraint(equalTo: attackDamageIcon.topAnchor).isActive = true
        champAttackDamage.bottomAnchor.constraint(equalTo: attackDamageIcon.bottomAnchor).isActive = true
        champAttackDamage.widthAnchor.constraint(equalToConstant: statLabelWidth).isActive = true
        
        
        attackSpeedIcon.topAnchor.constraint(equalTo: armorIcon.bottomAnchor, constant: statSpacing).isActive = true
        attackSpeedIcon.leadingAnchor.constraint(equalTo: armorIcon.leadingAnchor).isActive = true
        attackSpeedIcon.heightAnchor.constraint(equalToConstant: statIconSize).isActive = true
        attackSpeedIcon.widthAnchor.constraint(equalTo: attackSpeedIcon.heightAnchor).isActive = true

        champAttackSpeed.leadingAnchor.constraint(equalTo: attackSpeedIcon.trailingAnchor, constant: statSpacing).isActive = true
        champAttackSpeed.topAnchor.constraint(equalTo: attackSpeedIcon.topAnchor).isActive = true
        champAttackSpeed.bottomAnchor.constraint(equalTo: attackSpeedIcon.bottomAnchor).isActive = true
        champAttackSpeed.widthAnchor.constraint(equalToConstant: statLabelWidth).isActive = true
        
        
        rangeIcon.topAnchor.constraint(equalTo: magicResistIcon.bottomAnchor, constant: statSpacing).isActive = true
        rangeIcon.leadingAnchor.constraint(equalTo: magicResistIcon.leadingAnchor).isActive = true
        rangeIcon.heightAnchor.constraint(equalToConstant: statIconSize).isActive = true
        rangeIcon.widthAnchor.constraint(equalTo: rangeIcon.heightAnchor).isActive = true
        
        champRange.leadingAnchor.constraint(equalTo: rangeIcon.trailingAnchor, constant: statSpacing).isActive = true
        champRange.topAnchor.constraint(equalTo: rangeIcon.topAnchor).isActive = true
        champRange.bottomAnchor.constraint(equalTo: rangeIcon.bottomAnchor).isActive = true
        champRange.widthAnchor.constraint(equalToConstant: statLabelWidth).isActive = true
        
        
        // Divider Line
        dividerLine.widthAnchor.constraint(equalToConstant: 1).isActive = true
        dividerLine.heightAnchor.constraint(equalToConstant: 34).isActive = true
        dividerLine.leadingAnchor.constraint(equalTo: champMagicResist.trailingAnchor, constant: 4).isActive = true
        dividerLine.topAnchor.constraint(equalTo: champMagicResist.topAnchor).isActive = true
        
        
        // Best Items
        addSubview(bestItems)
        addSubview(bestItemOne)
        addSubview(bestItemTwo)
        addSubview(bestItemThree)

        bestItems.topAnchor.constraint(equalTo: champMagicResist.topAnchor).isActive = true
        bestItems.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bestItems.leadingAnchor.constraint(equalTo: dividerLine.trailingAnchor).isActive = true
        
        bestItemOne.bottomAnchor.constraint(equalTo: rangeIcon.bottomAnchor).isActive = true
        bestItemOne.trailingAnchor.constraint(equalTo: bestItemTwo.leadingAnchor,constant: -4).isActive = true
        bestItemOne.widthAnchor.constraint(equalToConstant: 20).isActive = true
        bestItemOne.heightAnchor.constraint(equalTo: bestItemOne.widthAnchor).isActive = true
        
        bestItemTwo.bottomAnchor.constraint(equalTo: rangeIcon.bottomAnchor).isActive = true
        bestItemTwo.centerXAnchor.constraint(equalTo: bestItems.centerXAnchor).isActive = true
        bestItemTwo.widthAnchor.constraint(equalToConstant: 20).isActive = true
        bestItemTwo.heightAnchor.constraint(equalTo: bestItemTwo.widthAnchor).isActive = true
        
        bestItemThree.bottomAnchor.constraint(equalTo: rangeIcon.bottomAnchor).isActive = true
        bestItemThree.leadingAnchor.constraint(equalTo: bestItemTwo.trailingAnchor,constant: 4).isActive = true
        bestItemThree.widthAnchor.constraint(equalToConstant: 20).isActive = true
        bestItemThree.heightAnchor.constraint(equalTo: bestItemThree.widthAnchor).isActive = true
        
        
        // Champ Ability
        addSubview(champAbilityIcon)
        addSubview(manaIcon)
        addSubview(champAbilityMana)
        addSubview(spellpowerIcon)
        addSubview(champAbilitySpellpower)
        addSubview(champAbilityDescription)
        
        champAbilityIcon.leadingAnchor.constraint(equalTo: champImage.leadingAnchor).isActive = true
        champAbilityIcon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        champAbilityIcon.widthAnchor.constraint(equalTo: champAbilityIcon.heightAnchor).isActive = true
        champAbilityIcon.topAnchor.constraint(equalTo: costView.bottomAnchor, constant: 8).isActive = true
        
        manaIcon.bottomAnchor.constraint(equalTo: champAbilityIcon.centerYAnchor, constant: -2).isActive = true
        manaIcon.leadingAnchor.constraint(equalTo: champAbilityIcon.trailingAnchor, constant: 2).isActive = true
        manaIcon.heightAnchor.constraint(equalToConstant: 12).isActive = true
        manaIcon.widthAnchor.constraint(equalTo: manaIcon.heightAnchor).isActive = true
        
        champAbilityMana.leadingAnchor.constraint(equalTo: manaIcon.trailingAnchor, constant: 2).isActive = true
        champAbilityMana.centerYAnchor.constraint(equalTo: manaIcon.centerYAnchor).isActive = true
        champAbilityMana.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        spellpowerIcon.topAnchor.constraint(equalTo: champAbilityIcon.centerYAnchor, constant: 2).isActive = true
        spellpowerIcon.leadingAnchor.constraint(equalTo: champAbilityIcon.trailingAnchor, constant: 2).isActive = true
        spellpowerIcon.heightAnchor.constraint(equalToConstant: 12).isActive = true
        spellpowerIcon.widthAnchor.constraint(equalTo: spellpowerIcon.heightAnchor).isActive = true
        
        champAbilitySpellpower.leadingAnchor.constraint(equalTo: spellpowerIcon.trailingAnchor, constant: 2).isActive = true
        champAbilitySpellpower.centerYAnchor.constraint(equalTo: spellpowerIcon.centerYAnchor).isActive = true
        champAbilitySpellpower.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
        champAbilityDescription.topAnchor.constraint(equalTo: champAbilityIcon.topAnchor, constant: -5).isActive = true
        champAbilityDescription.leadingAnchor.constraint(equalTo: champAbilityMana.trailingAnchor, constant: 3).isActive = true
        champAbilityDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
    }
    
    // Required
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
