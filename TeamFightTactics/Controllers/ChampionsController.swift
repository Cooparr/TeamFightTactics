//
//  ChampionsController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 22/07/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class ChampionsController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .whiteLarge)
        view.addSubview(spinner)
        spinner.center = view.center
        spinner.color = CustomColor.romanSilver
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
    
    //MARK:- View Lifecycle
    // View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Champions"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        setupCollectionView()
    }
    
    // View Will Appear
    var champCount: Int?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.allChampions.count == champCount {
            return
        }
        
        activityIndicator.startAnimating()
        DispatchQueue.global().async {
            
            //Simulate loading
//            Thread.sleep(forTimeInterval: isDebug() ? 2 : 0)
            
            self.fetchChampionsAPI { (result) in
                switch result {
                case .success(let champions):
                    
                    champions.values.forEach({ (champ) in
                        self.allChampions.append(champ)
                    })

                    self.allChampions.sort(by: {$0.cost < $1.cost})
                    self.filteredChampions = self.allChampions
                    self.champCount = self.allChampions.count

                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.collectionView.reloadData()
                    }
                    
                case .failure(let err):
                    print("Champions API Failed: ", err)
                }
            }
        }
    }
    
    //MARK:- Fetch Champions API
    var filteredChampions = [ChampionObject]()
    var allChampions = [ChampionObject]()
    fileprivate func fetchChampionsAPI(completion: @escaping (Result<Champions, Error>) -> ()) {
        let urlString = "https://solomid-resources.s3.amazonaws.com/blitz/tft/data/champions.json"
        guard let jsonURL = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: jsonURL) { (data, resp, err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            
            do {
                guard let jsonData = data else { return }
                let champion = try JSONDecoder().decode(Champions.self, from: jsonData)
                completion(.success(champion))
            } catch let jsonErr {
                completion(.failure(jsonErr))
            }
        }.resume()
    }
    
    //MARK:- Search Controller Code
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            filteredChampions = allChampions
        } else {
            filteredChampions = allChampions.filter { (champ) -> Bool in
                return champ.name.lowercased().contains(searchText.lowercased())
            }
        }
        
        self.collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredChampions = allChampions
        self.collectionView.reloadData()
    }
    
    //MARK:- Collection View Code
    let reuseIdentifier = "cellId"
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Should return the number of champions
        return filteredChampions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChampionCell
        
        // Configure the cell
        cell.champion = filteredChampions[indexPath.item]
        
        cell.classTwoView.isHidden = true
        cell.originTwoView.isHidden = true
        cell.bestItemOne.isHidden = true
        cell.bestItemTwo.isHidden = true
        cell.bestItemThree.isHidden = true
        cell.bestItemsLabel.isHidden = true
        
        return cell
    }
}
