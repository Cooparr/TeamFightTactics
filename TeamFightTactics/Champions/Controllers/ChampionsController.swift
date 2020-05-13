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
    var filteredChampions = [Champion]()
    var allChampions = [Champion]() {
        didSet {
            filteredChampions = allChampions
            handleSpinner(spin: champRootView.activityIndicator, if: allChampions.isEmpty)
            champRootView.collectionView.reloadData()
        }
    }
    
    var useSetSkins: Bool? = nil {
        didSet {
            champRootView.collectionView.reloadData()
        }
    }
    
    
    //MARK:- Load View
    override func loadView() {
        super.loadView()
        self.view = champRootView
    }
    
    
    //MARK:- View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleSpinner(spin: champRootView.activityIndicator, if: allChampions.isEmpty)
        useSetSkins = UserDefaults.standard.bool(forKey: UDKey.skinsKey)
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
    
    
    //MARK: Navigation Bar Code
    fileprivate func navigationBarSetup() {
        navigationItem.title = "Champions"
        navigationItem.searchController = champRootView.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        rightNavBarSettingsButton()
    }
}


// MARK:- CollectionView Data Source
extension ChampionsController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredChampions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ChampionCell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseId.champCell, for: indexPath) as! ChampionCell
        cell.champion = filteredChampions[indexPath.item]
        return cell
    }
    
}


// MARK:- CollectionView Delegate
extension ChampionsController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ChampionCell else { return }
        let statBaseValues: [Int] = [allChampions[indexPath.item].stats.health, allChampions[indexPath.item].stats.attackDamage]
        let statLabels: [UILabel] = [cell.healthStat.statLabel, cell.attackDamageStat.statLabel]
        for (i, statLabel) in statLabels.enumerated() {
            guard let labelValue = statLabels[i].text else { return }
            let level2: Int = Int(Double(statBaseValues[i]) * 1.8)
            let level3: Int = Int(Double(statBaseValues[i]) * 3.6)
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
}


//MARK:- CollectionView Delegate Flow Layout
extension ChampionsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let champAbilityText: String = self.filteredChampions[indexPath.item].ability.abilityDescription
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
