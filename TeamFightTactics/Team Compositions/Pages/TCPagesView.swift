//
//  TCPagesView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 20/11/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class TCPagesView: BaseView {

    //MARK:- Properties
    let menuBar = MenuBarController(menuTitles: [.meta, .custom])
    let horizontalScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.isScrollEnabled = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        return scrollView
    }()

    let pagesStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.alignment = .center
        return stack
    }()


    //MARK:- Setup View
    override func setupView() {
        menuBar.scrollView = horizontalScrollView.self
    }
    
    
    //MARK:- Setup Subviews
    override func setupSubviews() {
        constrainMenuBar()
        constrainScrollView()
        constrainStackView()
    }
    
    
    //MARK:- Constrain Menu Bar
    fileprivate func constrainMenuBar() {
        addSubview(menuBar.view)
        NSLayoutConstraint.activate([
            menuBar.menuView.heightAnchor.constraint(equalToConstant: 50),
            menuBar.menuView.topAnchor.constraint(equalTo: self.topAnchor),
            menuBar.menuView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            menuBar.menuView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    
    //MARK:- Constrain Scroll View
    fileprivate func constrainScrollView() {
        addSubview(horizontalScrollView)
        NSLayoutConstraint.activate([
            horizontalScrollView.topAnchor.constraint(equalTo: menuBar.view.bottomAnchor),
            horizontalScrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            horizontalScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            horizontalScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    
    //MARK:- Constrain Stack View
    fileprivate func constrainStackView() {
        horizontalScrollView.addSubview(pagesStackView)
        NSLayoutConstraint.activate([
            pagesStackView.topAnchor.constraint(equalTo: horizontalScrollView.topAnchor),
            pagesStackView.bottomAnchor.constraint(equalTo: horizontalScrollView.bottomAnchor),
            pagesStackView.leadingAnchor.constraint(equalTo: horizontalScrollView.leadingAnchor),
            pagesStackView.trailingAnchor.constraint(equalTo: horizontalScrollView.trailingAnchor)
        ])
    }
    

    //MARK:- Constrain Page In StackView
    func constrainPageInStackView(pageView: UIView) {
        NSLayoutConstraint.activate([
            pageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            pageView.topAnchor.constraint(equalTo: menuBar.view.bottomAnchor),
            pageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
