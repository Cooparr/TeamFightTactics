//
//  CreateTeamCompTraitsVC.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 11/02/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class CreateTeamCompTraitsVC: UICollectionViewController {
    
    //MARK: Properties
    private let traitsColViewHeight: CGFloat = 25
    private(set) var allTraits = [Trait]()
    var traitsToDisplay = [Trait]()


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
        
        let displayedSet = UserDefaults.standard.double(forKey: UDKey.setKey)
        collectionView.allowsSelection = (TFTSet.four.rawValue...TFTSet.four_5.rawValue).contains(displayedSet) ? true : false
    }
    
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllTraits()
    }
    
    
    //MARK: Fetch All Traits
    private func fetchAllTraits() {
        let firestore = FirestoreManager()
        firestore.fetchSetData(from: .classes, updateKey: .classes) { [weak self] (classes: [Trait]) in
            firestore.fetchSetData(from: .origins, updateKey: .origins) { (origins: [Trait]) in
                guard let self = self else { return }
                self.allTraits = classes + origins
            }
        }
    }
    
    
    //MARK: Sort Display Traits
    private func sortDisplayTraitsByRankThenCount() {
        traitsToDisplay.sort { traitOne, traitTwo in
            if traitOne.rank.rawValue == traitTwo.rank.rawValue { return traitOne.count > traitTwo.count }
            return traitOne.rank.rawValue > traitTwo.rank.rawValue
        }
    }
    
    
    //MARK: Update Chosen State Of Trait
    private func updateChosenStateOfTrait(at indexPath: IndexPath) {
        let trait = traitsToDisplay[indexPath.item]
        guard trait.canBeChoosen() else {
            presentErrorAlertOnMainThread(title: "Unavailable", message: "\(trait.name) cannot be a chosen trait.")
            return
        }
        
        
        switch trait.isChosen {
        case true:
            traitsToDisplay[indexPath.item].removeChosenBuff()
        case false:
            if let existingChosenTraitIndex = traitsToDisplay.firstIndex(where: { $0.isChosen }) {
                traitsToDisplay[existingChosenTraitIndex].removeChosenBuff()
            }
            
            traitsToDisplay[indexPath.item].addChosenBuff()
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: Selected Team Comp Delegate
extension CreateTeamCompTraitsVC: SelectedTeamCompDelegate {
    
    func selectedTeamComp(removeTraitsFor champion: Champion) {
        let traitsToRemove = champion.classes + champion.origins

        for (index, trait) in traitsToDisplay.enumerated().reversed() where traitsToRemove.contains(trait.name) {
            let newTraitCount = trait.count - 1

            if newTraitCount == 0 || newTraitCount == 1 && trait.isChosen {
                traitsToDisplay.remove(at: index)
            } else {
                traitsToDisplay[index].count = newTraitCount
                traitsToDisplay[index].setTraitRank(traitCount: newTraitCount)
            }

            sortDisplayTraitsByRankThenCount()
            collectionView.reloadDataOnMainThread()
        }
    }
}


//MARK: Traits Controller Delegate
extension CreateTeamCompTraitsVC: TraitsControllerDelegate {
    
    func traitsController(updateCollectionView withChampTraits: [String : Int]) {
        for trait in withChampTraits {
            let traitName = trait.key
            let traitCount = trait.value
                                
            if traitsToDisplay.contains( where: { $0.name == traitName }) {
                guard let index = traitsToDisplay.firstIndex(where: { $0.name == traitName }) else { return }
                traitsToDisplay[index].updateTrait(newCount: traitCount)
            } else {
                guard var foundTrait = allTraits.first(where: { $0.name == traitName }) else { return }
                foundTrait.updateTrait(newCount: traitCount)
                traitsToDisplay.append(foundTrait)
            }
        }
        
        sortDisplayTraitsByRankThenCount()
        collectionView.reloadDataOnMainThread()
    }
}


//MARK:- Collection View Delegates
extension CreateTeamCompTraitsVC: UICollectionViewDelegateFlowLayout {
    
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
        updateChosenStateOfTrait(at: indexPath)
        sortDisplayTraitsByRankThenCount()
        collectionView.reloadDataOnMainThread()
    }
}
