//
//  ChampionHeader.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 09/10/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class ChampionHeader: UICollectionReusableView {
    
    let starButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Tester", for: .normal)
        btn.showsTouchWhenHighlighted = true
        btn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        setupHeaderContent(starButton)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Tapped!")
    }
    
    fileprivate func setupHeaderContent(_ starButton: UIButton) {
        addSubview(starButton)
        starButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        starButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
