//
//  TCViewController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 15/10/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit
import FirebaseFirestore

class TCViewController: UIViewController {
    
    //MARK:- Properties
    private let tcRootView = TCView()
    var allChampions = [Champion]()
    var allTeamComps = [TeamComposition]() {
        didSet {
            handleSpinner(spin: tcRootView.activityIndicator, if: allTeamComps.isEmpty)
            tcRootView.tableView.reloadData()
        }
    }
    
    var useSetSkins: Bool? = nil {
        didSet {
            tcRootView.tableView.reloadData()
        }
    }
    
    
    //MARK:- Load View
    override func loadView() {
        super.loadView()
        self.view = tcRootView
    }
    
    
    //MARK:- View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleSpinner(spin: tcRootView.activityIndicator, if: allTeamComps.isEmpty)
        useSetSkins = UserDefaults.standard.bool(forKey: Constants.skinsKey)
    }
    
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetup()
        
        // Assign Delegates
        tcRootView.tableView.delegate = self
        tcRootView.tableView.dataSource = self
    }
    
    
    //MARK: Navigation Bar Code
    fileprivate func navigationBarSetup() {
        navigationItem.title = "Team Composition"
        rightNavBarSettingsButton()
    }
    
    
    //MARK:- Setup Cell BackgroundView
    fileprivate func setupCellBackgroundView(_ cell: TCCell) {
        let backgroundView = UIView()
        backgroundView.backgroundColor = CustomColor.charcoal
        cell.selectedBackgroundView = backgroundView
    }
    
    
    //MARK: Append End Game Champions into Team Comp
    fileprivate func appendEndGameChampObjsToTeamComp(_ indexPath: IndexPath, _ cell: TCCell) {
        for champ in allChampions where allTeamComps[indexPath.row].endGame.contains(where: {$0.name == champ.name}) {
            cell.teamComp?.endGameChampObjs.append(champ)
        }
    }
    
    
    //MARK: Append All Champions into Team Comp
    fileprivate func appendAllChampObjsToTeamComp(_ indexPath: IndexPath, _ teamCompDetailViewController: TCDetailViewController) {
        let selectedTeamComp = allTeamComps[indexPath.row]
        
        var selectedEndGame = [String]()
        selectedTeamComp.endGame.forEach({ selectedEndGame.append($0.name) })
        let merged = Array(Set(selectedEndGame + selectedTeamComp.earlyGame + selectedTeamComp.midGame))
        
        for champ in allChampions where merged.contains(champ.name) {
            teamCompDetailViewController.teamComp?.allChampObjs.append(champ)
        }
    }
}


//MARK:- TableView Data Source
extension TCViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTeamComps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableId", for: indexPath) as! TCCell
        cell.teamComp = allTeamComps[indexPath.row]
        appendEndGameChampObjsToTeamComp(indexPath, cell)
        
        setupCellBackgroundView(cell)
        
        return cell
    }
}


//MARK:- TableView Delegate
extension TCViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let teamComp = allTeamComps[indexPath.row]
        let teamCompDetailViewController = TCDetailViewController()
        teamCompDetailViewController.teamComp = teamComp
        appendAllChampObjsToTeamComp(indexPath, teamCompDetailViewController)
        
        self.navigationController?.pushViewController(teamCompDetailViewController, animated: true)
        tcRootView.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
