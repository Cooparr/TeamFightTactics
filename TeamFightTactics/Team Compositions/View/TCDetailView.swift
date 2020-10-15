//
//  TCDetailView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 11/12/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCDetailView: BaseView {
    
    //MARK: Scroll View & Container
    let scrollViewContainer = BaseStack(axis: .vertical, spacing: 10)
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = ThemeColor.richBlack
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()

    
    //MARK:- Setup Subviews
    override func setupSubviews() {
        addSubview(scrollView)
        scrollView.pinSubview(to: self)
        
        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.pinSubview(to: scrollView)
        scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
}


//MARK:- ScrollView Delegate
extension TCDetailView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        }
    }
}
