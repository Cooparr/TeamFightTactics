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
    
    //    var championsArray = [Champions]()
    var championsArray = [ChampionObject]()
    var championNames = ["Aatrox", "Shen", "Katarina", "Gnar", "TwistedFate", "RekSai", "Nidalee", "Garen", "Brand", "MissFortune", "Akali", "Mordekaiser", "Vayne", "Draven", "Morgana", "Tristana", "Leona", "AurelionSol", "Kennen", "Gangplank", "Chogath", "Shyvana", "Varus", "Lulu", "Warwick", "Ahri", "Kindred", "Lissandra", "Sejuani", "Lucian", "Blitzcrank", "Evelynn", "Kassadin", "Karthus", "Anivia", "Zed", "Graves", "Ashe", "Elise", "Pyke", "Kayle", "Darius", "Poppy", "Rengar", "Veigar", "Swain", "Braum", "Yasuo", "Fiora", "Volibear", "Khazix"]
    
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Champions"
        
        setupCollectionView()
        
        fetchChampionsAPI { (result) in
            switch result {
            case .success(let champions):
                
                //                self.championsArray = [champions]
                //
                //                self.championsArray.forEach({ (champ) in
                //                    print(champ.mordekaiser)
                //                })
                
                //                // Decoding Champion Object
                champions.forEach({ champ in
                    self.championsArray.append(champ.value)
                })
                print(self.championsArray.count)
                
                print(self.championNames)
                
                //                print(champions.aatrox.name)
                //                print(champions.aatrox.ability)
                //                print(champions.aatrox.ability.abilityDescription)
                //                print(champions.aatrox.ability.manaCost ?? -1)
                //                print(champions.aatrox.ability.manaStart ?? -1)
                //                print(champions.aatrox.ability.name)
                //                print(champions.aatrox.ability.self)
                //                print(champions.aatrox.ability.stats)
                //                print(champions.aatrox.ability.type)
                //                print(champions.aatrox.ability.stats[0].value)
                //                print(champions.aatrox.championClass)
                //                print(champions.aatrox.cost)
                //                print(champions.aatrox.id)
                //                print(champions.aatrox.items)
                //                print(champions.aatrox.key)
                //                print(champions.aatrox.name)
                //                print(champions.aatrox.origin)
                //                print(champions.aatrox.self)
                //                print(champions.aatrox.stats)
                
            case .failure(let err):
                print("Champions API Failed: ", err)
            }
        }
    }
    
    
    // Fetch Champions API
    fileprivate func fetchChampionsAPI(completion: @escaping (Result<[String:ChampionObject], Error>) -> ()) {
        //    fileprivate func fetchChampionsAPI(completion: @escaping (Result<Champions, Error>) -> ()) {
        let urlString = "https://solomid-resources.s3.amazonaws.com/blitz/tft/data/champions.json"
        guard let jsonURL = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: jsonURL) { (data, resp, err) in
            
            if let err = err {
                completion(.failure(err))
                return
            }
            
            do {
                guard let jsonData = data else { return }
                
                let champions = try JSONDecoder().decode([String:ChampionObject].self, from: jsonData)
                //                let champions = try JSONDecoder().decode(Champions.self, from: jsonData)
                
                //                self.championsArray = try JSONDecoder().decode(Champions.self, from: jsonData)
                
                // Main Thread
                //                DispatchQueue.main.async {
                //                    print(self.championsArray)
                //                    self.nameLabel.text = champions.aatrox.name
                //                }
                
                completion(.success(champions))
                
            } catch let jsonErr {
                completion(.failure(jsonErr))
            }
            }.resume()
    }
    
    //MARK: Collection View Code
    
    func setupCollectionView() {
        collectionView?.register(ChampionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.backgroundColor = .white
        let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.scrollDirection = .vertical
        layout?.minimumLineSpacing = 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let setWidth = collectionView.frame.width - 8
        let setHeight: CGFloat = 96
        return CGSize(width: setWidth, height: setHeight)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Should return the number of champions
        return 51
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChampionCell
        
        // Configure the cell
        cell.backgroundColor = .red
        
        return cell
    }
}
