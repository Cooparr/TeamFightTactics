//
//  CreateTeamCompChampItemCollectionVC.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 12/02/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class ChampItemSelectionVC: UIViewController, CreateTeamCompVCDelegate {
    
    //MARK: Sort By Enum
    enum SortBy: Int {
        case name = 1
        case cost = 2
        case tier = 3
    }
    
    
    //MARK: Properties
    private var sortingBy: SortBy = .cost
    private let champItemSelectionView = ChampItemSelectionView()
    private var allChampions = [Champion]()
    private var dataSourceChampions = [[Champion]]()
    
    private var showingItems = false
    private var items = [Item]()
    
    private var costsForSectionHeader = [Cost]()
    

    
    //MARK: Load View
    override func loadView() {
        super.loadView()
        self.view = champItemSelectionView
    }
    
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        champItemSelectionView.collectionView.delegate = self
        champItemSelectionView.collectionView.dataSource = self
        
        fetchAllChampsAndItems()
    }

    
    //MARK: Fetch All Traits
    fileprivate func fetchAllChampsAndItems() {
        let firestore = FirestoreManager()
        firestore.fetchSetData(from: .champions, updateKey: .champs) { [weak self] (champions: [Champion]) in
            firestore.fetchSetData(from: .items, updateKey: .items) { (items: [Item]) in
                guard let self = self else { return }
                self.allChampions = champions
                self.configureDataSourceArrayWith(champions: champions, filteredBy: .cost, numberOfSections: Cost.allCases.count)
                
                self.items = items
                self.champItemSelectionView.collectionView.reloadDataOnMainThread()
            }
        }
    }
    
    
    //MARK: Configure Data Source Array
    func configureDataSourceArrayWith(champions: [Champion], filteredBy champProperty: SortBy, numberOfSections: Int) {
        dataSourceChampions.removeAll()
        
        for section in 1...numberOfSections {
            var champs: [Champion] {
                switch champProperty {
                case .name:
                    return champions
                case .cost:
                    return champions.filter({ $0.cost.rawValue == section })
                case .tier:
                    return champions.filter({ $0.tier.rawValue == section })
                }
            }
            
            if !champs.isEmpty {
                dataSourceChampions.append(champs)
                for champ in champs where !costsForSectionHeader.contains(champ.cost) {
                    costsForSectionHeader.append(champ.cost)
                }
            }
        }
    }
    
    
    //MARK: Should Add Champ To Team Comp Check
    fileprivate func shouldAddChampToTeamComp(_ champToAdd: Champion, _ parentVC: CreateTeamCompVC) -> Bool {
        let sizeOfTeamComp = parentVC.selectedTeamCompVC.selectedChampsForTeamComp.count + 1
        let champOccurenceCount = parentVC.selectedTeamCompVC.selectedChampsForTeamComp.filter { $0 == champToAdd }.count

        if sizeOfTeamComp > CreateTeamCompVC.maxTeamCompSize {
            presentErrorAlertOnMainThread(title: "Team Comp Limit",
                                          message: "The maximum size of a team comp is \(CreateTeamCompVC.maxTeamCompSize)",
                                          buttonTitle: "Okay")
        }
        
        if champOccurenceCount == CreateTeamCompVC.numOfChampOccurencesPerTeamComp {
            presentErrorAlertOnMainThread(title: "Champion Limit",
                                          message: "A champion can only occur in the same team comp twice.",
                                          buttonTitle: "Okay")
        }
        
        return sizeOfTeamComp <= CreateTeamCompVC.maxTeamCompSize && champOccurenceCount < CreateTeamCompVC.numOfChampOccurencesPerTeamComp
    }
    
    
    //MARK: Add Champ To Team Comp
    fileprivate func addChampionToTeamComp(_ champToAdd: Champion, _ parentVC: CreateTeamCompVC) {
        parentVC.selectedTeamCompVC.selectedChampsForTeamComp.append(champToAdd)
        
        guard let lastIndex = parentVC.selectedTeamCompVC.selectedChampsForTeamComp.lastIndex(of: champToAdd) else { return }
        let lastIndexPath = IndexPath(row: lastIndex, section: 0)
        parentVC.selectedTeamCompVC.tableView.insertRowsWithUpdates(at: [lastIndexPath])
        parentVC.selectedTeamCompVC.tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
    }
    
    
    //MARK: Update Traits Bar With New Champ Traits
    fileprivate func updateTraitsColViewWithChampTraits(_ parentVC: CreateTeamCompVC) {
        for trait in parentVC.selectedTeamCompVC.createDictionaryOfTraitNameAndCount() {
            let traitName = trait.key
            let traitCount = trait.value
                                
            if parentVC.traitsController.traitsToDisplay.contains( where: { $0.name == traitName }) {
                guard let index = parentVC.traitsController.traitsToDisplay.firstIndex(where: { $0.name == traitName }) else { return }
                parentVC.traitsController.traitsToDisplay[index].updateTrait(newCount: traitCount)
            } else {
                guard var foundTrait = parentVC.traitsController.allTraits.first(where: { $0.name == traitName }) else { return }
                foundTrait.updateTrait(newCount: traitCount)
                parentVC.traitsController.traitsToDisplay.append(foundTrait)
            }
        }
        
        parentVC.traitsController.sortDisplayTraitsByRankThenCount()
        parentVC.traitsController.collectionView.reloadDataOnMainThread()
    }
    
    
    //MARK: Toggle ColView Action
    @objc func toggleColViewAction(_ sender: UIButton) {
        sender.pulseAnimateOnTap()
        showingItems ? collectionViewDisplayChampions() : collectionViewDisplayItems()
    }
    
    
    //MARK: ColView Display Items
    func collectionViewDisplayItems() {
        guard !showingItems else { return }
        showingItems = true
        champItemSelectionView.updateToggleButtonTitle(displayingItems: true)
        champItemSelectionView.collectionView.reloadDataOnMainThread()
    }
    
    
    //MARK: ColView Display Champions
    func collectionViewDisplayChampions() {
        guard showingItems else { return }
        showingItems = false
        champItemSelectionView.updateToggleButtonTitle(displayingItems: false)
        champItemSelectionView.collectionView.reloadDataOnMainThread()
    }
    
    
    //MARK: Sort By Button Action
    @objc func sortByButtonAction(_ sender: UIButton) {
        sender.pulseAnimateOnTap()
        
        guard let buttonTapped = SortBy(rawValue: sender.tag) else {
            presentErrorAlertOnMainThread(title: "Error Sorting", message: "Couldn't sort via \(sender.titleLabel?.text ?? "selected option"). Please try again.", buttonTitle: "Okay")
            return
        }
        
        for btn in champItemSelectionView.buttonsStackView.arrangedSubviews {
            if let btn = btn as? CreateTCSortButton {
                switch sender.tag {
                case btn.tag:
                    btn.isSelected = true
                default:
                    btn.isSelected = false
                }
            }
        }
        
        switch buttonTapped {
        case .name:
            configureDataSourceArrayWith(champions: allChampions, filteredBy: .name, numberOfSections: 1)
        case .cost:
            configureDataSourceArrayWith(champions: allChampions, filteredBy: .cost, numberOfSections: Cost.allCases.count)
        case .tier:
            configureDataSourceArrayWith(champions: allChampions, filteredBy: .tier, numberOfSections: TierRating.allCases.count)
        }
        
        sortingBy = buttonTapped
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
        return showingItems ? 1 : dataSourceChampions.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return showingItems ? items.count : dataSourceChampions[section].count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let headerWidth: CGFloat = sortingBy == .name || showingItems ? 0 : 44
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
        switch showingItems {
        case false:
            let cell = collectionView.dequeueReusableCell(ChampionSelectionCell.self, for: indexPath)
            cell.configureCell(with: dataSourceChampions[indexPath.section][indexPath.item])
            return cell
        case true:
            let cell = collectionView.dequeueReusableCell(ItemSelectionCell.self, for: indexPath)
            cell.configureCell(with: items[indexPath.item])
            return cell
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let parentVC = parent as? CreateTeamCompVC else { return }
        
        switch showingItems {
        case false:
            let champToAdd = dataSourceChampions[indexPath.section][indexPath.item]
            if shouldAddChampToTeamComp(champToAdd, parentVC) {
                addChampionToTeamComp(champToAdd, parentVC)
                updateTraitsColViewWithChampTraits(parentVC)
            }
            
        case true:
            let itemName = items[indexPath.item].name.formattedName()
            parentVC.selectedTeamCompVC.addItemToSelectedChampion(itemName)
        }
    }
}
