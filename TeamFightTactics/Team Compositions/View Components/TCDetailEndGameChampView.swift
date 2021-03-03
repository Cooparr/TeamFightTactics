//
//  TCDetailEndGameChampView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 17/09/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCDetailEndGameChampView: BaseView {
    
    //MARK:- Properties
    let champImage = TappableChampionImageView(imageSize: 60)
    let champBestItemImages = BaseStack(axis: .horizontal, spacing: 2)
    
    
    init(champion: Champion, items: [String]?) {
        super.init(frame: .zero)
        champImage.champion = champion
        champImage.useStandardOrSetSkin(champion.imgURL, champion.key)
        champImage.setChampCostBorderColor(champCost: champion.cost)
        addBestItemImagesToStackView(items, champion.cost)
    }
    
    
    fileprivate func addBestItemImagesToStackView(_ items: [String]?, _ championCost: Cost) {
        guard let items = items else { return }
        for item in items {
            let bestItemImageView = BestItemImgView(img: UIImage(named: item.formattedName()), size: 22)
            bestItemImageView.setChampCostBorderColor(champCost: championCost, rainbowLineWidth: 2.0)
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
