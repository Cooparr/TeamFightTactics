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
    let galaxyCellIndex = 2
    let moreTabs: [TabItem] = [
        TabItem(tabTitle: TabTitle.traits, tabImage: TabIcon.traits, tabVC: TraitsController()),
        TabItem(tabTitle: TabTitle.dropRates, tabImage: TabIcon.dropRate, tabVC: DropRatesController()),
        TabItem(tabTitle: TabTitle.galaxies, tabImage: TabIcon.galaxies, tabVC: GalaxiesController())
    ]
    
    var currentSet: Double {
        return UserDefaults.standard.double(forKey: UDKey.setKey)
    }
    
    
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
        tableView.reloadData()
    }
    
    
    //MARK:- Set Table View Delegate & Data Source
    fileprivate func applyDelgates() {
        moreView.delegate = self
        moreView.dataSource = self
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
        if currentSet != TFTSet.three.rawValue && indexPath.row == galaxyCellIndex {
            cell.isHidden = true
        }
        return cell
    }
}


//MARK:- TableView Delegate
extension MoreTabsController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if currentSet != TFTSet.three.rawValue && indexPath.row == galaxyCellIndex {
            return 0
        } else {
            return 60
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tab = moreTabs[indexPath.row].viewController
        self.navigationController?.pushViewController(tab, animated: true)
    }
}
