//
//  TCEndGameView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 04/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCEndGameView: UIView {
    
    //MARK: Properties
    var endGameImages = [TCDetailChampImage]()
    let endGameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "End Game"
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        lbl.textAlignment = .center
        lbl.textColor = ThemeColor.platinum
        return lbl
    }()
    
    let topStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 25
        return stackView
    }()

    let botStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 25
        return stackView
    }()
    
    
    //MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSection()
        setupLabelConstraints()
        setupStackViewConstraints()
    }
    
    
    //MARK: Setup Section
    fileprivate func setupSection() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ThemeColor.richBlack
    }
    
    
    //MARK: Setup Label Constraints
    fileprivate func setupLabelConstraints() {
        addSubview(endGameLabel)
        NSLayoutConstraint.activate([
            endGameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            endGameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            endGameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    
    //MARK: Setup End Game Constraints
    fileprivate func setupStackViewConstraints() {
        addSubview(topStack)
        NSLayoutConstraint.activate([
            topStack.topAnchor.constraint(equalTo: endGameLabel.bottomAnchor, constant: 6),
            topStack.centerXAnchor.constraint(equalTo: endGameLabel.centerXAnchor)
        ])
        
        addSubview(botStack)
        NSLayoutConstraint.activate([
            botStack.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 20),
            botStack.leadingAnchor.constraint(equalTo: topStack.leadingAnchor),
            botStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
