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
    
    var currentSynergies = [TCSynergies]()
    var currentChamps = [Champion]()
    
    var teamComp: TeamComposition? {
        didSet {
            guard
                let title: String = teamComp?.title,
                let tier: TierRating = teamComp?.tier,
                let synergies: [TCSynergies] = teamComp?.synergies,
                let champions = teamComp?.endGameChampObjs
                else { return }
            if champions.isEmpty { return }
            
            titleLabel.text = title
            setTierLabel(tier)
            
            // Ben
//            setTeamCompChampImages(champions)
//            setTeamCompSynergyBadges(synergies)

            // Without Stack - Removing Images / Badges
            withoutStackViewChampImages(champions)
            withoutStackViewSynergyBadges(synergies)
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
                let newImage = TCChampImage(imageSize: 35, borderWidth: 1.5)
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
    
    fileprivate func withoutStackViewChampImages(_ newChamps: [Champion]) {
        guard newChamps != self.currentChamps else { return }
        
        for (index, champ) in newChamps.enumerated() {
            if index >= self.currentChamps.endIndex {
                let newImage = TCChampImage(imageSize: 35, borderWidth: 1.5)
                self.champImages.append(newImage)
                self.currentChamps.append(champ)
                updateChampImage(imageView: newImage, champ: champ)
                
                addSubview(newImage)
                newImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
                if index == 0 {
                    newImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
                } else {
                    newImage.leadingAnchor.constraint(equalTo: self.champImages[index - 1].trailingAnchor, constant: 5).isActive = true
                }
            } else {
                if self.currentChamps[index] != champ {
                    self.currentChamps[index] = champ
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
    
    
    //MARK: Update Champ Image
    func updateChampImage(imageView: TCChampImage, champ: Champion) {
        imageView.useStandardOrSetSkin(champ.imgURL, champ.key)
        champ.cost.setChampImageBorder(for: imageView)
    }

    
    //MARK: Set Team Comp Synergy Badges
    fileprivate func setTeamCompSynergyBadges(_ newSynergies: [TCSynergies]) {
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
                    self.currentSynergies[index] = synergy
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
    
    fileprivate func withoutStackViewSynergyBadges(_ newSynergies: [TCSynergies]) {
        guard newSynergies != self.currentSynergies else { return }
        
        for (index, synergy) in newSynergies.enumerated() {
            if index >= self.currentSynergies.endIndex {
                let newBadge = TCSynergyBadge()
                self.synergyBadges.append(newBadge)
                self.currentSynergies.append(synergy)
                updateBadgeViewWithSynergy(badgeView: newBadge, synergy: synergy)
                
                addSubview(newBadge)
                newBadge.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
                if index == 0 {
                    newBadge.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
                } else {
                    newBadge.leadingAnchor.constraint(equalTo: self.synergyBadges[index - 1].trailingAnchor, constant: 5).isActive = true
                }
            } else {
                if self.currentSynergies[index] != synergy {
                    self.currentSynergies[index] = synergy
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
    
    
    //MARK: Update Badge With Synergy
    func updateBadgeViewWithSynergy(badgeView: TCSynergyBadge, synergy: TCSynergies) {
        
        badgeView.synergyCountLabel.text = "\(synergy.count)"
        badgeView.synergyIcon.image = UIImage(named: "\(synergy.name)")
        badgeView.backgroundColor = synergy.rank.setRankColor()
    }
    
    
    //MARK: Set Tier Label And Color
    fileprivate func setTierLabel(_ tier: TierRating) {
        tier.setTierTextAndColor(for: teamCompTier)
    }
    
    //MARK:- Team Comp Title & Tier
    let titleLabel = BaseLabel(fontSize: 18, fontWeight: .medium)
    let teamCompTier: BaseLabel = {
        let lbl = BaseLabel(fontSize: 12, fontWeight: .semibold, fontColor: ThemeColor.richBlack)
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
        backgroundColor = ThemeColor.richBlack
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
            synergiesStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14),
            synergiesStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    
    // Required
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
