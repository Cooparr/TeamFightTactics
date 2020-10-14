//
//  TraitCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 27/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class TraitCell: BaseColViewCell, ReusableCell {
    
    //MARK: Properties
    typealias DataType = Trait
    static var reuseId: String = "traitCellId"
    let traitTierLabel: BaseLabel = {
        let lbl = BaseLabel(fontSize: 14, fontWeight: .semibold, fontColor: ThemeColor.richBlack)
        lbl.textAlignment = .center
        lbl.clipsToBounds = true
        lbl.layer.cornerRadius = 6.0
        lbl.layer.maskedCorners = [.layerMinXMaxYCorner]
        return lbl
    }()
    
    let mainVertStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    let titleIconHorizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 8
        stack.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        return stack
    }()
    
    let traitIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.tintColor = ThemeColor.platinum
        return imgView
    }()
    
    let traitTitle = BaseLabel(fontSize: 16, fontWeight: .semibold)
    let spacerView: UIView = {
        let view = UIView()
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return view
    }()
    
    let effectLabel = BaseLabel(fontSize: 14, fontWeight: .regular, multiLine: true)
    let bonusesView = BaseView(tamic: false)
    let bonusesVertStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    lazy var contentWidth: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    
    
    //MARK:- Configure Cell
    func configureCell(with trait: Trait) {
        updateTierLabel(trait.tier)
        updateTileAndIcon(trait.name)
        updateEffectLabel(trait.effect)
        updateBonusLabels(trait.bonuses)
    }
    
    
    //MARK:- Override Setup Cell
    override func setupCell() {
        backgroundColor = ThemeColor.charcoal
        layer.cornerRadius = 6.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.clear.cgColor
        layer.masksToBounds = true
    }
    
    
    //MARK: Override Setup Cell Views
    override func setupCellViews() {
        setupContentViewConstraints()
        setupTierLabel()
        setupMainVertStack()
        addIconTitleHorizontalViews()
        setupBonusesSectionView()
    }
    
    
    //MARK: Setup Content View Constraints
    fileprivate func setupContentViewConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
    
    
    //MARK: Set Tier Label And Color
    fileprivate func updateTierLabel(_ tier: TierRating) {
        tier.setTierTextAndColor(for: traitTierLabel)
    }
    
    
    //MARK: Set Title & Icon
    fileprivate func updateTileAndIcon(_ name: String) {
        traitTitle.text = name
        traitIcon.image = UIImage(named: name)
    }
    
    
    //MARK: Set Effect Label
    fileprivate func updateEffectLabel(_ effect: String?) {
        guard effect != nil else {
            effectLabel.isHidden = true
            return
        }
        effectLabel.text = effect
    }
    
    
    //MARK: Set Bonus Labels
    fileprivate func updateBonusLabels(_ bonuses: [Bonus]) {
        bonusesVertStack.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        for bonus in bonuses {
            let bonusView = BonusView()
            bonusView.traitCount.layer.borderColor = bonus.rank.setRankColor().cgColor
            bonusView.traitCount.text = "\(bonus.count)"
            bonusView.traitValue.text = bonus.value
            bonusesVertStack.addArrangedSubview(bonusView)
        }
    }
    
    
    //MARK: System Layout Size Fitting
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        contentWidth.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
    
    
    //MARK:- Setup Tier Label
    fileprivate func setupTierLabel() {
        contentView.addSubview(traitTierLabel)
        NSLayoutConstraint.activate([
            traitTierLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            traitTierLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            traitTierLabel.widthAnchor.constraint(equalToConstant: 70),
            traitTierLabel.heightAnchor.constraint(equalToConstant: 17)
        ])
    }
    
    
    //MARK: Setup Main Vertical Stack
    fileprivate func setupMainVertStack() {
        contentView.addSubview(mainVertStack)
        mainVertStack.addArrangedSubviews(titleIconHorizontalStack, effectLabel, bonusesView)
        NSLayoutConstraint.activate([
            mainVertStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainVertStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainVertStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            mainVertStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    
    //MARK: Setup Bonuses Section
    fileprivate func setupBonusesSectionView() {
        bonusesView.addSubview(bonusesVertStack)
        NSLayoutConstraint.activate([
            bonusesVertStack.topAnchor.constraint(equalTo: bonusesView.topAnchor),
            bonusesVertStack.leadingAnchor.constraint(equalTo: bonusesView.leadingAnchor, constant: 10),
            bonusesVertStack.trailingAnchor.constraint(equalTo: bonusesView.trailingAnchor, constant: -10),
            bonusesVertStack.bottomAnchor.constraint(equalTo: bonusesView.bottomAnchor)
        ])
    }
    
    
    //MARK: Add Icon & Title Subviews
    fileprivate func addIconTitleHorizontalViews() {
        titleIconHorizontalStack.addArrangedSubviews(traitIcon, traitTitle, spacerView)
    }
}
