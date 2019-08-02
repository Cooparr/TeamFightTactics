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
        hI.image = UIImage(named: "ChampionTabBar")
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
        aI.image = UIImage(named: "ChampionTabBar")
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
        mrI.image = UIImage(named: "ChampionTabBar")
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
        adI.image = UIImage(named: "ChampionTabBar")
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
        asI.image = UIImage(named: "ChampionTabBar")
        asI.contentMode = .scaleAspectFit
        return asI
    }()
    
    let championAttackSpeed: UILabel = {
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
        
        contentView.addSubview(healthIcon)
        healthIcon.topAnchor.constraint(equalTo: championName.bottomAnchor).isActive = true
        healthIcon.leadingAnchor.constraint(equalTo: championName.leadingAnchor).isActive = true
        healthIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        healthIcon.widthAnchor.constraint(equalTo: healthIcon.heightAnchor).isActive = true
    }
    
    // Required
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
