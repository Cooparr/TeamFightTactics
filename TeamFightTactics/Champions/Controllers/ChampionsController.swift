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
    var displayedSet: Int?
    var allChampions = [Champion]() {
        didSet {
            filteredChampions = allChampions
            champRootView.activityIndicator.stopAnimating()
            champRootView.collectionView.reloadData()
        }
    }
    
    var filteredChampions = [Champion]() {
        didSet {
            if filteredChampions.isEmpty {
                champRootView.collectionView.setEmptyMessage("Uh oh!\nNo Champions Found.")
            } else {
                champRootView.collectionView.removeEmptyMessage()
            }
        }
    }
    
    var useSetSkins: Bool? = nil {
        didSet {
            guard useSetSkins != oldValue else { return }
            champRootView.collectionView.reloadData()
        }
    }
    
    
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
        champRootView.collectionView.delegate = self
        champRootView.collectionView.dataSource = self
        champRootView.searchController.searchBar.delegate = self
    }
    
    
    //MARK:- View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        useSetSkins = UserDefaults.standard.bool(forKey: UDKey.skinsKey)
        fetchChampions()
    }
    
    
    //MARK: Fetch Champions
    fileprivate func fetchChampions() {
        let fetchedSet = UserDefaults.standard.integer(forKey: UDKey.setKey)
        if displayedSet != fetchedSet {
            champRootView.activityIndicator.startAnimating()
            displayedSet = fetchedSet
            let firestore = FirestoreManager()
            firestore.fetchSetData(from: .champions, updateKey: .champs) { champions in
                self.allChampions = champions
            }
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
        
        cell.bestItemsStackView.arrangedSubviews.forEach { imgView in
            if let imgView = imgView as? BestItemImgView {
                imgView.image = nil
            }
        }
        
        cell.configureCell(with: filteredChampions[indexPath.item])
        return cell
    }
}


//MARK:- CollectionView Delegate Flow Layout
extension ChampionsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ChampionCell else { return }
        let statBaseValues = [allChampions[indexPath.item].stats.health, allChampions[indexPath.item].stats.attackDamage]
        let statLabels = [cell.baseStats.healthStat.statLabel, cell.baseStats.attDmgStat.statLabel]
        for (i, statLabel) in statLabels.enumerated() {
            guard let labelValue = statLabels[i].text else { return }
            let level2 = Int(Double(statBaseValues[i]) * 1.8)
            let level3 = Int(Double(statBaseValues[i]) * 3.6)
            UIView.transition(with: statLabel, duration: 0.8, options: .transitionFlipFromBottom, animations: {
                switch Int(labelValue) {
                case level2:
                    statLabels[i].text = "\(level3)"
                case level3:
                    statLabels[i].text = "\(statBaseValues[i])"
                default:
                    statLabels[i].text = "\(level2)"
                }
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let champAbilityText: String = self.filteredChampions[indexPath.item].ability.description
        let heightPad: CGFloat = 121
        let widthPad: CGFloat = 60
        let approxAbilityDescWidth: CGFloat = view.frame.width - widthPad
        let size: CGSize = CGSize(width: approxAbilityDescWidth, height: 1000)
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11)]
        let estimatedFrame = NSString(string: champAbilityText).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        let setWidth: CGFloat = view.frame.width - 8
        var setHeight: CGFloat = estimatedFrame.height + heightPad
        
        if estimatedFrame.height + heightPad < 120 {
            setHeight = 120
        }
        
        return CGSize(width: setWidth, height: setHeight)
    }   
}

//MARK:- Search Bar Delegate
extension ChampionsController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredChampions = allChampions
        } else {
            let searchText: String = searchText.lowercased()
            filteredChampions = allChampions.filter { (champ) -> Bool in
                let nameSearch: Bool = champ.name.lowercased().contains(searchText)
                
                var originSearch: Bool = false
                _ = champ.origins.filter {
                    originSearch = $0.lowercased().contains(searchText)
                    return originSearch
                }
                
                var classSearch: Bool = false
                _ = champ.classes.filter {
                    classSearch = $0.lowercased().contains(searchText)
                    return classSearch
                }
                
                return nameSearch || originSearch || classSearch
            }
        }
        self.champRootView.collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredChampions = allChampions
        self.champRootView.collectionView.reloadData()
    }
}
