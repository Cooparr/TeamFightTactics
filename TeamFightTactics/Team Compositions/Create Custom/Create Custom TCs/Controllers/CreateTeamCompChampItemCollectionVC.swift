//
//  CreateTeamCompChampItemCollectionVC.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 12/02/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class CreateTeamCompChampItemCollectionVC: UICollectionViewController {

    //MARK: Properties
    var sortingBy = CreateTCView.SortBy.cost
    var allChampions = [Champion]()
    var dataSourceChampions = [[Champion]]()
    
    var showingItems = false
    var items = [Item]()
    
    var costsForSectionHeader = [Cost]()

    //MARK: Init
    override init(collectionViewLayout layout: UICollectionViewLayout = UICollectionViewFlowLayout()) {
        super.init(collectionViewLayout: layout)

        guard let layout = layout as? UICollectionViewFlowLayout else { return }
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 40)
        
        collectionView.register(SelectionColViewSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SelectionColViewSectionHeader.reuseId)
        collectionView.register(ChampionSelectionCell.self, forCellWithReuseIdentifier: ChampionSelectionCell.reuseId)
        collectionView.register(ItemSelectionCell.self, forCellWithReuseIdentifier: ItemSelectionCell.reuseId)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = ThemeColor.richBlack
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.heightAnchor.constraint(equalToConstant: 225).isActive = true
    }
    
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
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
                self.collectionView.reloadDataOnMainThread()
            }
        }
    }
    
    
    //MARK: Configure Data Source Array
    func configureDataSourceArrayWith(champions: [Champion], filteredBy champProperty: CreateTCView.SortBy, numberOfSections: Int) {
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
        let sizeOfTeamComp = parentVC.createdTeamCompVC.customSelectedChampionsForTeamComp.count + 1
        let champOccurenceCount = parentVC.createdTeamCompVC.customSelectedChampionsForTeamComp.filter { $0 == champToAdd }.count

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
        parentVC.createdTeamCompVC.customSelectedChampionsForTeamComp.append(champToAdd)
        
        guard let lastIndex = parentVC.createdTeamCompVC.customSelectedChampionsForTeamComp.lastIndex(of: champToAdd) else { return }
        let lastIndexPath = IndexPath(row: lastIndex, section: 0)
        parentVC.createdTeamCompVC.tableView.insertRowsWithUpdates(at: [lastIndexPath])
        parentVC.createdTeamCompVC.tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
    }
    
    
    //MARK: Update Traits Bar With New Champ Traits
    fileprivate func updateTraitsColViewWithChampTraits(_ parentVC: CreateTeamCompVC) {
        for trait in parentVC.createdTeamCompVC.createDictionaryOfTraitNameAndCount() {
            let traitName = trait.key
            let traitCount = trait.value
                                
            if parentVC.traitsController.traitsToDisplay.contains( where: { $0.name == traitName }) {
                guard let index = parentVC.traitsController.traitsToDisplay.firstIndex(where: { $0.name == traitName }) else { return }
                parentVC.traitsController.traitsToDisplay[index].updateTrait(newCount: traitCount)
            } else {
                guard let foundTrait = parentVC.traitsController.allTraits.first(where: { $0.name == traitName }) else { return }
                var customTrait = CustomTrait(name: traitName, count: traitCount, rank: .unranked, isChosen: false, bonuses: foundTrait.bonuses)
                customTrait.setTraitRank(traitCount: traitCount)
                parentVC.traitsController.traitsToDisplay.append(customTrait)
            }
        }
        
        parentVC.traitsController.sortDisplayTraitsByRankThenCount()
        parentVC.traitsController.collectionView.reloadDataOnMainThread()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK:- Collection View Delegates
extension CreateTeamCompChampItemCollectionVC: UICollectionViewDelegateFlowLayout {
    
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
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return showingItems ? 1 : dataSourceChampions.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return showingItems ? items.count : dataSourceChampions[section].count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let headerWidth: CGFloat = sortingBy == .name || showingItems ? 0 : 44
        return CGSize(width: headerWidth, height: collectionView.frame.width)
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SelectionColViewSectionHeader.reuseId, for: indexPath) as! SelectionColViewSectionHeader
            sectionHeader.configureSectionHeader(sortingBy: sortingBy, sectionIndex: indexPath.section, costValues: costsForSectionHeader)
            return sectionHeader
        } else {
            return UICollectionReusableView()
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let parentVC = parent as? CreateTeamCompVC else { return }
        
        switch showingItems {
        case false:
//            let champToAdd = dataSourceChampions[indexPath.section][indexPath.item].createCustomChamp()
            let champToAdd = dataSourceChampions[indexPath.section][indexPath.item]
            if shouldAddChampToTeamComp(champToAdd, parentVC) {
                addChampionToTeamComp(champToAdd, parentVC)
                updateTraitsColViewWithChampTraits(parentVC)
            }
            
        case true:
            let itemName = items[indexPath.item].name.formattedName()
            parentVC.createdTeamCompVC.addItemToSelectedChampion(itemName)
        }
    }
}
