//
//  PNDetailView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 15/10/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class PNDetailView: BaseView {

    //MARK:- Properties
    let scrollViewContainer = BaseStack(axis: .vertical, spacing: 20)
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = ThemeColor.richBlack
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    
    //MARK:- Setup View
    override func setupView() {
        addSubview(scrollView)
        pinSubview(to: scrollView)
    }
    
    
    //MARK:- Setup Subviews
    override func setupSubviews() {
        scrollView.addSubview(scrollViewContainer)
        NSLayoutConstraint.activate([
            scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15),
            scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -15)
        ])
    }
}
