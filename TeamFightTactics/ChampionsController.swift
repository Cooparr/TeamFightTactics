//
//  ChampionsController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 22/07/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class ChampionsController: UIViewController {
    
    // View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        navigationItem.title = "Items"
        
        setupView()
        
        fetchChampionsAPI { (res) in
            switch res {
            case .success(let champions):
                print("///")
                print(champions.mordekaiser.ability)
                print("///")
                print(champions.morgana.ability)
            case .failure(let err):
                print("Champions API Failed: ", err)
            }
        }
        
        

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
    
    
    // View Components
    lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    // Seup View
    fileprivate func setupView() {
        view.addSubview(nameLabel)
        
        nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

