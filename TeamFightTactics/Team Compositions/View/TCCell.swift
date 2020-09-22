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
    
    //MARK:- Properties
    static var reuseId: String = "teamCompCellId"
    var champStackUpdater: StackViewContentUpdater<Champion, TCChampImage>!
    var synergyStackUpdater: StackViewContentUpdater<TCSynergy, TCSynergyBadge>!

    var currentChamps: [Champion] {
        return champStackUpdater.items
    }
    
    
    //MARK:- Override Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupCellContent()
        setupStackUpdaters()
    }
    
    
    //MARK:- Configure Cell
    func configureCell(teamComp: TeamComposition) {
        titleLabel.text = teamComp.title
        setTierLabel(teamComp.tier)
        champStackUpdater.setItems(teamComp.endGameChampObjs)
        synergyStackUpdater.setItems(teamComp.synergies)
    }
    
    
    //MARK:- Setup Stack Updaters
    fileprivate func setupStackUpdaters() {
        self.champStackUpdater = StackViewContentUpdater(stackView: champImagesStackView, makeView: {
            TCChampImage(imageSize: 35, borderWidth: 1.5)
        }, updateForItem: { (champion, champImage) in
            champImage.useStandardOrSetSkin(champion.imgURL, champion.key)
            champImage.setChampCostBorderColor(champCost: champion.cost)
        })
        
        self.synergyStackUpdater = StackViewContentUpdater(stackView: synergiesStackView, makeView: {
            TCSynergyBadge()
        }, updateForItem: { (synergy, synergyBadge) in
            synergyBadge.synergyCountLabel.text = "\(synergy.count)"
            synergyBadge.synergyIcon.image = UIImage(named: "\(synergy.name)")
            synergyBadge.backgroundColor = synergy.rank.setRankColor(synergy.chosen)
        })
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
        stackView.spacing =  4
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
        addSubviews(titleLabel, teamCompTier, champImagesStackView, synergiesStackView)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            teamCompTier.topAnchor.constraint(equalTo: topAnchor),
            teamCompTier.trailingAnchor.constraint(equalTo: trailingAnchor),
            teamCompTier.widthAnchor.constraint(equalToConstant: 60),
            teamCompTier.heightAnchor.constraint(equalToConstant: 17)
        ])
        
        
        //MARK: Champ Images
        NSLayoutConstraint.activate([
            champImagesStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            champImagesStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
        ])
        
        
        //MARK: Synergy Badges
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
