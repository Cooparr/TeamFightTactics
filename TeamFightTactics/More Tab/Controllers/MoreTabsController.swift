//
//  MoreTabsController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 11/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class MoreTabsController: UITableViewController {
    
    
    //MARK:- Properties
    private let moreView = MoreTabsView()
    private(set) var moreTabs: [TabItem] = [
        TabItem(tabTitle: TabTitle.traits, tabImage: TabIcon.traits, tabVC: TraitsController()),
        TabItem(tabTitle: TabTitle.dropRates, tabImage: TabIcon.dropRate, tabVC: DropRatesController())
    ]
    
    
    //MARK:- Load View
    override func loadView() {
        super.loadView()
        self.view = moreView
    }
    
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        applyDelgates()
        setupNavBar(navTitle: TabTitle.more)
    }
    
    
    //MARK:- View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateDatasource()
        tableView.reloadDataOnMainThread()
    }
    
    
    //MARK:- Set Table View Delegate & Data Source
    private func applyDelgates() {
        moreView.delegate = self
        moreView.dataSource = self
    }
    
    
    //MARK: Updated Datasource
    private func updateDatasource() {
        guard SettingsManager.getDisplayedSet() == TFTSet.three else {
            return moreTabs.removeAll { $0.title == TabTitle.galaxies.rawValue }
        }
        
        let galaxyTab = TabItem(tabTitle: TabTitle.galaxies, tabImage: TabIcon.galaxies, tabVC: GalaxiesController())
        moreTabs.append(galaxyTab)
    }
}


//MARK:- TableView Data Source
extension MoreTabsController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moreTabs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(MoreTabCell.self, for: indexPath)
        cell.configureCell(with: moreTabs[indexPath.row])
        return cell
    }
}


//MARK:- TableView Delegate
extension MoreTabsController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tab = moreTabs[indexPath.row].viewController
        self.navigationController?.pushViewController(tab, animated: true)
    }
}
