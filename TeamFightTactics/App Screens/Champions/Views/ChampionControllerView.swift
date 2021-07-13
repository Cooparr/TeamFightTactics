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
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(ChampionCell.self, forCellWithReuseIdentifier: ChampionCell.reuseId)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = ThemeColor.charcoal
        collectionView.indicatorStyle = .white
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private static func createLayout() -> UICollectionViewLayout {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(110))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 8, trailing: 8)
        section.interGroupSpacing = 6
        
        return UICollectionViewCompositionalLayout(section: section)
    }

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
    
    
    //MARK: Show No Champs Found View
    func showNoChampsFoundMessage(if isEmpty: Bool) {
        collectionView.shouldDisplayEmptyMessage(if: isEmpty, message: "Uh oh!\nNo Champions Found.")
        collectionView.reloadDataOnMainThread()
    }
}
