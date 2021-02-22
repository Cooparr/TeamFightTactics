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

class SelectedTeamCompTableVC: UITableViewController {
    
    //MARK: Properties
    weak var delegate: SelectedTeamCompTableVCDelegate!

    var selectedChampionsForTeamComp = [Champion]() {
        didSet {
            selectedChampionsForTeamComp = sortChampionsByCostThenName()
        }
    }
    
    
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
    fileprivate func sortChampionsByCostThenName() -> [Champion] {
        return selectedChampionsForTeamComp.sorted {champOne, champTwo in
            if champOne.cost == champTwo.cost { return champOne.name < champTwo.name }
            return champOne.cost < champTwo.cost
        }
    }
    
    
    //MARK: Create Trait [Name: Count] Dictionary
    func createDictionaryOfTraitNameAndCount() -> [String: Int] {
        //Remove duplicate champs
        var champsToCount = [Champion]()
        for champ in selectedChampionsForTeamComp {
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
        selectedChampionsForTeamComp.isEmpty ? tableView.setEmptyMessage("Try adding a few champions.") : tableView.removeEmptyMessage()
        return selectedChampionsForTeamComp.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(SelectedChampionCell.self, for: indexPath)
        cell.configureCell(with: selectedChampionsForTeamComp[indexPath.row])
        
        cell.buttonTappedAction = { [weak self] cell in
            guard let self = self else { return }
            
            print(self.selectedChampionsForTeamComp[indexPath.row].name)
            #warning("Do something when item button tapped")
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let champToRemove = selectedChampionsForTeamComp[indexPath.row]
        let champOccurenceCount = selectedChampionsForTeamComp.filter { $0 == champToRemove }.count
        if champOccurenceCount < CreateTeamCompVC.numOfChampOccurencesPerTeamComp {
            delegate.removeTraits(for: champToRemove)
        }
        

        selectedChampionsForTeamComp.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let parentVC = parent as? CreateTeamCompVC else { return }
        if !parentVC.champItemsController.showingItems {
            parentVC.toggleChampItemCollectionView()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let indexPathForSelectedRow = tableView.indexPathForSelectedRow, indexPathForSelectedRow == indexPath else { return indexPath }
        
        tableView.deselectRow(at: indexPath, animated: false)
        return nil
    }
}
