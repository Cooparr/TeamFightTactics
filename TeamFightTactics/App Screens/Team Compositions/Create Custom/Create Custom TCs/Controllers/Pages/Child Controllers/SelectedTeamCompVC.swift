//
//  SelectedTeamCompVC.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 14/12/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

protocol CreateTeamCompVCDelegate: AnyObject {
    func collectionViewDisplayItems()
}

//MARK:- Selected Team Comp Table VC Delegate
protocol SelectedTeamCompDelegate: AnyObject {
    func selectedTeamComp(removeTraitsFor champion: Champion)
}


class SelectedTeamCompVC: UITableViewController {
    
    //MARK: Properties
    weak var createTCDelegate: CreateTeamCompVCDelegate?
    weak var selectedTCDelegate: SelectedTeamCompDelegate?

    var selectedChampsForTeamComp = [Champion]() {
        didSet {
            selectedChampsForTeamComp = sortChampionsByCostThenName()
        }
    }
    
    
    //MARK: Override Init
    override init(style: UITableView.Style = .plain) {
        super.init(style: style)
        
        tableView.register(SelectedChampionCell.self, forCellReuseIdentifier: SelectedChampionCell.reuseId)
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = ThemeColor.charcoal
        tableView.layer.cornerRadius = 10
        tableView.removeExcessCells()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    //MARK: Sort Champions By Cost Then Name
    private func sortChampionsByCostThenName() -> [Champion] {
        return selectedChampsForTeamComp.sorted { champOne, champTwo in
            if champOne.cost == champTwo.cost { return champOne.name < champTwo.name }
            return champOne.cost < champTwo.cost
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: Add / Remove Custom Item
extension SelectedTeamCompVC: TappableItemViewDelegate {
    func tappableItemView(removeItem itemName: String, from cell: SelectedChampionCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        selectedChampsForTeamComp[indexPath.row].removeCustomItem(itemName)
    }
}


extension SelectedTeamCompVC: SelectionVCDelegate {
    func shouldAddChampToTeamComp(champSelected: Champion) -> Bool {
        let sizeOfTeamComp = selectedChampsForTeamComp.count + 1
        let champOccurenceCount = selectedChampsForTeamComp.filter { $0 == champSelected }.count + 1
        
        guard sizeOfTeamComp <= GameRestraints.maxTeamCompSize else {
            presentErrorAlertOnMainThread(title: "Team Comp Limit", message: "The maximum size of a team comp is \(GameRestraints.maxTeamCompSize)", buttonTitle: "Okay")
            return false
        }
        
        guard champOccurenceCount <= GameRestraints.champOccurencesPerTeam else {
            presentErrorAlertOnMainThread(title: "Champion Limit", message: "A champion can only occur in the same team comp \(GameRestraints.champOccurencesPerTeam) times.", buttonTitle: "Okay")
            return false
        }
        
        return true
    }
    
    func champSelected(addChampToTeamComp champ: Champion) {
        selectedChampsForTeamComp.append(champ)
        
        guard let lastIndex = selectedChampsForTeamComp.lastIndex(of: champ) else { return }
        let lastIndexPath = IndexPath(row: lastIndex, section: 0)
        tableView.insertRowsWithUpdates(at: [lastIndexPath])
        tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
    }
    
    func itemSelected(addItemToChampion itemName: String) {
        guard let index = tableView.indexPathForSelectedRow else { return }
        selectedChampsForTeamComp[index.row].addCustomItem(itemName)
        tableView.reloadRows(at: [index], with: .none)
        tableView.selectRow(at: index, animated: false, scrollPosition: .none)
    }
}



//MARK: Create TC Traits Delegate
extension SelectedTeamCompVC: CreateTCTraitsDelegate {
    
    func createTraitCountDictionary() -> [String: Int] {
        //Remove duplicate champs
        var champsToCount = [Champion]()
        for champ in selectedChampsForTeamComp {
            if !champsToCount.contains(where: { $0 == champ }) {
                champsToCount.append(champ)
            }
        }
        
        // create array of countable traits
        let traitsToCount = champsToCount.flatMap { return $0.classes + $0.origins }
        
        // return count of all the champion traits
        return traitsToCount.reduce(into: [:]) { counts, traitName in counts[traitName, default: 0] += 1 }
    }
}


//MARK: Table View Delegate Functions
extension SelectedTeamCompVC {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.shouldDisplayEmptyMessage(if: selectedChampsForTeamComp.isEmpty, message: "Try adding a few champions.")
        return selectedChampsForTeamComp.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(SelectedChampionCell.self, for: indexPath)
        cell.configureCell(with: selectedChampsForTeamComp[indexPath.row])
        
        cell.removeChampCallback = { [weak self] currentCell in
            guard let self = self else { return }
            guard let cellIndexPath = tableView.indexPath(for: currentCell) else { return }
            let champToRemove = self.selectedChampsForTeamComp[cellIndexPath.row]
            let champOccurenceCount = self.selectedChampsForTeamComp.filter { $0 == champToRemove }.count
            if champOccurenceCount < GameRestraints.champOccurencesPerTeam {
                self.selectedTCDelegate?.selectedTeamComp(removeTraitsFor: champToRemove)
            }
            
            self.selectedChampsForTeamComp.remove(at: cellIndexPath.row)
            tableView.deleteRows(at: [cellIndexPath], with: .left)
        }
        
        cell.itemsStackView.arrangedSubviews.forEach {
            guard let tapableItemView = $0 as? TappableItemView else { return }
            tapableItemView.removeItemDelegate = self
        }
        
        return cell
    }
    
    
//     Tableview swipe to delete code - switching to pageviewcontroller made this janky.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        guard editingStyle == .delete else { return }
//        let champToRemove = selectedChampsForTeamComp[indexPath.row]
//        let champOccurenceCount = selectedChampsForTeamComp.filter { $0 == champToRemove }.count
//        if champOccurenceCount < CreateTCPageViewController.champOccurencesPerTeamComp {
//            selectedTCDelegate?.selectedTeamComp(removeTraitsFor: champToRemove)
//        }
//
//        selectedChampsForTeamComp.remove(at: indexPath.row)
//        tableView.deleteRows(at: [indexPath], with: .automatic)
//    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        createTCDelegate?.collectionViewDisplayItems()
    }
    
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let indexPathForSelectedRow = tableView.indexPathForSelectedRow, indexPathForSelectedRow == indexPath else { return indexPath }
        
        tableView.deselectRow(at: indexPath, animated: false)
        return nil
    }
}
