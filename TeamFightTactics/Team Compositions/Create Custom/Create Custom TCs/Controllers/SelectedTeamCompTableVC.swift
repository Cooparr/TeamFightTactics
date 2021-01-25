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

class SelectedTeamCompTableVC: UIViewController {
    
    //MARK: Properties
    weak var delegate: SelectedTeamCompTableVCDelegate!
    let createdTeamCompTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SelectedChampionCell.self, forCellReuseIdentifier: SelectedChampionCell.reuseId)
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = ThemeColor.charcoal
        tableView.layer.cornerRadius = 10
        tableView.removeExcessCells()
        return tableView
    }()

    var selectedChampionsForTeamComp = [Champion]() {
        didSet {
            selectedChampionsForTeamComp = sortChampionsByCostThenName()
        }
    }

    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    
    //MARK: Setup Table View
    fileprivate func setupTableView() {
        createdTeamCompTableView.delegate = self
        createdTeamCompTableView.dataSource = self
        
        view.addSubview(createdTeamCompTableView)
        NSLayoutConstraint.activate([
            createdTeamCompTableView.topAnchor.constraint(equalTo: view.topAnchor),
            createdTeamCompTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            createdTeamCompTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            createdTeamCompTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    //MARK: Sort Champions By Cost Then Name
    fileprivate func sortChampionsByCostThenName() -> [Champion] {
        return selectedChampionsForTeamComp.sorted {champOne, champTwo in
            if champOne.cost == champTwo.cost { return champOne.name < champTwo.name }
            return champOne.cost < champTwo.cost
        }
    }
    
}


extension SelectedTeamCompTableVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        selectedChampionsForTeamComp.isEmpty ? tableView.setEmptyMessage("Try adding a few champions.") : tableView.removeEmptyMessage()
        return selectedChampionsForTeamComp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(SelectedChampionCell.self, for: indexPath)
        cell.configureCell(with: selectedChampionsForTeamComp[indexPath.row])
        
        cell.buttonTappedAction = { [weak self] cell in
            guard let self = self else { return }
            
            print(self.selectedChampionsForTeamComp[indexPath.row].name)
            #warning("Do something when item button tapped")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let champToRemove = selectedChampionsForTeamComp[indexPath.row]
        delegate.removeTraits(for: champToRemove)
        
        selectedChampionsForTeamComp.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
