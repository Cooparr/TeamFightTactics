//
//  ChampionControllerView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 11/12/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class ChampionControllerView: BaseView {
    
    //MARK:- Properties
    let activityIndicator = CustomActivityIndicator()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 6
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ChampionCell.self, forCellWithReuseIdentifier: ChampionCell.reuseId)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = ThemeColor.charcoal
        collectionView.indicatorStyle = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 6, right: 0)
        return collectionView
    }()

    let searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.searchBarStyle = .minimal
        search.searchBar.placeholder = "Search by Name, Class or Origin"
        search.searchBar.tintColor = ThemeColor.platinum
        return search
    }()
    
    
    //MARK: Setup View
    override func setupView() {
        addSubview(collectionView)
        collectionView.pinSubview(to: self)
    }
    
    
    //MARK: Setup Subviews
    override func setupSubviews() {
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
