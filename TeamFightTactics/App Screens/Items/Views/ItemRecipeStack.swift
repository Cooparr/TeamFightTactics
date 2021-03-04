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
    let plusSymbol = IconImageView(icon: SFSymbol.OtherIcons.plus, tintColor: ThemeColor.platinum)
    let recipeImgViews: [GenericImageView] = (1...2).map { _ in
        return GenericImageView(cornerRadius: 2.0, borderWidth: 1.0, borderColor: ThemeColor.romanSilver)
    }
    
    
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
