//
//  TeamCompCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 17/10/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit
import SDWebImage

class TeamCompCell: UITableViewCell {
    
    let placeholderImage = UIImage(named: "Neeko.png")
    
    var teamComp: TeamComposition? {
        didSet {
            guard
                let title = teamComp?.title,
                let tier = teamComp?.tier,
                let champions = teamComp?.endGame
                else { return }
            
            titleLabel.text = title
            
            
            
            champions.forEach { (champ) in
                if let champName = champ["name"] {
                    champImageOne.sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.13.1/img/champion/\(champName).png"), placeholderImage: placeholderImage)
                }
            }
            
            setTierLabelAndColor(tier)
        }
    }
    
    
    //MARK:- Override Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupCellContent()
    }
    
    //MARK: Set Tier Label And Color
    fileprivate func setTierLabelAndColor(_ tier: Int) {
        switch tier {
        case 0:
            teamCompTier.text = "S Tier"
            teamCompTier.backgroundColor = CustomColor.sTier
        case 1:
            teamCompTier.text = "A Tier"
            teamCompTier.backgroundColor = CustomColor.aTier
        case 2:
            teamCompTier.text = "B Tier"
            teamCompTier.backgroundColor = CustomColor.bTier
        case 3:
            teamCompTier.text = "C Tier"
            teamCompTier.backgroundColor = CustomColor.cTier
        case 4:
            teamCompTier.text = "D Tier"
            teamCompTier.backgroundColor = CustomColor.dTier
        default:
            teamCompTier.text = "E Tier"
            teamCompTier.backgroundColor = CustomColor.eTier
        }
    }
    
    
    //MARK:- Team Comp Title & Tier
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return lbl
    }()
    
    let teamCompTier: UILabel = {
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
    
    //MARK:- Champ Images
    let champImageOne: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.layer.borderWidth = 1.0
        imgView.layer.cornerRadius = 2.0
        
        imgView.layer.borderColor = UIColor.red.cgColor
        
        return imgView
    }()
    
    
    //MARK:- Setup Cell
    fileprivate func setupCell() {
        accessoryType = .disclosureIndicator
        backgroundColor = CustomColor.richBlack
        separatorInset.left = 0
        
    }
    
    
    //MARK:- Setup Cell Content
    fileprivate func setupCellContent() {
        
        
        //MARK: Title & Tier
        addSubview(titleLabel)
        addSubview(teamCompTier)
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        
        teamCompTier.topAnchor.constraint(equalTo: topAnchor).isActive = true
        teamCompTier.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        teamCompTier.widthAnchor.constraint(equalToConstant: 60).isActive = true
        teamCompTier.heightAnchor.constraint(equalToConstant: 17).isActive = true
        
        
        //MARK: Champ Images
        addSubview(champImageOne)
        
        let champImgSize: CGFloat = 30
        champImageOne.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        champImageOne.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        champImageOne.heightAnchor.constraint(equalToConstant: champImgSize).isActive = true
        champImageOne.widthAnchor.constraint(equalToConstant: champImgSize).isActive = true

    }
    
    
    // Required
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
