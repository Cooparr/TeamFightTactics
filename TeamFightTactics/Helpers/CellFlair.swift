//
//  CellFlair.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 06/07/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class CellFlair: UIView {
    
    //MARK:- Properties
    private let flairLabel = BaseLabel(fontSize: 13, fontWeight: .semibold, fontColor: ThemeColor.richBlack, textAlignment: .center)
    
    
    //MARK:- Override Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        layer.cornerRadius = 6.0
        layer.maskedCorners = [.layerMinXMaxYCorner]
        
        
        addSubview(flairLabel)
        flairLabel.pinSubview(to: self)
    }
    
    
    //MARK:- Update Flair (Text Font + Color)
    func updateFlair(text: String, flairColor: UIColor) {
        flairLabel.text = text
        backgroundColor = flairColor
    }
    
    
    //MARK: Update Flair (Tier Rating)
    func updateFlair(with tierRating: TierRating) {
        switch tierRating {
        case .sTier:
            updateFlair(text: "S Tier", flairColor: TierRatingColor.sTier)
        case .aTier:
            updateFlair(text: "A Tier", flairColor: TierRatingColor.aTier)
        case .bTier:
            updateFlair(text: "B Tier", flairColor: TierRatingColor.bTier)
        case .cTier:
            updateFlair(text: "C Tier", flairColor: TierRatingColor.cTier)
        case .dTier:
            updateFlair(text: "D Tier", flairColor: TierRatingColor.dTier)
        case .noTier:
            updateFlair(text: "Untiered", flairColor: TierRatingColor.sTier)
        }
    }
    
    
    //MARK:- Constrain Cell Flair (TableViewCell)
    func constrainCellFlair(to cell: UITableViewCell) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: cell.topAnchor),
            self.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
            self.widthAnchor.constraint(equalToConstant: 60),
            self.heightAnchor.constraint(equalToConstant: 17)
        ])
    }
    
    
    //MARK: Constrain Cell Flair (UIView)
    func constrainCellFlair(to view: UIView, width: CGFloat, height: CGFloat) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.widthAnchor.constraint(equalToConstant: width),
            self.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
