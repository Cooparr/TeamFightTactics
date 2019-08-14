//
//  ChampionsController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 22/07/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class ChampionsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let reuseIdentifier = "cellId"
    var championsArray = [ChampionObject]()
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Champions"
        
        fetchChampionsAPI { (result) in
            switch result {
            case .success(let champions):

                champions.values.forEach({ (value) in
                    self.championsArray.append(value)
                })
  
            case .failure(let err):
                print("Champions API Failed: ", err)
            }
        }
        
        setupCollectionView()
    }
    
    
    // Fetch Champions API
    fileprivate func fetchChampionsAPI(completion: @escaping (Result<Champions, Error>) -> ()) {
//                let urlString = "https://solomid-resources.s3.amazonaws.com/blitz/tft/data/champions.json"
        let urlString = "https://api.myjson.com/bins/1dazsv"
        guard let jsonURL = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: jsonURL) { (data, resp, err) in
            
            if let err = err {
                completion(.failure(err))
                return
            }
            
            do {
                guard let jsonData = data else { return }
                
                let champion = try JSONDecoder().decode(Champions.self, from: jsonData)
//                self.championsArray = try JSONDecoder().decode(Champions.self, from: jsonData)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                completion(.success(champion))
                
                
            } catch let jsonErr {
                completion(.failure(jsonErr))
            }
            }.resume()
    }
    
    //MARK: Collection View Code
    func setupCollectionView() {
        collectionView?.register(ChampionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.backgroundColor = CustomColor.charcoal
        collectionView.indicatorStyle = .white
        let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.scrollDirection = .vertical
        layout?.minimumLineSpacing = 6
        collectionView.contentInset = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let setWidth = view.frame.width - 8
        let setHeight: CGFloat = 134
        return CGSize(width: setWidth, height: setHeight)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Should return the number of champions
        return championsArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChampionCell
        
        // Configure the cell
        cell.champion = championsArray[indexPath.item]

        
        return cell
    }
}
