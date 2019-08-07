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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
        setupCellContent()
    }
    
    //MARK: Functions
    fileprivate func borderColor() -> UIColor {
        if champName.text == "Swain" { // Temporary
            return CustomColor.fiveCost
        } else {
            return CustomColor.threeCost
        }
    }
    
    //MARK: Champ Name & Image
    lazy var champImage: UIImageView = {
        let cI = UIImageView()
        cI.translatesAutoresizingMaskIntoConstraints = false
        cI.sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.13.1/img/champion/Swain.png"), placeholderImage: placeholderImage)
        cI.contentMode = .scaleAspectFit
        cI.layer.borderColor = borderColor().cgColor
        cI.layer.borderWidth = 2.0
        cI.layer.cornerRadius = 2.0
        return cI
    }()
    
    lazy var costView: UIView = {
        let cV = UIView()
        cV.translatesAutoresizingMaskIntoConstraints = false
        cV.backgroundColor = borderColor()
        cV.layer.cornerRadius = 2.0
        return cV
    }()
    
    let champCost: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "5"
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
        lbl.text = "Swain"
        lbl.textColor = CustomColor.platinum
        return lbl
    }()
    
    //MARK: Class & Origin
    let classOne: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let classTwo: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let originOne: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let originTwo: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let classOneIcon: UIImageView = {
        let cOI = UIImageView()
        cOI.translatesAutoresizingMaskIntoConstraints = false
        return cOI
    }()
    
    let classTwoIcon: UIImageView = {
        let cTI = UIImageView()
        cTI.translatesAutoresizingMaskIntoConstraints = false
        return cTI
    }()
    
    let originOneIcon: UIImageView = {
        let oOI = UIImageView()
        oOI.translatesAutoresizingMaskIntoConstraints = false
        return oOI
    }()
    
    let originTwoIcon: UIImageView = {
        let oTI = UIImageView()
        oTI.translatesAutoresizingMaskIntoConstraints = false
        return oTI
    }()
    
    //MARK: Champ Stats
    let champHealth: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let champArmor: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let champMagicResist: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let champAttackDamage: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let champAttackSpeed: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let champRange: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
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
    
    //MARK: Best Items
    let bestItems: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let bestItemOne: UIImageView = {
        let bI1 = UIImageView()
        bI1.translatesAutoresizingMaskIntoConstraints = false
        return bI1
    }()
    
    let bestItemTwo: UIImageView = {
        let bI2 = UIImageView()
        bI2.translatesAutoresizingMaskIntoConstraints = false
        return bI2
    }()
    
    let bestItemThree: UIImageView = {
        let bI3 = UIImageView()
        bI3.translatesAutoresizingMaskIntoConstraints = false
        return bI3
    }()
    
    //MARK: Champ Ability
    let champAbilityIcon: UIImageView = {
        let cAI = UIImageView()
        cAI.translatesAutoresizingMaskIntoConstraints = false
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
    
    let abiltyMana: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let abilitySpellpower: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let abilityDescription: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    // Setup Cell
    fileprivate func setupCell() {
        layer.cornerRadius = 6.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.clear.cgColor
        layer.masksToBounds = true
    }
    
    // Setup Cell Content
    fileprivate func setupCellContent() {
        contentView.addSubview(champImage)
        champImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        champImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        champImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        champImage.widthAnchor.constraint(equalTo: champImage.heightAnchor).isActive = true
        
        contentView.addSubview(costView)
        costView.centerXAnchor.constraint(equalTo: champImage.centerXAnchor).isActive = true
        costView.centerYAnchor.constraint(equalTo: champImage.bottomAnchor, constant: -1).isActive = true
        costView.heightAnchor.constraint(equalToConstant: 13).isActive = true
        costView.widthAnchor.constraint(equalToConstant: 23).isActive = true
        
        costView.addSubview(champCostIcon)
        champCostIcon.centerYAnchor.constraint(equalTo: costView.centerYAnchor).isActive = true
        champCostIcon.centerXAnchor.constraint(equalTo: costView.centerXAnchor, constant: -5).isActive = true
        champCostIcon.widthAnchor.constraint(equalToConstant: 10).isActive = true
        
        costView.addSubview(champCost)
        champCost.centerYAnchor.constraint(equalTo: costView.centerYAnchor).isActive = true
        champCost.centerXAnchor.constraint(equalTo: costView.centerXAnchor, constant: 5).isActive = true
        
        contentView.addSubview(champName)
        champName.topAnchor.constraint(equalTo: champImage.topAnchor).isActive = true
        champName.leadingAnchor.constraint(equalTo: champImage.trailingAnchor, constant: 8).isActive = true
        
        
        // Champ Stats
        let statIconSize: CGFloat = 15
        contentView.addSubview(healthIcon)
        healthIcon.topAnchor.constraint(equalTo: champName.bottomAnchor).isActive = true
        healthIcon.leadingAnchor.constraint(equalTo: champName.leadingAnchor).isActive = true
        healthIcon.heightAnchor.constraint(equalToConstant: statIconSize).isActive = true
        healthIcon.widthAnchor.constraint(equalTo: healthIcon.heightAnchor).isActive = true
        
        contentView.addSubview(armorIcon)
        armorIcon.topAnchor.constraint(equalTo: champName.bottomAnchor).isActive = true
        armorIcon.leadingAnchor.constraint(equalTo: healthIcon.trailingAnchor).isActive = true
        armorIcon.heightAnchor.constraint(equalToConstant: statIconSize).isActive = true
        armorIcon.widthAnchor.constraint(equalTo: armorIcon.heightAnchor).isActive = true
        
        contentView.addSubview(magicResistIcon)
        magicResistIcon.topAnchor.constraint(equalTo: champName.bottomAnchor).isActive = true
        magicResistIcon.leadingAnchor.constraint(equalTo: armorIcon.trailingAnchor).isActive = true
        magicResistIcon.heightAnchor.constraint(equalToConstant: statIconSize).isActive = true
        magicResistIcon.widthAnchor.constraint(equalTo: magicResistIcon.heightAnchor).isActive = true
        
        contentView.addSubview(attackDamageIcon)
        attackDamageIcon.topAnchor.constraint(equalTo: champName.bottomAnchor).isActive = true
        attackDamageIcon.leadingAnchor.constraint(equalTo: magicResistIcon.trailingAnchor).isActive = true
        attackDamageIcon.heightAnchor.constraint(equalToConstant: statIconSize).isActive = true
        attackDamageIcon.widthAnchor.constraint(equalTo: attackDamageIcon.heightAnchor).isActive = true
        
        contentView.addSubview(attackSpeedIcon)
        attackSpeedIcon.topAnchor.constraint(equalTo: champName.bottomAnchor).isActive = true
        attackSpeedIcon.leadingAnchor.constraint(equalTo: attackDamageIcon.trailingAnchor).isActive = true
        attackSpeedIcon.heightAnchor.constraint(equalToConstant: statIconSize).isActive = true
        attackSpeedIcon.widthAnchor.constraint(equalTo: attackSpeedIcon.heightAnchor).isActive = true
        
        contentView.addSubview(manaIcon)
        manaIcon.topAnchor.constraint(equalTo: champName.bottomAnchor).isActive = true
        manaIcon.leadingAnchor.constraint(equalTo: attackSpeedIcon.trailingAnchor).isActive = true
        manaIcon.heightAnchor.constraint(equalToConstant: statIconSize).isActive = true
        manaIcon.widthAnchor.constraint(equalTo: manaIcon.heightAnchor).isActive = true
        
        contentView.addSubview(rangeIcon)
        rangeIcon.topAnchor.constraint(equalTo: champName.bottomAnchor).isActive = true
        rangeIcon.leadingAnchor.constraint(equalTo: manaIcon.trailingAnchor).isActive = true
        rangeIcon.heightAnchor.constraint(equalToConstant: statIconSize).isActive = true
        rangeIcon.widthAnchor.constraint(equalTo: rangeIcon.heightAnchor).isActive = true
        
        contentView.addSubview(spellpowerIcon)
        spellpowerIcon.topAnchor.constraint(equalTo: champName.bottomAnchor).isActive = true
        spellpowerIcon.leadingAnchor.constraint(equalTo: rangeIcon.trailingAnchor).isActive = true
        spellpowerIcon.heightAnchor.constraint(equalToConstant: statIconSize).isActive = true
        spellpowerIcon.widthAnchor.constraint(equalTo: spellpowerIcon.heightAnchor).isActive = true
    }
    
    // Required
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
