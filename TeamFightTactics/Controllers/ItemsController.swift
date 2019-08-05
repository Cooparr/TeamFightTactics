//
//  ItemsController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 22/07/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class ItemsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = CustomColor.charcoal
        navigationItem.title = "Items"
        
        
        
        fetchItemsAPI { (res) in
            switch res {
            case .success(let items):
                
                guard let tester = items["forceofnature"] else { break }
                print(tester)
                
//                items.forEach({ (item) in
//                    print(item.value)
//                })
                
            case .failure(let err):
                print("Items API Failed: ", err)
            }
        }
    }
    
    
    // Fetch Items API
    fileprivate func fetchItemsAPI(completion: @escaping (Result<Items, Error>) -> ()) {
        let urlString = "https://solomid-resources.s3.amazonaws.com/blitz/tft/data/items.json"
        guard let jsonURL = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: jsonURL) { (data, resp, err) in
            
            if let err = err {
                completion(.failure(err))
                return
            }
            
            do {
                guard let jsonData = data else { return }
                let items = try JSONDecoder().decode(Items.self, from: jsonData)
                completion(.success(items))
                
            } catch let jsonErr {
                completion(.failure(jsonErr))
            }
        }.resume()
    }
}

