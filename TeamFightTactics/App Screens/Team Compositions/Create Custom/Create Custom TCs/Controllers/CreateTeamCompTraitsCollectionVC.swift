//
//  CreateTeamCompTraitsCollectionVC.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 11/02/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class CreateTeamCompTraitsCollectionVC: UICollectionViewController {
    
    //MARK: Properties
    var allTraits = [Trait]()
    var traitsToDisplay = [Trait]()
    let traitsColViewHeight: CGFloat = 25
    
    
    //MARK: Init
    override init(collectionViewLayout layout: UICollectionViewLayout = UICollectionViewFlowLayout()) {
        super.init(collectionViewLayout: layout)

        guard let layout = layout as? UICollectionViewFlowLayout else { return }
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        
        collectionView.register(CreateTeamCompTraitCell.self, forCellWithReuseIdentifier: CreateTeamCompTraitCell.reuseId)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = ThemeColor.richBlack
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllTraits()
    }
    
    
    //MARK: Fetch All Traits
    fileprivate func fetchAllTraits() {
        let firestore = FirestoreManager()
        firestore.fetchSetData(from: .classes, updateKey: .classes) { [weak self] (classes: [Trait]) in
            firestore.fetchSetData(from: .origins, updateKey: .origins) { (origins: [Trait]) in
                guard let self = self else { return }
                self.allTraits = classes + origins
            }
        }
    }
    
    
    //MARK: Sort Display Traits
    func sortDisplayTraitsByRankThenCount() {
        traitsToDisplay.sort { traitOne, traitTwo in
            if traitOne.rank.rawValue == traitTwo.rank.rawValue { return traitOne.count > traitTwo.count }
            return traitOne.rank.rawValue > traitTwo.rank.rawValue
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK:- Collection View Delegates
extension CreateTeamCompTraitsCollectionVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let trait = traitsToDisplay[indexPath.row]
        let labelWidth = trait.name.size(withAttributes: [
            NSAttributedString.Key.font : UIFont.preferredFont(forTextStyle: .callout)
        ]).width
        
        return CGSize(width: labelWidth + 55, height: traitsColViewHeight)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return traitsToDisplay.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CreateTeamCompTraitCell.self, for: indexPath)
        cell.configureCell(with: traitsToDisplay[indexPath.item])
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let displayedSet = UserDefaults.standard.double(forKey: UDKey.setKey)
        if displayedSet < TFTSet.four.rawValue { return }
        
        switch traitsToDisplay[indexPath.item].isChosen {
        case true:
            traitsToDisplay[indexPath.item].removeChosenBuff()
            
        case false:
            if let existingChosenTraitIndex = traitsToDisplay.firstIndex(where: { $0.isChosen }) {
                traitsToDisplay[existingChosenTraitIndex].removeChosenBuff()
            }
            
            traitsToDisplay[indexPath.item].addChosenBuff()
        }
        
        sortDisplayTraitsByRankThenCount()
        collectionView.reloadDataOnMainThread()
    }
}
