//
//  TCCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 17/10/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit
import SDWebImage

class TCCell: UITableViewCell {
    
    var teamComp: TeamComposition? {
        didSet {
            
//            if teamComp!.champObjs.isEmpty {
//                return
//            }
            
            guard
                let title: String = teamComp?.title,
                let tier: TierRating = teamComp?.tier,
                let allSynergies: [TeamCompositionSynergies] = teamComp?.synergies.sorted(by: { $0.rank.rawValue < $1.rank.rawValue }),
                let endTest = teamComp?.endGame,
                let champions = teamComp?.champObjs
                else { return }
            
            titleLabel.text = title
            setTierLabel(tier)
            setTeamCompSynergyBadges(allSynergies)
            setTeamCompChampImages(champions)

        }
    }
    
    
    //MARK:- Override Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupCellContent()
    }
    
    
    //MARK: Set Team Comp Champ Images
//    fileprivate func setTeamCompChampImages(_ champArray: [TeamCompositionEndGameChamps]) {
//        champImagesStackView.arrangedSubviews.forEach({ $0.isHidden = true })
//        for (index, champ) in champArray.reversed().enumerated() {
//            let name = champ.name.removeNameSpaces().isLuxOrQiyana()
//            if let champImage = champImagesStackView.arrangedSubviews[index] as? TCChampImage {
//                champImage.isHidden = false
//                champImage.sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/\(Constants.ddVer)/img/champion/\(name).png"))
////                champ.cost.setChampImageBorder(for: champImage)
//            }
//        }
//    }
    
    fileprivate func setTeamCompChampImages(_ champArray: [Champion]) {
        champImagesStackView.arrangedSubviews.forEach({ $0.isHidden = true })
        for (index, champ) in champArray.reversed().enumerated() {
            let name = champ.name.removeNameSpaces().isLuxOrQiyana()
            if let champImage = champImagesStackView.arrangedSubviews[index] as? TCChampImage {
                champImage.isHidden = false
                let placeholder = UIImage(named: "placeholder")
                let champImgUrl = URL(string: "https://ddragon.leagueoflegends.com/cdn/\(Constants.ddVer)/img/champion/\(name).png")
                champImage.sd_setImage(with: champImgUrl, placeholderImage: placeholder)
                champ.cost.setChampImageBorder(for: champImage)
            }
        }
    }
    
    
    //MARK: Set Team Comp Synergy Badges
    fileprivate func setTeamCompSynergyBadges(_ allSynergies: [TeamCompositionSynergies]) {
        synergiesStackView.arrangedSubviews.forEach({ $0.isHidden = true })

        for (index, synergy) in allSynergies.enumerated() {
            let badgeColor: UIColor
            switch synergy.rank {
            case .gold:
                badgeColor = CustomColor.goldSynergy
            case .silver:
                badgeColor = CustomColor.silverSynergy
            case .bronze:
                badgeColor = CustomColor.bronzeSynergy
            default:
                badgeColor = CustomColor.error
            }
            
            if let synergyBadge = synergiesStackView.arrangedSubviews[index] as? TCSynergyBadge {
                synergyBadge.synergyCountLabel.text = String(synergy.count)
                synergyBadge.synergyIcon.image = UIImage(named: "\(synergy.name)")
                synergyBadge.backgroundColor = badgeColor
                synergyBadge.isHidden = false
            }
        }
    }
    
    //MARK: Set Tier Label And Color
    fileprivate func setTierLabel(_ tier: TierRating) {
        tier.setTierTextAndColor(for: teamCompTier)
    }
    
    //MARK:- Team Comp Title & Tier
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
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
        lbl.layer.maskedCorners = [.layerMinXMaxYCorner]
        return lbl
    }()
    
    
    //MARK:- Champ Images
    let champImageOne = TCChampImage()
    let champImageTwo = TCChampImage()
    let champImageThree = TCChampImage()
    let champImageFour = TCChampImage()
    let champImageFive = TCChampImage()
    let champImageSix = TCChampImage()
    let champImageSeven = TCChampImage()
    let champImageEight = TCChampImage()
    
    lazy var champImagesStackView: UIStackView = {
        let stackView: UIStackView = UIStackView(arrangedSubviews: [champImageOne, champImageTwo, champImageThree, champImageFour, champImageFive, champImageSix, champImageSeven, champImageEight])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing =  6
        return stackView
    }()
    
    //MARK:- Champ Synergy Badges
    let synergyBadgeOne: TCSynergyBadge = TCSynergyBadge()
    let synergyBadgeTwo: TCSynergyBadge = TCSynergyBadge()
    let synergyBadgeThree: TCSynergyBadge = TCSynergyBadge()
    let synergyBadgeFour: TCSynergyBadge = TCSynergyBadge()
    let synergyBadgeFive: TCSynergyBadge = TCSynergyBadge()
    let synergyBadgeSix: TCSynergyBadge = TCSynergyBadge()
    let synergyBadgeSeven: TCSynergyBadge = TCSynergyBadge()
    
    lazy var synergiesStackView: UIStackView = {
        let stackView: UIStackView = UIStackView(arrangedSubviews: [synergyBadgeOne, synergyBadgeTwo, synergyBadgeThree, synergyBadgeFour, synergyBadgeFive, synergyBadgeSix, synergyBadgeSeven])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing =  4
        return stackView
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
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            teamCompTier.topAnchor.constraint(equalTo: topAnchor),
            teamCompTier.trailingAnchor.constraint(equalTo: trailingAnchor),
            teamCompTier.widthAnchor.constraint(equalToConstant: 60),
            teamCompTier.heightAnchor.constraint(equalToConstant: 17)
        ])
        
        
        //MARK: Champ Images
        addSubview(champImagesStackView)
        NSLayoutConstraint.activate([
            champImagesStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            champImagesStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
        ])
        
        
        //MARK: Synergy Badges
        addSubview(synergiesStackView)
        NSLayoutConstraint.activate([
            synergiesStackView.leadingAnchor.constraint(equalTo: champImagesStackView.leadingAnchor),
            synergiesStackView.topAnchor.constraint(equalTo: champImagesStackView.bottomAnchor, constant: 8),
            synergiesStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    
    // Required
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
