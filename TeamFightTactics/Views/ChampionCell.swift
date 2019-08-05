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
    
    // Properties
    let championName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Aurelion Sol"
        lbl.textColor = CustomColor.platinum
        return lbl
    }()
    
    lazy var championImage: UIImageView = {
        let cI = UIImageView()
        cI.translatesAutoresizingMaskIntoConstraints = false
        cI.sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.13.1/img/champion/AurelionSol.png"), placeholderImage: placeholderImage)
        cI.contentMode = .scaleAspectFit
        return cI
    }()
    
    let healthIcon: UIImageView = {
        let hI = UIImageView()
        hI.translatesAutoresizingMaskIntoConstraints = false
        hI.image = UIImage(named: "HealthIcon")?.withRenderingMode(.alwaysTemplate)
        hI.tintColor = CustomColor.healthColor
        hI.contentMode = .scaleAspectFit
        return hI
    }()
    
    let championHealth: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let armorIcon: UIImageView = {
        let aI = UIImageView()
        aI.translatesAutoresizingMaskIntoConstraints = false
        aI.image = UIImage(named: "ArmorIcon")?.withRenderingMode(.alwaysTemplate)
        aI.tintColor = CustomColor.armorColor
        aI.contentMode = .scaleAspectFit
        return aI
    }()
    
    let championArmor: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let magicResistIcon: UIImageView = {
        let mrI = UIImageView()
        mrI.translatesAutoresizingMaskIntoConstraints = false
        mrI.image = UIImage(named: "MagicResistIcon")?.withRenderingMode(.alwaysTemplate)
        mrI.tintColor = CustomColor.magicResistColor
        mrI.contentMode = .scaleAspectFit
        return mrI
    }()
    
    let championMagicResist: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let attackDamageIcon: UIImageView = {
        let adI = UIImageView()
        adI.translatesAutoresizingMaskIntoConstraints = false
        adI.image = UIImage(named: "AttDamageIcon")?.withRenderingMode(.alwaysTemplate)
        adI.tintColor = CustomColor.attDamageColor
        adI.contentMode = .scaleAspectFit
        return adI
    }()
    
    let championAttackDamage: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let attackSpeedIcon: UIImageView = {
        let asI = UIImageView()
        asI.translatesAutoresizingMaskIntoConstraints = false
        asI.image = UIImage(named: "AttSpeedIcon")?.withRenderingMode(.alwaysTemplate)
        asI.tintColor = CustomColor.attSpeedColor
        asI.contentMode = .scaleAspectFit
        return asI
    }()
    
    let championAttackSpeed: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let manaIcon: UIImageView = {
        let mI = UIImageView()
        mI.translatesAutoresizingMaskIntoConstraints = false
        mI.image = UIImage(named: "ManaIcon")?.withRenderingMode(.alwaysTemplate)
        mI.tintColor = CustomColor.manaColor
        mI.contentMode = .scaleAspectFit
        return mI
    }()
    
    let championMana: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let rangeIcon: UIImageView = {
        let rI = UIImageView()
        rI.translatesAutoresizingMaskIntoConstraints = false
        rI.image = UIImage(named: "RangeIcon")?.withRenderingMode(.alwaysTemplate)
        rI.tintColor = CustomColor.rangeColor
        rI.contentMode = .scaleAspectFit
        return rI
    }()
    
    let championRange: UILabel = {
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
        contentView.addSubview(championImage)
        championImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        championImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        championImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        championImage.widthAnchor.constraint(equalTo: championImage.heightAnchor).isActive = true
        
        contentView.addSubview(championName)
        championName.topAnchor.constraint(equalTo: championImage.topAnchor).isActive = true
        championName.leadingAnchor.constraint(equalTo: championImage.trailingAnchor, constant: 8).isActive = true
        
        
        // Champ Stats
        let statIconSize: CGFloat = 15
        contentView.addSubview(healthIcon)
        healthIcon.topAnchor.constraint(equalTo: championName.bottomAnchor).isActive = true
        healthIcon.leadingAnchor.constraint(equalTo: championName.leadingAnchor).isActive = true
        healthIcon.heightAnchor.constraint(equalToConstant: statIconSize).isActive = true
        healthIcon.widthAnchor.constraint(equalTo: healthIcon.heightAnchor).isActive = true
        
        contentView.addSubview(armorIcon)
        armorIcon.topAnchor.constraint(equalTo: championName.bottomAnchor).isActive = true
        armorIcon.leadingAnchor.constraint(equalTo: healthIcon.trailingAnchor).isActive = true
        armorIcon.heightAnchor.constraint(equalToConstant: statIconSize).isActive = true
        armorIcon.widthAnchor.constraint(equalTo: armorIcon.heightAnchor).isActive = true
        
        contentView.addSubview(magicResistIcon)
        magicResistIcon.topAnchor.constraint(equalTo: championName.bottomAnchor).isActive = true
        magicResistIcon.leadingAnchor.constraint(equalTo: armorIcon.trailingAnchor).isActive = true
        magicResistIcon.heightAnchor.constraint(equalToConstant: statIconSize).isActive = true
        magicResistIcon.widthAnchor.constraint(equalTo: magicResistIcon.heightAnchor).isActive = true
        
        contentView.addSubview(attackDamageIcon)
        attackDamageIcon.topAnchor.constraint(equalTo: championName.bottomAnchor).isActive = true
        attackDamageIcon.leadingAnchor.constraint(equalTo: magicResistIcon.trailingAnchor).isActive = true
        attackDamageIcon.heightAnchor.constraint(equalToConstant: statIconSize).isActive = true
        attackDamageIcon.widthAnchor.constraint(equalTo: attackDamageIcon.heightAnchor).isActive = true
        
        contentView.addSubview(attackSpeedIcon)
        attackSpeedIcon.topAnchor.constraint(equalTo: championName.bottomAnchor).isActive = true
        attackSpeedIcon.leadingAnchor.constraint(equalTo: attackDamageIcon.trailingAnchor).isActive = true
        attackSpeedIcon.heightAnchor.constraint(equalToConstant: statIconSize).isActive = true
        attackSpeedIcon.widthAnchor.constraint(equalTo: attackSpeedIcon.heightAnchor).isActive = true
        
        contentView.addSubview(manaIcon)
        manaIcon.topAnchor.constraint(equalTo: championName.bottomAnchor).isActive = true
        manaIcon.leadingAnchor.constraint(equalTo: attackSpeedIcon.trailingAnchor).isActive = true
        manaIcon.heightAnchor.constraint(equalToConstant: statIconSize).isActive = true
        manaIcon.widthAnchor.constraint(equalTo: manaIcon.heightAnchor).isActive = true
        
        contentView.addSubview(rangeIcon)
        rangeIcon.topAnchor.constraint(equalTo: championName.bottomAnchor).isActive = true
        rangeIcon.leadingAnchor.constraint(equalTo: manaIcon.trailingAnchor).isActive = true
        rangeIcon.heightAnchor.constraint(equalToConstant: statIconSize).isActive = true
        rangeIcon.widthAnchor.constraint(equalTo: rangeIcon.heightAnchor).isActive = true
    }
    
    // Required
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
