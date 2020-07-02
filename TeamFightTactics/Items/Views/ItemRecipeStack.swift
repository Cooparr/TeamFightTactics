//
//  ItemRecipeStack.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 01/07/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class ItemRecipeStack: UIStackView {
    
    //MARK:- Properties
    let recipeLabel: BaseLabel = {
        let lbl = BaseLabel(fontSize: 14, fontWeight: .regular)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Recipe:"
        return lbl
    }()
    
    let recipeImgViews: [UIImageView] = (1...2).map { _ in
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 2.0
        imgView.layer.borderWidth = 1
        imgView.layer.borderColor = ThemeColor.independence.cgColor
        imgView.contentMode = .scaleAspectFit
        return imgView
    }
    
    let plusSymbol: UIImageView = {
        let imgView = UIImageView(image: UIImage(systemName: "plus"))
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.tintColor = ThemeColor.platinum
        imgView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 11, weight: .semibold)
        return imgView
    }()
    
    
    //MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStack()
        addSubviews()
    }
    
    
    //MARK:- Setup Stack
    fileprivate func setupStack() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
        spacing = 5
        alignment = .center
        distribution = .fill
        setCustomSpacing(10, after: recipeLabel)
    }
    
    
    //MARK:- Add Subviews
    fileprivate func addSubviews() {
        constrainImageViews()
        addArrangedSubview(recipeLabel)
        addArrangedSubview(recipeImgViews[0])
        addArrangedSubview(plusSymbol)
        addArrangedSubview(recipeImgViews[1])
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
    
    
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
