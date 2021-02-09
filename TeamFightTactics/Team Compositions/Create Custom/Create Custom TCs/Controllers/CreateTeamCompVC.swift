//
//  CreateTeamCompVC.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 26/11/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class CreateTeamCompVC: UIViewController {

    //MARK: Properties
    let maxTeamCompSize = 9
    let numOfChampOccurencesPerTeamComp = 2
    
    private let createCustomTCView = CreateTeamCompView()
    let createdTeamCompVC = SelectedTeamCompTableVC()
    
    var sortingBy = CreateTeamCompView.SortBy.cost
    var allChampions = [Champion]()
    var dataSourceChampions = [[Champion]]()
    
    var allTraits = [Trait]()
    var traitsToDisplay = [CustomTrait]()

    var showItems = false
    var items = [Item]()
    

    //MARK: Load View
    override func loadView() {
        super.loadView()
        self.view = createCustomTCView
    }
    
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        createDismissKeyboardTapGesture()
        
        createdTeamCompVC.delegate = self
        
        createCustomTCView.champItemCollectionView.delegate = self
        createCustomTCView.champItemCollectionView.dataSource = self
        createCustomTCView.nameTextField.delegate = self
        
        createCustomTCView.traitsCollectionView.delegate = self
        createCustomTCView.traitsCollectionView.dataSource = self
        
        
        let firestore = FirestoreManager()
        firestore.fetchSetData(from: .champions, updateKey: .champs) { [weak self] (champions: [Champion]) in
            firestore.fetchSetData(from: .items, updateKey: .items) { (items: [Item]) in
                guard let self = self else { return }
                self.allChampions = champions
                self.configureDataSourceArrayWith(champions: champions, filteredBy: .cost, numberOfSections: Cost.allCases.count)
                
                self.items = items
                self.createCustomTCView.champItemCollectionView.reloadDataOnMainThread()
            }
        }
        
        
        firestore.fetchSetData(from: .classes, updateKey: .classes) { [weak self] (classes: [Trait]) in
            firestore.fetchSetData(from: .origins, updateKey: .origins) { (origins: [Trait]) in
                guard let self = self else { return }
                self.allTraits = classes + origins
            }
        }
        
        setupNavBar(navTitle: .createTeamComp, showSettingsButton: false)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTeamComp)),
            UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(retrieveTeamComp)),
            UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteAllTeamComps))
        ]
        
        
        
        add(childVC: createdTeamCompVC, toView: self.view)
        createdTeamCompVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createdTeamCompVC.view.topAnchor.constraint(equalTo: createCustomTCView.champItemCollectionView.bottomAnchor, constant: 20),
            createdTeamCompVC.view.leadingAnchor.constraint(equalTo: createCustomTCView.leadingAnchor, constant: 20),
            createdTeamCompVC.view.trailingAnchor.constraint(equalTo: createCustomTCView.trailingAnchor, constant: -20),
            createdTeamCompVC.view.bottomAnchor.constraint(equalTo: createCustomTCView.bottomAnchor, constant: -20)
        ])
    }
    
    
    //MARK: Configure Data Source Array
    func configureDataSourceArrayWith(champions: [Champion], filteredBy champProperty: CreateTeamCompView.SortBy, numberOfSections: Int) {
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
            }
        }
    }
    
    
    //MARK: Save Team Comp Action
    @objc fileprivate func saveTeamComp() {
        guard let teamCompName = createCustomTCView.nameTextField.text else { return }
        
        
        let customChampions = createdTeamCompVC.selectedChampionsForTeamComp.map {
            return CustomChampion(name: $0.name,
                                  key: $0.name.formattedName(),
                                  imgURL: $0.imgURL,
                                  items: nil,
                                  cost: $0.cost,
                                  origins: $0.origins,
                                  classes: $0.classes)
        }
        let customTeamComp = CustomTeamComposition(title: teamCompName, champions: customChampions)
        
        
        PersistenceManager.updateTeamComp(teamComp: customTeamComp, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                self.navigationController?.popViewController(animated: true)
                return
            }
            
            self.presentErrorAlertOnMainThread(title: "Error Saving Team Comp", message: error.rawValue, buttonTitle: "Ok")
        }
    }
    
    
    //MARK: Retrieve Team Comp Action
    @objc fileprivate func retrieveTeamComp() {
        PersistenceManager.retrieveTeamComps { result in
            switch result {
            case .success(let teamComps):
                print(teamComps)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    //MARK: Delete All Team Comps Action
    @objc fileprivate func deleteAllTeamComps() {
        PersistenceManager.deleteAllTeamComps { error in
            guard let error = error else {
                self.navigationController?.popViewController(animated: true)
                return
            }
            
            self.presentErrorAlertOnMainThread(title: "Error Deleting Team Comps", message: error.rawValue)
        }
    }
    
    
    //MARK: Create Dismiss Keyboard Tap Gesture
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    
    //MARK: Create Trait [Name: Count] Dictionary
    fileprivate func createDictionaryOfTraitNameAndCount() -> [String: Int] {
        //Remove duplicate champs
        var champsToCount = [Champion]()
        for champ in createdTeamCompVC.selectedChampionsForTeamComp {
            if !champsToCount.contains(where: { $0 == champ }) {
                champsToCount.append(champ)
            }
        }
        
        // create array of countable traits
        let traitsToCount = champsToCount.flatMap { return $0.classes + $0.origins }
        
        // return count of all the champion traits
        return traitsToCount.reduce(into: [:]) { counts, traitName in counts[traitName, default: 0] += 1 }
    }
    
    
    //MARK: Sort Display Traits By Rank Then Count
    fileprivate func sortDisplayTraitsByRankThenCount() {
        traitsToDisplay.sort { traitOne, traitTwo in
            if traitOne.rank.rawValue == traitTwo.rank.rawValue { return traitOne.count > traitTwo.count }
            return traitOne.rank.rawValue < traitTwo.rank.rawValue
        }
    }
    
    
    //MARK: Should Add To Team Comp Check
    fileprivate func shouldAddToTeamComp(_ teamCompSize: Int, _ champOccurence: Int) -> Bool {
        if teamCompSize > maxTeamCompSize {
            presentErrorAlertOnMainThread(title: "Team Comp Limit",
                                          message: "The maximum size of a team comp is \(maxTeamCompSize)",
                                          buttonTitle: "Okay")
        }
        
        if champOccurence == numOfChampOccurencesPerTeamComp {
            presentErrorAlertOnMainThread(title: "Champion Limit",
                                          message: "A champion can only occur in the same team comp twice.",
                                          buttonTitle: "Okay")
        }
        
        return teamCompSize <= maxTeamCompSize && champOccurence < numOfChampOccurencesPerTeamComp
    }
    
    
    //MARK: Toggle Collection View Action
    @objc func toggleColViewAction(_ sender: UIButton) {
        sender.pulseAnimateOnTap()
        
        showItems.toggle()
        createCustomTCView.updateToggleButtonTitle(showItems: showItems)
        createCustomTCView.champItemCollectionView.reloadDataOnMainThread()
    }
    
    //MARK: Sort By Button Action
    @objc func sortByButtonAction(_ sender: UIButton) {
        sender.pulseAnimateOnTap()
        
        guard let buttonTapped = CreateTeamCompView.SortBy(rawValue: sender.tag) else {
            presentErrorAlertOnMainThread(title: "Error Sorting", message: "Couldn't sort via \(sender.titleLabel?.text ?? "selected option"). Please try again.", buttonTitle: "Okay")
            return
        }
        
        for btn in createCustomTCView.buttonsStackView.arrangedSubviews {
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
            self.configureDataSourceArrayWith(champions: allChampions, filteredBy: .name, numberOfSections: 1)
        case .cost:
            self.configureDataSourceArrayWith(champions: allChampions, filteredBy: .cost, numberOfSections: Cost.allCases.count)
        case .tier:
            self.configureDataSourceArrayWith(champions: allChampions, filteredBy: .tier, numberOfSections: TierRating.allCases.count)
        }
        
        sortingBy = buttonTapped
        createCustomTCView.champItemCollectionView.reloadDataOnMainThread()
    }
}


extension CreateTeamCompVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.createCustomTCView.champItemCollectionView {
            guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize(width: 40, height: 40) }
            
            let numberOfCellsForEachColumn: CGFloat = 3
            let champNameLabelHeightCompensation: CGFloat = 15
            let topInset = flowLayout.sectionInset.top
            let bottomInset = flowLayout.sectionInset.bottom
            let itemSpacing = flowLayout.minimumInteritemSpacing * (numberOfCellsForEachColumn - 1)
            let totalPadding = topInset + bottomInset + itemSpacing + (champNameLabelHeightCompensation * numberOfCellsForEachColumn)
            let sizeForEachItem = (collectionView.bounds.height - totalPadding)  / numberOfCellsForEachColumn
            
            return CGSize(width: sizeForEachItem, height: sizeForEachItem + champNameLabelHeightCompensation)
            
        } else {
            let trait = traitsToDisplay[indexPath.row]
            let labelWidth = trait.name.size(withAttributes: [
                NSAttributedString.Key.font : UIFont.preferredFont(forTextStyle: .callout)
            ]).width
            
            return CGSize(width: labelWidth + 55, height: createCustomTCView.traitsColViewHeight)
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == self.createCustomTCView.champItemCollectionView {
            return showItems ? 1 : dataSourceChampions.count
        } else {
            return 1
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.createCustomTCView.champItemCollectionView {
            return showItems ? items.count : dataSourceChampions[section].count
        } else {
            return traitsToDisplay.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView == self.createCustomTCView.champItemCollectionView {
            let headerWidth: CGFloat = sortingBy == .name || showItems ? 0 : 44
            return CGSize(width: headerWidth, height: collectionView.frame.width)
        } else {
            return CGSize.zero
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == self.createCustomTCView.champItemCollectionView {
            if kind == UICollectionView.elementKindSectionHeader {
                let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SelectionColViewSectionHeader.reuseId, for: indexPath) as! SelectionColViewSectionHeader
                sectionHeader.configureSectionHeader(sortingBy: sortingBy, sectionIndex: indexPath.section)
                return sectionHeader
            } else {
                return UICollectionReusableView()
            }
        } else {
            return UICollectionReusableView()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.createCustomTCView.champItemCollectionView {
            switch showItems {
            case false:
                let cell = collectionView.dequeueReusableCell(ChampionSelectionCell.self, for: indexPath)
                cell.configureCell(with: dataSourceChampions[indexPath.section][indexPath.item])
                return cell
            case true:
                let cell = collectionView.dequeueReusableCell(ItemSelectionCell.self, for: indexPath)
                cell.configureCell(with: items[indexPath.item])
                return cell
            }
            
        } else {
            let cell = collectionView.dequeueReusableCell(CreateTeamCompTraitCell.self, for: indexPath)
            cell.configureCell(with: traitsToDisplay[indexPath.item])
            return cell
        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.createCustomTCView.champItemCollectionView {
            
            switch showItems {
            case false:
                let champToAdd = dataSourceChampions[indexPath.section][indexPath.item]
                let sizeOfTeamComp = createdTeamCompVC.selectedChampionsForTeamComp.count + 1
                let champOccurenceCount = createdTeamCompVC.selectedChampionsForTeamComp.filter { $0 == champToAdd }.count
                
                
                if shouldAddToTeamComp(sizeOfTeamComp, champOccurenceCount) {
                    createdTeamCompVC.selectedChampionsForTeamComp.append(champToAdd)
                    if let lastIndex = createdTeamCompVC.selectedChampionsForTeamComp.lastIndex(of: champToAdd) {
                        let lastIndexPath = IndexPath(row: lastIndex, section: 0)
                        createdTeamCompVC.createdTeamCompTableView.insertRowsWithUpdates(at: [lastIndexPath])
                        createdTeamCompVC.createdTeamCompTableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
                    }
                    
                    for trait in createDictionaryOfTraitNameAndCount() {
                        let traitName = trait.key
                        let traitCount = trait.value

                        if traitsToDisplay.contains( where: { $0.name == traitName }) {
                            if let index = traitsToDisplay.firstIndex(where: { $0.name == traitName }) {
                                traitsToDisplay[index].updateTrait(newCount: traitCount)
                            }
                        } else {
                            #warning("handle error")
                            guard let foundTrait = allTraits.first(where: { $0.name == traitName }) else { return }
                            var customTrait = CustomTrait(name: traitName, count: traitCount, rank: .other, isChosen: false, bonuses: foundTrait.bonuses)
                            customTrait.setTraitRank(traitCount: traitCount)
                            traitsToDisplay.append(customTrait)
                        }
                    }
                    
                    sortDisplayTraitsByRankThenCount()
                    createCustomTCView.traitsCollectionView.reloadDataOnMainThread()
                }
            case true:
                print(items[indexPath.item].name)
            }
        } else {
            
            switch traitsToDisplay[indexPath.item].isChosen {
            case true:
                //remove the chosen buff
                traitsToDisplay[indexPath.item].removeChosenBuff()
                
            case false:
                // check if another trait is chosen
                if let existingChosenTraitIndex = traitsToDisplay.firstIndex(where: { $0.isChosen }) {
                    //remove buff
                    traitsToDisplay[existingChosenTraitIndex].removeChosenBuff()
                }
                
                // add chosen buff to trait
                traitsToDisplay[indexPath.item].addChosenBuff()
            }
            
            
            // update the collectionview
            createCustomTCView.traitsCollectionView.reloadDataOnMainThread()
        }
    }
}

extension CreateTeamCompVC: UITextFieldDelegate {
    
    //MARK: Text Field Should Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        createCustomTCView.nameTextField.resignFirstResponder()
        return false
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 20
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}


extension CreateTeamCompVC: SelectedTeamCompTableVCDelegate {
    
    func removeTraits(for champion: Champion) {
        let traitsToRemove = champion.classes + champion.origins
        let champOccurenceCount = createdTeamCompVC.selectedChampionsForTeamComp.filter { $0 == champion }.count
        
        if champOccurenceCount < numOfChampOccurencesPerTeamComp {
            for (index, trait) in traitsToDisplay.enumerated().reversed() where traitsToRemove.contains(trait.name) {
                let newTraitCount = trait.count - 1
                
                if newTraitCount == 0 || newTraitCount == 1 && trait.isChosen {
                    traitsToDisplay.remove(at: index)
                } else {
                    traitsToDisplay[index].count = newTraitCount
                    traitsToDisplay[index].setTraitRank(traitCount: newTraitCount)
                }
                
                sortDisplayTraitsByRankThenCount()
                createCustomTCView.traitsCollectionView.reloadDataOnMainThread()
            }
        }
    }
}
