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
        
        setupView()
        
        championImage.sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.13.1/img/champion/Mordekaiser.png"), placeholderImage: placeholderImage)
    }
    
    // Properties
    let championName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Champion name"
        return lbl
    }()
    
    let championImage: UIImageView = {
        let cI = UIImageView()
        cI.translatesAutoresizingMaskIntoConstraints = false
        cI.contentMode = .scaleAspectFit
        cI.backgroundColor = .black
        return cI
    }()
    
    // Seup View
    fileprivate func setupView() {
        contentView.addSubview(championImage)
        championImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        championImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        championImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        championImage.widthAnchor.constraint(equalTo: championImage.heightAnchor).isActive = true
        
        contentView.addSubview(championName)
        championName.topAnchor.constraint(equalTo: championImage.topAnchor).isActive = true
        championName.leadingAnchor.constraint(equalTo: championImage.trailingAnchor, constant: 8).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
