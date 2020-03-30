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
    
    var currentSynergies = [TeamCompositionSynergies]()
    var currentChamps = [Champion]()
    
    var teamComp: TeamComposition? {
        didSet {
            guard
                let title: String = teamComp?.title,
                let tier: TierRating = teamComp?.tier,
                let allSynergies: [TeamCompositionSynergies] = teamComp?.synergies,
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
    fileprivate func setTeamCompChampImages(_ newChamps: [Champion]) {
        guard newChamps != self.currentChamps else { return }
        
        for (index, champ) in newChamps.enumerated() {
            if index >= self.currentChamps.endIndex {
                let newImage = TCChampImage()
                self.champImages.append(newImage)
                self.currentChamps.append(champ)
                updateChampImage(imageView: newImage, champ: champ)
                champImagesStackView.addArrangedSubview(newImage)
            } else {
                if self.currentChamps[index] != champ {
                    let currentImgView = self.champImages[index]
                    updateChampImage(imageView: currentImgView, champ: champ)
                }
            }
        }
        
        let champOverflow = self.currentChamps.count - newChamps.count
        if champOverflow > 0 {
            self.currentChamps.removeLast(champOverflow)
            let removedIndices: PartialRangeFrom<Int> = (self.champImages.endIndex - champOverflow)...
            let removed = self.champImages[removedIndices]
            self.champImages[removedIndices] = []
            for rem in removed {
                rem.removeFromSuperview()
            }
        }
    }
    
    func updateChampImage(imageView: TCChampImage, champ: Champion) {
        let placeholder = UIImage(named: "placeholder")
        let champImgUrl = URL(string: champ.imgURL)
        imageView.sd_setImage(with: champImgUrl, placeholderImage: placeholder)
        champ.cost.setChampImageBorder(for: imageView)
    }

    
    //MARK: Set Team Comp Synergy Badges
    fileprivate func setTeamCompSynergyBadges(_ newSynergies: [TeamCompositionSynergies]) {
        guard newSynergies != self.currentSynergies else { return }
        
        for (index, synergy) in newSynergies.enumerated() {
            if index >= self.currentSynergies.endIndex {
                let newBadge = TCSynergyBadge()
                self.synergyBadges.append(newBadge)
                self.currentSynergies.append(synergy)
                updateBadgeViewWithSynergy(badgeView: newBadge, synergy: synergy)
                synergiesStackView.addArrangedSubview(newBadge)
            } else {
                if self.currentSynergies[index] != synergy {
                    let currentBadge = self.synergyBadges[index]
                    updateBadgeViewWithSynergy(badgeView: currentBadge, synergy: synergy)
                }
            }
        }
        
        let badgeOverflow = self.currentSynergies.count - newSynergies.count
        if badgeOverflow > 0 {
            self.currentSynergies.removeLast(badgeOverflow)
            let removedIndices: PartialRangeFrom<Int> = (self.synergyBadges.endIndex - badgeOverflow)...
            let removed = self.synergyBadges[removedIndices]
            self.synergyBadges[removedIndices] = []
            for rem in removed {
                rem.removeFromSuperview()
            }
        }
    }
    
    func updateBadgeViewWithSynergy(badgeView: TCSynergyBadge, synergy: TeamCompositionSynergies) {
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
        
        badgeView.synergyCountLabel.text = "\(synergy.count)"
        badgeView.synergyIcon.image = UIImage(named: "\(synergy.name)")
        badgeView.backgroundColor = badgeColor
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
    var champImages = [TCChampImage]()
    let champImagesStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing =  6
        return stackView
    }()
    
    //MARK:- Champ Synergy Badges
    var synergyBadges = [TCSynergyBadge]()
    let synergiesStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
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
            synergiesStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            synergiesStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            synergiesStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    
    // Required
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
