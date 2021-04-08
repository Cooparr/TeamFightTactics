//
//  GalaxyCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 09/09/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class GalaxyCell: BaseColViewCell, ReusableCell {
    
    typealias DataType = Galaxy
    static var reuseId: String = "galaxyCellId"
    
    let headerHorizontalStack = BaseStack(axis: .horizontal, alignment: .center, spacing: 10)
    let galaxyName = BaseLabel(fontSize: 16, fontWeight: .semibold)
    let galaxyDescription = BaseLabel(fontSize: 14, fontWeight: .regular, multiLine: true)
    let galaxyIcon = IconImageView(tintColor: TraitRatingColor.gold)
    let galaxyRemovedLabel: BaseLabel = {
        let lbl = BaseLabel(fontSize: 12, fontWeight: .semibold, fontColor: ThemeColor.richBlack, multiLine: true)
        lbl.textAlignment = .center
        lbl.clipsToBounds = true
        lbl.layer.cornerRadius = 6.0
        lbl.layer.maskedCorners = [.layerMinXMaxYCorner]
        return lbl
    }()

    
    func configureCell(with galaxy: Galaxy) {
        galaxyName.text = galaxy.name
        galaxyDescription.text = galaxy.description
        setGalaxyIcon(imageName: galaxy.imageName)
        setRemovedLabel(isRemoved: galaxy.removed, chancePercentage: galaxy.chance)
    }
    
    
    private func setGalaxyIcon(imageName: String?) {
        guard let galaxyImage = imageName else {
            galaxyIcon.isHidden = true
            return
        }
        
        galaxyIcon.image = UIImage(named: galaxyImage)
        galaxyIcon.tintColor = UIColor(cgColor: ChampCostColor.five)
        headerHorizontalStack.insertArrangedSubview(galaxyIcon, at: 0)
        galaxyIcon.isHidden = false
    }
    
    
    fileprivate func setRemovedLabel(isRemoved: Bool, chancePercentage: Int?) {
        switch isRemoved {
        case true:
            galaxyRemovedLabel.text = "Removed"
            galaxyRemovedLabel.backgroundColor = TierRatingColor.sTier
        case false:
            guard let chance = chancePercentage else { return }
            let removedString = "In Rotation\n\(chance)% Chance"
            let attributedString = NSMutableAttributedString(string: removedString)
            attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 10, weight: .semibold), range: NSRange(location: 11, length: 11))
            galaxyRemovedLabel.attributedText = attributedString
            galaxyRemovedLabel.backgroundColor = TierRatingColor.noTier
        }
    }
    
    
    
    override func setupCell() {
        backgroundColor = ThemeColor.charcoal
        layer.cornerRadius = 6.0
    }
    
    
    override func setupCellViews() {
        contentView.addSubviews(headerHorizontalStack, galaxyDescription, galaxyRemovedLabel)
        headerHorizontalStack.addArrangedSubview(galaxyName)
        NSLayoutConstraint.activate([
            headerHorizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            headerHorizontalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            headerHorizontalStack.heightAnchor.constraint(equalToConstant: 25),
            galaxyIcon.widthAnchor.constraint(equalTo: galaxyIcon.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            galaxyDescription.topAnchor.constraint(equalTo: headerHorizontalStack.bottomAnchor, constant: 6),
            galaxyDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            galaxyDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            galaxyDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            galaxyRemovedLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            galaxyRemovedLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            galaxyRemovedLabel.widthAnchor.constraint(equalToConstant: 80),
            galaxyRemovedLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 17)
        ])
    }
}
