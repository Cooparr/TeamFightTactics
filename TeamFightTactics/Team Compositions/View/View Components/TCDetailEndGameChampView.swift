//
//  TCDetailEndGameChampView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 17/09/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCDetailEndGameChampView: BaseView {
    
    let champImage = TCChampImage(imageSize: 60, borderWidth: 2)
    let champBestItemImages: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 2
        return stack
    }()
    

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
}
