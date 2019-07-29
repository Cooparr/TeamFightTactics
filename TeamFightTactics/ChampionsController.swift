//
//  ChampionsController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 22/07/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit
import SDWebImage

class ChampionsController: UIViewController {
    
    let baseURL = "https://ddragon.leagueoflegends.com/cdn/9.13.1/img/champion/"
    let placeholderImage = UIImage(named: "Neeko.png")
    var championsArray = [Champions]()
    
    // View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        navigationItem.title = "Items"
        
        setupView()
        
        fetchChampionsAPI { (res) in
            switch res {
            case .success(let champions):
                
//                print(champions.aatrox.ability)
                print("------------")
//                print(champions.aatrox.ability.abilityDescription)
//                print(champions.aatrox.ability.manaCost ?? -1)
//                print(champions.aatrox.ability.manaStart ?? -1)
//                print(champions.aatrox.ability.name)
//                print(champions.aatrox.ability.self)
//                print(champions.aatrox.ability.stats)
//                print(champions.aatrox.ability.type)
//                print(champions.aatrox.ability.stats[0].value)
//
//
//                print("\n\n")
//
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
        
        championImage.sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.13.1/img/champion/Fizz.png"), placeholderImage: placeholderImage)
    }
    
    // Fetch Champions API
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
                let champions = try JSONDecoder().decode(Champions.self, from: jsonData)
            
//                self.championsArray = try JSONDecoder().decode(Champions.self, from: jsonData)
                
                
                // Main Thread
                DispatchQueue.main.async {
                    self.nameLabel.text = champions.aatrox.name
                }
                
                completion(.success(champions))
                
            } catch let jsonErr {
                completion(.failure(jsonErr))
            }
        }.resume()
    }
    
    
    // Properties
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let championImage: UIImageView = {
        let cI = UIImageView()
        cI.translatesAutoresizingMaskIntoConstraints = false
        return cI
    }()
    
    // Seup View
    fileprivate func setupView() {
        view.addSubview(nameLabel)
        view.addSubview(championImage)
        
        nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        championImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        championImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

