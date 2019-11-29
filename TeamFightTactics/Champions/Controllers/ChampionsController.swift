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
    let cellId = "cellId"
    let headerId = "headerId"
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(testing))
        
        setupCollectionView()
    }
    
    @objc func testing() {
        let alertController = UIAlertController(title: "Did you know?", message: "You can tap a champion to view their 2-Star and 3-Star base stats!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cool!", style: .cancel))
        present(alertController, animated: true)
    }
    
    
    //MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        if champCount != allChampions.count {
            activityIndicator.startAnimating()
            performSelector(inBackground: #selector(getChampionsDataFromFireStore), with: nil)
        }
    }
    
    
    //MARK:- Get Champion Data
    @objc fileprivate func getChampionsDataFromFireStore() {
        self.allChampions.removeAll()
        
        FirestoreManager.DevSetOneChamps.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents:", err)
            } else if let querySnapshot = querySnapshot {
                for document in querySnapshot.documents {
                    let champ = Champion(data: document.data())
                    self.allChampions.append(champ)
                }
                self.allChampions.sort(by: {$1.cost < $0.cost})
                self.filteredChampions = self.allChampions
                self.champCount = self.allChampions.count
            }
            
            DispatchQueue.main.async {
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
        collectionView.register(ChampionCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(ChampionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = CustomColor.charcoal
        collectionView.indicatorStyle = .white
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
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
        return filteredChampions.count
    }
    
    //MARK: Cell For Item At
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChampionCell
        cell.champion = filteredChampions[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ChampionCell else { return }
        let statBaseValues = [allChampions[indexPath.item].stats.health, allChampions[indexPath.item].stats.attackDamage]
        let statLabels = [cell.champHealth, cell.champAttackDamage]
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
    
//    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let header  = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! ChampionHeader
//        return header
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: view.frame.width, height: 50)
//    }
}
