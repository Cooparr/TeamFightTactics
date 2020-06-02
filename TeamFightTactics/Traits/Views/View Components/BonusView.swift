//
//  BonusView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 02/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class BonusView: UIStackView {
    
    //MARK:- Properties
    let traitCount: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.makeCircular(size: 20)
        lbl.font = .systemFont(ofSize: 14, weight: .regular)
        lbl.backgroundColor = ThemeColor.richBlack
        lbl.layer.borderWidth = 1
        lbl.textColor = ThemeColor.platinum
        return lbl
    }()
    
    let traitValue: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 14, weight: .regular)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textColor = ThemeColor.platinum
        return lbl
    }()
    
    
    //MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addArrangedSubview(traitCount)
        addArrangedSubview(traitValue)
    }
    
    //MARK:- Setup View
    fileprivate func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
        alignment = .center
        spacing = 10
    }
    
    
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
