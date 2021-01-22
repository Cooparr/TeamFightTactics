//
//  TCDetailEndGameChampView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 17/09/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCDetailEndGameChampView: BaseView {
    
//    let champImage = TCChampImage(imageSize: 60, borderWidth: 2)
    let champImage = TappableChampionImageView(imageSize: 60)
    let champBestItemImages = BaseStack(axis: .horizontal, spacing: 2)
    
    
    init(champ: Champion, endGameChar: TCEndGameChamp) {
        super.init(frame: .zero)
        champImage.champion = champ
        champImage.useStandardOrSetSkin(champ.imgURL, champ.key)
        champImage.setChampCostBorderColor(champCost: champ.cost)
        addBestItemImagesToStackView(endGameChar.items, champ)
    }
    
    
    fileprivate func addBestItemImagesToStackView(_ bestItems: [String]?, _ champion: Champion) {
        guard let items = bestItems else { return }
        for item in items {
            let bestItemImageView = BestItemImgView(img: UIImage(named: item.formattedName()), size: 22)
            bestItemImageView.setChampCostBorderColor(champCost: champion.cost, rainbowLineWidth: 2.0)
            champBestItemImages.addArrangedSubview(bestItemImageView)
        }
    }
    
    override func setupView() {
        addSubviews(champImage, champBestItemImages)
        NSLayoutConstraint.activate([
            champImage.topAnchor.constraint(equalTo: topAnchor),
            champImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            champImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            champImage.heightAnchor.constraint(equalToConstant: 60),
            champImage.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            champBestItemImages.topAnchor.constraint(equalTo: champImage.bottomAnchor, constant: -5),
            champBestItemImages.centerXAnchor.constraint(equalTo: champImage.centerXAnchor),
            champBestItemImages.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
