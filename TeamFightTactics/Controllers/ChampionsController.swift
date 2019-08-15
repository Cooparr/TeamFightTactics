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
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
  
            case .failure(let err):
                print("Champions API Failed: ", err)
            }
        }
        
        setupCollectionView()
    }
    
    
    // Fetch Champions API
    fileprivate func fetchChampionsAPI(completion: @escaping (Result<Champions, Error>) -> ()) {
                let urlString = "https://solomid-resources.s3.amazonaws.com/blitz/tft/data/champions.json"
//        let urlString = "https://api.myjson.com/bins/1dazsv"
        guard let jsonURL = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: jsonURL) { (data, resp, err) in
            
            if let err = err {
                completion(.failure(err))
                return
            }
            
            do {
                guard let jsonData = data else { return }
//                self.championsArray = try JSONDecoder().decode(Champions.self, from: jsonData)
                let champion = try JSONDecoder().decode(Champions.self, from: jsonData)
                
                completion(.success(champion))
                
            } catch let jsonErr {
                completion(.failure(jsonErr))
            }
        }.resume()
    }
    
    //MARK: Collection View Code
    func setupCollectionView() {
        collectionView?.register(ChampionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView?.backgroundColor = CustomColor.charcoal
        collectionView.indicatorStyle = .white
        let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.scrollDirection = .vertical
        layout?.minimumLineSpacing = 6
        collectionView.contentInset = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let champAbilityText = self.championsArray[indexPath.item].ability.abilityDescription
        let heightPad: CGFloat = 84
        let widthPad: CGFloat = 97
        let approxAbilityDescWidth = view.frame.width - widthPad
        let size = CGSize(width: approxAbilityDescWidth, height: 1000)
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)]
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
        return championsArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChampionCell

        // Configure the cell
        cell.champion = championsArray[indexPath.item]
        
        return cell
    }
}
