//
//  SelectedTeamCompTableVC.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 14/12/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

//MARK:- Selected Team Comp Table VC Delegate
protocol SelectedTeamCompTableVCDelegate: class {
    func removeTraits(for champion: Champion)
}

protocol RemoveCustomItemDelegate: class {
    func removeCustomItem(_ itemName: String)
}

protocol CreateTeamCompVCDelegate: class {
    func collectionViewDisplayItems()
}

class SelectedTeamCompTableVC: UITableViewController, RemoveCustomItemDelegate {
    
    //MARK: Properties
    weak var selectedTCDelegate: SelectedTeamCompTableVCDelegate!
    weak var createTCDelegate: CreateTeamCompVCDelegate!
    
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
    
    
    //MARK: Add Item To Selected Champion
    func addItemToSelectedChampion(_ itemName: String) {
        guard let index = tableView.indexPathForSelectedRow, selectedChampsForTeamComp[index.row].canAddCustomItem() else { return }
        selectedChampsForTeamComp[index.row].addCustomItem(itemName)
//        tableView.reloadRows(at: [index], with: .none)
        tableView.reloadData()
        tableView.selectRow(at: index, animated: false, scrollPosition: .none)
    }
    
    
    func removeCustomItem(_ itemName: String) {
        guard let index = tableView.indexPathForSelectedRow else { return }
        
        
        selectedChampsForTeamComp[index.row].removeCustomItem(itemName)
        
        print(selectedChampsForTeamComp[index.row].name, itemName)
        
        print("should remove \(itemName)")
    }
    
    
    
    
    //MARK: Sort Champions By Cost Then Name
    fileprivate func sortChampionsByCostThenName() -> [Champion] {
        return selectedChampsForTeamComp.sorted { champOne, champTwo in
            if champOne.cost == champTwo.cost { return champOne.name < champTwo.name }
            return champOne.cost < champTwo.cost
        }
    }
    
    
    //MARK: Create Trait [Name: Count] Dictionary
    func createDictionaryOfTraitNameAndCount() -> [String: Int] {
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
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension SelectedTeamCompTableVC {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        selectedChampsForTeamComp.isEmpty ? tableView.setEmptyMessage("Try adding a few champions.") : tableView.removeEmptyMessage()
        return selectedChampsForTeamComp.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(SelectedChampionCell.self, for: indexPath)
        
        
        cell.configureCell(with: selectedChampsForTeamComp[indexPath.row])
        
        
        
        cell.itemsStackView.arrangedSubviews.forEach {
            guard let tapableItemView = $0 as? TappableItemView else { return }
            tapableItemView.delegate = self
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let champToRemove = selectedChampsForTeamComp[indexPath.row]
        let champOccurenceCount = selectedChampsForTeamComp.filter { $0 == champToRemove }.count
        if champOccurenceCount < CreateTeamCompVC.numOfChampOccurencesPerTeamComp {
            selectedTCDelegate.removeTraits(for: champToRemove)
        }
        

        selectedChampsForTeamComp.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        createTCDelegate.collectionViewDisplayItems()        
    }
    
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let indexPathForSelectedRow = tableView.indexPathForSelectedRow, indexPathForSelectedRow == indexPath else { return indexPath }
        
        tableView.deselectRow(at: indexPath, animated: false)
        return nil
    }
}
