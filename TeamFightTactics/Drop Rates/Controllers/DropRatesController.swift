//
//  DropRatesController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 13/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class DropRatesController: UIViewController {
    
    //MARK:- Properties
    private let dropRatesView = DropRatesView()
    
    var dropRateChance = [[String]]()
    var dropRates = [DropRate]() {
        didSet {
            updateDropRateDataArrays()
            dropRatesView.collectionView.reloadData()
            managePoolViews()
        }
    }
    
    
    //MARK:- Load View
    override func loadView() {
        super.loadView()
        self.view = dropRatesView
    }
    
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarSetup()
        assignCollectionViewDelegates()
    }
    
    
    //MARK:- Assign Collection View Delegates
    fileprivate func assignCollectionViewDelegates() {
        dropRatesView.collectionView.delegate = self
        dropRatesView.collectionView.dataSource = self
    }

    
    //MARK:- Update Drop Rate Data Arrays
    fileprivate func updateDropRateDataArrays() {
        dropRateChance.removeAll()
        dropRates.forEach { (dropRate) in
            let lvOne = dropRate.levelDict.one
            let lvTwo = dropRate.levelDict.two
            let lvThree = dropRate.levelDict.three
            let lvFour = dropRate.levelDict.four
            let lvFive = dropRate.levelDict.five
            let lvSix = dropRate.levelDict.six
            let lvSeven = dropRate.levelDict.seven
            let lvEight = dropRate.levelDict.eight
            let lvNine = dropRate.levelDict.nine

            let levelValues = [lvOne, lvTwo, lvThree, lvFour, lvFive, lvSix, lvSeven, lvEight, lvNine]
            dropRateChance.append(levelValues)
        } 
    }
    
    
    //MARK:- Manage Pool Views
    fileprivate func managePoolViews() {
        for (index, dropRate) in dropRates.enumerated() {
            let poolValue = String(dropRate.poolValue)
            if dropRatesView.totalChampPoolStack.arrangedSubviews.count != dropRates.count {
                dropRatesView.createPoolView(dropRate, index, poolValue)
            } else {
                dropRatesView.updatePoolValue(index, poolValue)
            }
        }
    }
    
    
    //MARK:- Navigation Bar Code
    fileprivate func navigationBarSetup() {
        navigationItem.title = "Drop Rates"
        rightNavBarSettingsButton()
    }
}


// MARK:- CollectionView Data Source
extension DropRatesController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dropRateChance.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseId.dropRateCell, for: indexPath) as! DropRateCell
        
        let playerLevel = indexPath.section
        let champTier = indexPath.item
        cell.dropRateValue.text = dropRateChance[champTier][playerLevel]
        
        return cell
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dropRateChance[0].count
    }
    
}


//MARK:- CollectionView Delegate Flow Layout
extension DropRatesController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 5, height: collectionView.frame.height / 9)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


