//
//  ChampionsController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 22/07/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class ChampionsController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    //MARK:- Properties
    let reuseIdentifier = "cellId"
    var champCount: Int?
    var filteredChampions = [Champion]()
    var allChampions = [Champion]()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .whiteLarge)
        spinner.color = CustomColor.romanSilver
        view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return spinner
    }()
    
    lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        definesPresentationContext = true
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.searchBarStyle = .minimal
        search.searchBar.placeholder = "Search by Name, Class or Origin"
        search.searchBar.tintColor = CustomColor.platinum
        search.searchBar.delegate = self
        return search
    }()
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Champions"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        setupCollectionView()
    }
    
    
    //MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        if champCount != allChampions.count {
            loadDataFromFirestore()
        }
    }
    
    
    //MARK:- Firestore Load Data
    fileprivate func loadDataFromFirestore() {
        self.activityIndicator.startAnimating()
        self.allChampions.removeAll()
        
        FirestoreManager.champs.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents:", err)
            } else if let querySnapshot = querySnapshot {
                for document in querySnapshot.documents {
                    let champ = Champion(data: document.data())
                    self.allChampions.append(champ)
                    self.allChampions.sort(by: {$1.cost < $0.cost})
                    self.filteredChampions = self.allChampions
                    self.champCount = self.allChampions.count
//                    print("\n-----\n")
//                    print("name: ", champ.name)
//                    print("cost: ", champ.cost)
//                    print("origins: ", champ.origins)
//                    print("classes: ", champ.classes)
//                    print("tier: ", champ.tier)
//                    print("patched: ", champ.patched)
//                    print("best items: ", champ.bestItems)
//                    print("\nability name: ", champ.ability.name)
//                    print("ability active: ", champ.ability.active)
//                    print("ability description: ", champ.ability.abilityDescription)
//                    print("ability stats: ", champ.ability.abilityStat)
//                    print("mana cost: ", champ.ability.manaCost)
//                    print("mana start: ", champ.ability.manaStart)
//                    print("\nattackDamage: ", champ.stats.attackDamage)
//                    print("attackSpeed: ", champ.stats.attackSpeed)
//                    print("range: ", champ.stats.range)
//                    print("health: ", champ.stats.health)
//                    print("armor: ", champ.stats.armor)
//                    print("magicResist: ", champ.stats.magicResist)
                    
                }
                self.activityIndicator.stopAnimating()
                self.collectionView.reloadData()
            }
        }
    }
    
    
    //MARK:- Search Controller Code
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredChampions = allChampions
        } else {
            let searchText = searchText.lowercased()
            filteredChampions = allChampions.filter { (champ) -> Bool in
                let nameSearch = champ.name.lowercased().contains(searchText)
                
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
        self.collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredChampions = allChampions
        self.collectionView.reloadData()
    }
    
    //MARK:- Setup Collection View
    func setupCollectionView() {
        collectionView?.register(ChampionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView?.backgroundColor = CustomColor.charcoal
        collectionView.indicatorStyle = .white
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 6, right: 0)
        let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.scrollDirection = .vertical
        layout?.minimumLineSpacing = 6
    }
    
    //MARK: Size For Item At
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let champAbilityText = self.filteredChampions[indexPath.item].ability.abilityDescription
        let heightPad: CGFloat = 121
        let widthPad: CGFloat = 60
        let approxAbilityDescWidth = view.frame.width - widthPad
        let size = CGSize(width: approxAbilityDescWidth, height: 1000)
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11)]
        let estimatedFrame = NSString(string: champAbilityText).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        let setWidth = view.frame.width - 8
        var setHeight = estimatedFrame.height + heightPad
        
        if estimatedFrame.height + heightPad < 120 {
            setHeight = 120
        }
        
        return CGSize(width: setWidth, height: setHeight)
    }
    
    //MARK: Number Of Items In Section
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Should return the number of champions
        return filteredChampions.count
    }
    
    //MARK: Cell For Item At
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChampionCell
        
        cell.classTwoView.isHidden = true
        cell.originTwoView.isHidden = true
        cell.bestItemOne.isHidden = true
        cell.bestItemTwo.isHidden = true
        cell.bestItemThree.isHidden = true
//        cell.bestItemsLabel.isHidden = true
        
        // Configure the cell
        cell.champion = filteredChampions[indexPath.item]
        
        return cell
    }
}
