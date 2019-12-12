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
            guard
                let title = teamComp?.title,
                let tier = teamComp?.tier,
                let endGameChamps = teamComp?.endGame,
                let allSynergies = teamComp?.synergies.sorted(by: { $0.rank.rawValue < $1.rank.rawValue })
                else { return }
            
            
            titleLabel.text = title
            setTierLabelAndColor(tier)
            setTeamCompChampImages(endGameChamps)
            setTeamCompSynergyBadges(allSynergies)
        }
    }
    
    
    //MARK:- Override Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupCellContent()
    }
    
    
    //MARK: Set Team Comp Champ Images
    fileprivate func setTeamCompChampImages(_ endGameChamps: [TeamCompositionEndGameChamps]) {
        var champNames = [String]()
        let champImgArray = [champImageOne, champImageTwo, champImageThree, champImageFour, champImageFive, champImageSix, champImageSeven, champImageEight]

        endGameChamps.forEach { (champ) in
            champNames.append(champ.name.replacingOccurrences(of: " ", with: ""))
        }

        for i in 0..<8 {
            if i < champNames.count {
                champImgArray[i].sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.13.1/img/champion/\(champNames[i]).png"))
            } else {
                champImgArray[i].image = nil
                champImgArray[i].isHidden = true
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
        
        teamCompTier.text = tierText
        teamCompTier.backgroundColor = tierColor
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
    
    
    //MARK:- Champ Synergy Badges
    let synergyBadgeOne = TCSynergyBadge()
    let synergyBadgeTwo = TCSynergyBadge()
    let synergyBadgeThree = TCSynergyBadge()
    let synergyBadgeFour = TCSynergyBadge()
    let synergyBadgeFive = TCSynergyBadge()
    let synergyBadgeSix = TCSynergyBadge()
    
    lazy var synergiesStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [synergyBadgeOne, synergyBadgeTwo, synergyBadgeThree, synergyBadgeFour, synergyBadgeFive, synergyBadgeSix])
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
        addSubview(champImageOne)
        addSubview(champImageTwo)
        addSubview(champImageThree)
        addSubview(champImageFour)
        addSubview(champImageFive)
        addSubview(champImageSix)
        addSubview(champImageSeven)
        addSubview(champImageEight)
        
        let champImgSpacing: CGFloat = 6
        NSLayoutConstraint.activate([
            champImageOne.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            champImageOne.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            champImageTwo.topAnchor.constraint(equalTo: champImageOne.topAnchor),
            champImageTwo.leadingAnchor.constraint(equalTo: champImageOne.trailingAnchor, constant: champImgSpacing),
            champImageThree.topAnchor.constraint(equalTo: champImageTwo.topAnchor),
            champImageThree.leadingAnchor.constraint(equalTo: champImageTwo.trailingAnchor, constant: champImgSpacing),
            champImageFour.topAnchor.constraint(equalTo: champImageThree.topAnchor),
            champImageFour.leadingAnchor.constraint(equalTo: champImageThree.trailingAnchor, constant: champImgSpacing),
            champImageFive.topAnchor.constraint(equalTo: champImageFour.topAnchor),
            champImageFive.leadingAnchor.constraint(equalTo: champImageFour.trailingAnchor, constant: champImgSpacing),
            champImageSix.topAnchor.constraint(equalTo: champImageFive.topAnchor),
            champImageSix.leadingAnchor.constraint(equalTo: champImageFive.trailingAnchor, constant: champImgSpacing),
            champImageSeven.topAnchor.constraint(equalTo: champImageSix.topAnchor),
            champImageSeven.leadingAnchor.constraint(equalTo: champImageSix.trailingAnchor, constant: champImgSpacing),
            champImageEight.topAnchor.constraint(equalTo: champImageSeven.topAnchor),
            champImageEight.leadingAnchor.constraint(equalTo: champImageSeven.trailingAnchor, constant: champImgSpacing)
        ])
        

        
        //MARK: Synergy Badges
        addSubview(synergiesStackView)
        NSLayoutConstraint.activate([
            synergiesStackView.leadingAnchor.constraint(equalTo: champImageOne.leadingAnchor),
            synergiesStackView.topAnchor.constraint(equalTo: champImageOne.bottomAnchor, constant: 8),
            synergiesStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    
    // Required
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}