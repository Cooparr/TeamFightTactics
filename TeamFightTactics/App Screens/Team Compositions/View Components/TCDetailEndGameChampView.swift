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
    let champion: Champion
    let champImage: TappableChampionImageView
    let champBestItemImages = BaseStack(axis: .horizontal, spacing: 2)
    
    
    //MARK: Init
    required init(champion: Champion, items: [String]?) {
        self.champion = champion
        self.champImage = TappableChampionImageView(withChamp: champion, imageSize: 60)
        super.init(frame: .zero)
        champImage.useStandardOrSetSkin(champion.imageURL, champion.name.formattedName())
        champImage.setChampCostBorderColor(champCost: champion.cost)
        addBestItemImagesToStackView(items)
    }
    
    
    //MARK: Add Best Items
    fileprivate func addBestItemImagesToStackView(_ items: [String]?) {
        guard let items = items else { return }
        for item in items {
            let bestItemImageView = ItemImageView(size: 22)
            bestItemImageView.image = UIImage(named: item.formattedName())
            bestItemImageView.setChampCostBorderColor(champCost: champion.cost, rainbowLineWidth: 2.0)
            champBestItemImages.addArrangedSubview(bestItemImageView)
        }
    }
    
    
    //MARK: Setup View
    override func setupSubviews() {
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
