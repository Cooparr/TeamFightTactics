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
    var champion: Champions?
    var championsArray = [Champions]()
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Champions"
        
        fetchChampionsAPI { (result) in
            switch result {
            case .success(let champions):
                
                print("Wow")
                
//                // Should print each champ object individually
//                champions.forEach({ champ in
//                    self.championsArray.append([champ.key: champ.value])
//                })
                
//                champions.values.forEach({ (champ) in
//                    print(champ.name)
//
//                })
//
//                champions.forEach({ (champ) in
//                    self.championsArray.append([champ.key: champ.value])
//                })
                
                
                
                
            case .failure(let err):
                print("Champions API Failed: ", err)
            }
        }
        
        setupCollectionView()
    }
    
    
    // Fetch Champions API
    fileprivate func fetchChampionsAPI(completion: @escaping (Result<Champions, Error>) -> ()) {
        //        let urlString = "https://solomid-resources.s3.amazonaws.com/blitz/tft/data/champions.json"
        let urlString = "https://api.myjson.com/bins/dsfph"
        guard let jsonURL = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: jsonURL) { (data, resp, err) in
            
            if let err = err {
                completion(.failure(err))
                return
            }
            
            do {
                guard let jsonData = data else { return }
                
                self.champion = try JSONDecoder().decode(Champions.self, from: jsonData)
//                self.championsArray = try JSONDecoder().decode(Champions.self, from: jsonData)
                
                if let champion = self.champion {
                    completion(.success(champion))
                }
                
                
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
        let setWidth = collectionView.frame.width - 8
        let setHeight: CGFloat = 130
        return CGSize(width: setWidth, height: setHeight)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Should return the number of champions
        return 51
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChampionCell
        
        // Configure the cell
        cell.champion = self.champion
        
//        print(championsArray.count)
        
        if let champion = champion {
            champion.values.forEach({ (champ) in
                cell.champName.text = champ.name
            })
        }
       
        
        
//        championsArray.forEach { (champion) in
//            champion.values.forEach({ (champ) in
//                print(champ.name)
//            })
//        }
//
//
//        champion?.forEach({ (key, value) in
//            cell.champName.text = value.name
//        })
//
//
//        champion?.values.forEach({ (champ) in
//            cell.champName.text = champ.name
//        })
        
        return cell
    }
}
