//
//  ChampionsController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 22/07/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ChampionsController: UIViewController {
    
    //MARK:- Properties
    private let champRootView = ChampionControllerView()
    private(set) var allChampions = [Champion]()
    private(set) var filteredChampions = [Champion]() {
        didSet {
            champRootView.showNoChampsFoundMessage(if: filteredChampions.isEmpty)
        }
    }
    
    
    //MARK: Firebase Listeners
    private var champListener: ListenerRegistration?
    
    
    //MARK:- Load View
    override func loadView() {
        super.loadView()
        self.view = champRootView
    }
    
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetup()
        
        // Assign Delegates
        champRootView.collectionView.dataSource = self
        champRootView.searchController.searchBar.delegate = self
    }
    
    
    //MARK:- View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchChampions()
    }
    
    
    //MARK:- View Will Disappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        champListener?.remove()
    }
    
    
    //MARK: Fetch Champions
    fileprivate func fetchChampions() {
        champRootView.activityIndicator.startAnimating()
        champListener =  SetDataManager().fetchData(from: .champions) { (champResult: Result<[Champion], SetDataError>) in
            switch champResult {
            case .success(let champions):
                self.allChampions = champions.sorted { $0.tier.rawValue < $1.tier.rawValue }
                self.filteredChampions = self.allChampions
            case .failure(let error):
                self.presentErrorAlertOnMainThread(title: "Error Fetching Champions", message: error.localizedDescription)
            }
            self.champRootView.activityIndicator.stopAnimating()
        }
    }
    
    
    //MARK: Navigation Bar Code
    fileprivate func navigationBarSetup() {
        setupNavBar(navTitle: TabTitle.champs)
        navigationItem.searchController = champRootView.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}


//MARK:- CollectionView Data Source
extension ChampionsController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredChampions.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ChampionCell.self, for: indexPath)
        cell.configureCell(with: filteredChampions[indexPath.item])
        return cell
    }
}


//MARK:- Search Bar Delegate
extension ChampionsController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else { return filteredChampions = allChampions }
        let searchText: String = searchText.formattedName()
        filteredChampions = allChampions.filter { (champ) -> Bool in
            let nameSearch = champ.name.formattedName().contains(searchText)
            
            for klass in champ.classes {
                if klass.formattedName().contains(searchText) {
                    return true
                }
            }
            
            for origin in champ.origins {
                if origin.formattedName().contains(searchText) {
                    return true
                }
            }
            
            return nameSearch
        }
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredChampions = allChampions
    }
}
