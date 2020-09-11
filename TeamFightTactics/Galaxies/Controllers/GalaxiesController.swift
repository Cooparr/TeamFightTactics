//
//  GalaxiesController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 09/09/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class GalaxiesController: UIViewController {

    //MARK:- Properties
    private let galaxiesView = GalaxiesView()
    var galaxies = [Galaxy]() {
        didSet {
            galaxiesView.collectionView.reloadData()
        }
    }
    
    
    //MARK:- Load View
    override func loadView() {
        super.loadView()
        self.view = galaxiesView
    }
    
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar(navTitle: "Galaxies", showSettingsButton: false)
        galaxiesView.collectionView.delegate = self
        galaxiesView.collectionView.dataSource = self
    }
    
    
    //MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.integer(forKey: UDKey.setKey) != 3 {
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            fetchGalaxies()
        }
    }
    
    
    //MARK: Fetch Items
    fileprivate func fetchGalaxies() {
        let firestore = FirestoreManager()
        firestore.fetchSetData(from: .galaxies, updateKey: .galaxies) { (galaxies: [Galaxy]) in
            self.galaxies = galaxies.sorted(by: { !$0.removed && $1.removed })
        }
    }
    
}

//MARK:- CollectionView Datasource
extension GalaxiesController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galaxies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(GalaxyCell.self, for: indexPath)
        cell.configureCell(with: galaxies[indexPath.item])
        return cell
    }
}
