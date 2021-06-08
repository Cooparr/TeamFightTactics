//
//  CreateTeamCompChampItemCollectionVC.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 12/02/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

protocol SelectionVCDelegate: AnyObject {
    func shouldAddChampToTeamComp(champSelected: Champion) -> Bool
    func champSelected(addChampToTeamComp champ: Champion)
    func itemSelected(addItemToChampion itemName: String)
}

protocol TraitsControllerDelegate: AnyObject {
    func traitsController(updateCollectionView withChampTraits: [String: Int])
}

protocol CreateTCTraitsDelegate: AnyObject {
    func createTraitCountDictionary() -> [String: Int]
}


class ChampItemSelectionVC: UIViewController {
    
    //MARK: Properties
    weak var selectionVCDelegate: SelectionVCDelegate?
    weak var traitControllerDelegate: TraitsControllerDelegate?
    weak var createTCTraitsDelegate: CreateTCTraitsDelegate!
    
    private var currentlyDisplaying: CurrentlyDisplaying = .champions
    private var sortingBy: SortBy = .cost
    private let champItemSelectionView = ChampItemSelectionView()
    
    private var allChampions = [Champion]()
    private var dataSourceChampions = [[Champion]]()

    private var allItems = [Item]()
    private var dataSourceItems = [[Item]]()

    private var costsForSectionHeader = [Cost]()
    
    
    //MARK: Currently Displaying
    enum CurrentlyDisplaying {
        case items
        case champions
    }
    
    
    //MARK: Sort By Enum
    enum SortBy: Int {
        case name = 1
        case cost = 2
        case tier = 3
    }
    
    
    //MARK: Load View
    override func loadView() {
        super.loadView()
        self.view = champItemSelectionView
    }
    
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        assignCollectionViewDelegates()
        fetchAllChampionsAndItems()
    }

    //MARK: Assign Collection View Delegates
    private func assignCollectionViewDelegates() {
        champItemSelectionView.collectionView.delegate = self
        champItemSelectionView.collectionView.dataSource = self
    }
    
    
    //MARK: Fetch All Traits
    private func fetchAllChampionsAndItems() {
        let firestore = FirestoreManager()
        firestore.fetchSetData(from: .champions, updateKey: .champs) { [weak self] (champions: [Champion]) in
            guard let self = self else { return }
            self.allChampions = champions.sorted { $0.name < $1.name }
            self.dataSourceChampions = self.populateDataSourceChampionsByCost()
            self.champItemSelectionView.collectionView.reloadDataOnMainThread()
            
        }
        
        firestore.fetchSetData(from: .items, updateKey: .items) { [weak self] (items: [Item]) in
            self?.allItems = items.sorted { $0.name < $1.name }
        }
    }
    
    
    //MARK: Populate Datasource Array By Cost Name or Tier
    private func populateDataSourceArraysByNameOrTier<T: TierRated>(sourceArray: [T], sortByProperty: SortBy) -> [[T]] {
        var dataSourceArray = [[T]]()
        switch sortingBy {
        case .name:
            dataSourceArray = [sourceArray]
        case .cost:
            break
        case .tier:
            for section in 1...TierRating.allCases.count {
                let tierArray = sourceArray.filter { $0.tier.rawValue == section }
                guard !tierArray.isEmpty else { continue }
                dataSourceArray.append(tierArray)
            }
        }
        
        return dataSourceArray
    }
    
    
    //MARK: Populate Champ Datasource Array By Cost
    private func populateDataSourceChampionsByCost() -> [[Champion]] {
        var tempArray = [[Champion]]()
        for costSection in 1...Cost.allCases.count {
            let champions = allChampions.filter { $0.cost.rawValue == costSection }
            guard !champions.isEmpty else { continue }
            tempArray.append(champions)
            
            let champCostForSection = champions[0].cost
            if !costsForSectionHeader.contains(champCostForSection) {
                costsForSectionHeader.append(champCostForSection)
            }
        }
        return tempArray
    }
    
    
    //MARK: Toggle ColView Action
    @objc func toggleColViewAction(_ sender: UIButton) {
        sender.pulseAnimateOnTap()
        let firstCellIndexPath = IndexPath(item: 0, section: 0)
        champItemSelectionView.collectionView.scrollToItem(at: firstCellIndexPath, at: .centeredHorizontally, animated: true)
        
        switch currentlyDisplaying {
        case .items:
            collectionViewDisplayChampions()
        case .champions:
            collectionViewDisplayItems()
        }
    }
    
    
    //MARK: Sort By Button Action
    @objc func sortByButtonAction(_ sender: UIButton) {
        sender.pulseAnimateOnTap()
        
        guard let selectedSortBy = SortBy(rawValue: sender.tag) else {
            presentErrorAlertOnMainThread(title: "Error Sorting", message: "Couldn't sort via \(sender.titleLabel?.text ?? "selected option"). Please try again.", buttonTitle: "Okay")
            return
        }
        
        sortingBy = selectedSortBy
        champItemSelectionView.updateSelectedStateOfSortButton(tappedButton: sender)
        
        switch currentlyDisplaying {
        case .items:
            dataSourceItems = populateDataSourceArraysByNameOrTier(sourceArray: allItems, sortByProperty: selectedSortBy)
        case .champions:
            dataSourceChampions = sortingBy == .cost ? populateDataSourceChampionsByCost() : populateDataSourceArraysByNameOrTier(sourceArray: allChampions, sortByProperty: selectedSortBy)
        }
        
        
        champItemSelectionView.collectionView.reloadDataOnMainThread()
    }
}

//MARK: Create Team Comp VC Delegate
extension ChampItemSelectionVC: CreateTeamCompVCDelegate {
    
    //MARK: ColView Display Items
    func collectionViewDisplayItems() {
        guard currentlyDisplaying == .champions else { return }
        currentlyDisplaying = .items
        
        if sortingBy == .cost {
            sortingBy = .tier
            champItemSelectionView.updateSelectedStateOfSortButton(tappedButton: champItemSelectionView.sortByTierBtn)
            dataSourceItems = populateDataSourceArraysByNameOrTier(sourceArray: allItems, sortByProperty: .tier)
        }
        
        dataSourceItems = populateDataSourceArraysByNameOrTier(sourceArray: allItems, sortByProperty: sortingBy)
        
        champItemSelectionView.updateButtonsDependingOn(isShowingItems: true)
        champItemSelectionView.collectionView.reloadDataOnMainThread()
    }
    
    
    //MARK: ColView Display Champions
    func collectionViewDisplayChampions() {
        guard currentlyDisplaying == .items else { return }
        currentlyDisplaying = .champions
        
        dataSourceChampions = populateDataSourceArraysByNameOrTier(sourceArray: allChampions, sortByProperty: sortingBy)
        champItemSelectionView.updateButtonsDependingOn(isShowingItems: false)
        champItemSelectionView.collectionView.reloadDataOnMainThread()
    }
}


//MARK:- Collection View Delegates
extension ChampItemSelectionVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize(width: 40, height: 40) }
        
        let numberOfCellsForEachColumn: CGFloat = 3
        let champNameLabelHeightCompensation: CGFloat = 15
        let topInset = flowLayout.sectionInset.top
        let bottomInset = flowLayout.sectionInset.bottom
        let itemSpacing = flowLayout.minimumInteritemSpacing * (numberOfCellsForEachColumn - 1)
        let totalPadding = topInset + bottomInset + itemSpacing + (champNameLabelHeightCompensation * numberOfCellsForEachColumn)
        let sizeForEachItem = (collectionView.bounds.height - totalPadding)  / numberOfCellsForEachColumn
        
        return CGSize(width: sizeForEachItem, height: sizeForEachItem + champNameLabelHeightCompensation)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch currentlyDisplaying {
        case .items:
            return dataSourceItems.count
        case .champions:
            return dataSourceChampions.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch currentlyDisplaying {
        case .items:
            return dataSourceItems[section].count
        case .champions:
            return dataSourceChampions[section].count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let headerWidth: CGFloat = sortingBy == .name ? 0 : 44
        return CGSize(width: headerWidth, height: collectionView.frame.width)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SelectionColViewSectionHeader.reuseId, for: indexPath) as! SelectionColViewSectionHeader
            sectionHeader.configureSectionHeader(sortingBy: sortingBy, sectionIndex: indexPath.section, costValues: costsForSectionHeader)
            return sectionHeader
        } else {
            return UICollectionReusableView()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch currentlyDisplaying {
        case .items:
            let cell = collectionView.dequeueReusableCell(ItemSelectionCell.self, for: indexPath)
            cell.configureCell(with: dataSourceItems[indexPath.section][indexPath.item])
            return cell
            
        case .champions:
            let cell = collectionView.dequeueReusableCell(ChampionSelectionCell.self, for: indexPath)
            cell.configureCell(with: dataSourceChampions[indexPath.section][indexPath.item])
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch currentlyDisplaying {
        case .items:
            let itemName = dataSourceItems[indexPath.section][indexPath.item].name.formattedName()
            selectionVCDelegate?.itemSelected(addItemToChampion: itemName)
        case .champions:
            let champToAdd = dataSourceChampions[indexPath.section][indexPath.item]
            if selectionVCDelegate?.shouldAddChampToTeamComp(champSelected: champToAdd) ?? false {
                selectionVCDelegate?.champSelected(addChampToTeamComp: champToAdd)
                let traitCountDictionary = createTCTraitsDelegate.createTraitCountDictionary()
                traitControllerDelegate?.traitsController(updateCollectionView: traitCountDictionary)
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? BaseColViewCell else { return }
        cell.pulseAnimateOnTap()
    }
}
