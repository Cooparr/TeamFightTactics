//
//  ItemSelectionCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 21/01/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class ItemSelectionCell: BaseColViewCell, ReusableCell {
    
    //MARK:- Properties
    typealias DataType = Item
    static var reuseId: String = "createCustomTeamCompItemSelectionCell"
    
    #warning("Do i prefer this way of creating instances?")
    var itemNameLabel: UILabel!
    var itemImageView: UIImageView!
    
    override var isHighlighted: Bool {
        didSet {
            pulseAnimateOnTap()
        }
    }
    
    
    //MARK:- Configure Cell
    func configureCell(with item: Item) {
        itemNameLabel.text = item.name
        itemImageView.image = UIImage(named: item.name.formattedName())
    }
    
    
    //MARK: Pulse Animation On Tap
    fileprivate func pulseAnimateOnTap() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.25
        pulse.repeatCount = 1
        pulse.autoreverses = true
        pulse.fromValue = 1
        pulse.toValue = 1.05
        pulse.initialVelocity = 0.5
        pulse.damping = 1
        
        layer.add(pulse, forKey: nil)
    }
    
    
    //MARK:- Setup Cell
    override func setupCell() {
        backgroundColor = ThemeColor.charcoal
        layer.cornerRadius = 3
        clipsToBounds = true
        
        setupItemImageView()
        setupItemNameLabel()
    }
    
    
    //MARK: Setup Item Image View
    fileprivate func setupItemImageView() {
        itemImageView = UIImageView()
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.clipsToBounds = true
        itemImageView.layer.cornerRadius = 3
        itemImageView.layer.borderColor = ThemeColor.independence.cgColor
        itemImageView.layer.borderWidth = 2
        
        let padding: CGFloat = 5
        contentView.addSubview(itemImageView)
        NSLayoutConstraint.activate([
            itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            itemImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            itemImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            itemImageView.heightAnchor.constraint(equalTo: itemImageView.widthAnchor)
        ])
    }
    
    
    //MARK: Setup Item Name Label
    fileprivate func setupItemNameLabel() {
        itemNameLabel = UILabel()
        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        itemNameLabel.textAlignment = .center
        itemNameLabel.numberOfLines = 0
        itemNameLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        itemNameLabel.adjustsFontSizeToFitWidth = true
        itemNameLabel.minimumScaleFactor = 0.85
        
        let padding: CGFloat = 2
        contentView.addSubview(itemNameLabel)
        NSLayoutConstraint.activate([
            itemNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            itemNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            itemNameLabel.bottomAnchor.constraint(equalTo: itemImageView.topAnchor)
        ])
    }
}
