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
    var moreTabs = [TabItem]()
    
    
    //MARK:- Load View
    override func loadView() {
        super.loadView()
        self.view = moreView
    }
    
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyDelgateAndDataSource()
        navigationBarSetup()
        createMoreTabItems()
    }
    
    
    //MARK:- Create More Tab Items
    fileprivate func createMoreTabItems() {
        let traitsTab = TabItem(tabTitle: "Classes & Origins", tabImage: TabBarIcon.item, tabVC: TraitsController())
        let dropRatesTab = TabItem(tabTitle: "Drop Rates", tabImage: TabBarIcon.item, tabVC: DropRatesController())
        
        moreTabs.append(traitsTab)
        moreTabs.append(dropRatesTab)
    }
    
    
    //MARK:- Set Table View Delegate & Data Source
    fileprivate func applyDelgateAndDataSource() {
        moreView.delegate = self
        moreView.dataSource = self
    }
    
    
    //MARK:- Navigation Bar Code
    fileprivate func navigationBarSetup() {
        navigationItem.title = "More"
        rightNavBarSettingsButton()
    }
}


//MARK:- TableView Data Source
extension MoreTabsController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moreTabs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseId.moreCell, for: indexPath) as! MoreTabCell
        cell.moreTab = moreTabs[indexPath.row]
        return cell
    }
}


//MARK:- TableView Delegate
extension MoreTabsController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tab = moreTabs[indexPath.row].viewController
        self.navigationController?.pushViewController(tab, animated: true)
    }
}
