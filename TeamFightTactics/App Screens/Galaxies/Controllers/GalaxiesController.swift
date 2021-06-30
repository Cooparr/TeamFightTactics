//
//  GalaxiesController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 09/09/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit
import FirebaseFirestore

class GalaxiesController: UIViewController {

    //MARK:- Properties
    private let galaxiesView = GalaxiesView()
    private var galaxies = [Galaxy]()
    
    
    //MARK: Firebase Listeners
    private var galaxiesListener: ListenerRegistration?
    
    
    //MARK:- Load View
    override func loadView() {
        super.loadView()
        self.view = galaxiesView
    }
    
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar(navTitle: .galaxies, showSettingsButton: false)
        assignDelegates()
    }
    
    
    //MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.double(forKey: UDKey.setKey) != 3.0 {
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            fetchGalaxies()
        }
    }
    
    
    //MARK: View Will Disappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        galaxiesListener?.remove()
    }
    
    
    //MARK: Fetch Items
    private func fetchGalaxies() {
        galaxiesListener = SetDataManager().fetchData(from: .galaxies) { (galaxiesResult: Result<[Galaxy], Error>) in
            switch galaxiesResult {
            case .success(let galaxies):
                self.galaxies = galaxies.sorted { !$0.removed && $1.removed }
                self.galaxiesView.collectionView.reloadDataOnMainThread()
            case .failure(let error):
                self.presentErrorAlertOnMainThread(title: "Error Fetching Galaxies", message: error.localizedDescription)
            }
        }
    }
    
    
    //MARK:- Assign Collection View Delegates
    private func assignDelegates() {
        galaxiesView.collectionView.delegate = self
        galaxiesView.collectionView.dataSource = self
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
