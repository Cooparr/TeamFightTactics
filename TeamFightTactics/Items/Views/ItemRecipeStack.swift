//
//  ItemRecipeStack.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 01/07/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class ItemRecipeStack: BaseStack {
    
    //MARK:- Properties
    let recipeLabel = BaseLabel(fontSize: 14, fontWeight: .regular, lblText: "Recipe:")
    let recipeImgViews: [BaseImageView] = (1...2).map { _ in
        let imgView = BaseImageView()
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 2.0
        imgView.layer.borderWidth = 1
        imgView.layer.borderColor = ThemeColor.independence.cgColor
        return imgView
    }
    
    let plusSymbol: UIImageView = {
        let imgView = UIImageView(image: UIImage(systemName: "plus"))
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.tintColor = ThemeColor.platinum
        imgView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 11, weight: .semibold)
        return imgView
    }()
    
    
    //MARK:- Setup Stack
    override func setupStack() {
        axis = .horizontal
        spacing = 5
        alignment = .center
        distribution = .fill
        setCustomSpacing(10, after: recipeLabel)
    }
    
    
    //MARK:- Setup Arranged Subviews
    override func setupArrangedSubviews() {
        constrainImageViews()
        addArrangedSubviews(recipeLabel, recipeImgViews[0], plusSymbol, recipeImgViews[1])
//        addArrangedSubview(recipeLabel)
//        addArrangedSubview(recipeImgViews[0])
//        addArrangedSubview(plusSymbol)
//        addArrangedSubview(recipeImgViews[1])
    }
    
    
    //MARK:- Constrain Image Views
    fileprivate func constrainImageViews() {
        recipeImgViews.forEach { imageView in
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: 27),
                imageView.heightAnchor.constraint(equalToConstant: 27)
            ])
        }
    }
    
    
    //MARK:- Update Recipe Image
    func setRecipeImage(with itemName: String, for index: Int) {
        let itemImage = UIImage(named: itemName.formattedName())
        recipeImgViews[index].image = itemImage
    }
}
