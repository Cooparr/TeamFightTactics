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
    var allClasses = [Trait]()
    var allOrigins = [Trait]()
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
        useSetSkins = UserDefaults.standard.bool(forKey: UDKey.skinsKey)
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
        backgroundView.backgroundColor = ThemeColor.charcoal
        cell.selectedBackgroundView = backgroundView
    }
    
    
    //MARK: Append End Game Champions into Team Comp
    fileprivate func appendEndGameChampObjsToTeamComp(_ indexPath: IndexPath, _ cell: TCCell) {
        var endChampObjs = [Champion]()
        for champ in allChampions where allTeamComps[indexPath.row].endGame.contains(where: {$0.name == champ.name}) {
            endChampObjs.append(champ)
        }
        cell.teamComp?.endGameChampObjs = endChampObjs
    }
    
    
    //MARK: Append All Champions into Team Comp
    fileprivate func appendAllChampObjsToTeamComp(_ indexPath: IndexPath, _ teamCompDetailViewController: TCDetailViewController) {
        let selectedTeamComp = allTeamComps[indexPath.row]
        
        var selectedEndGame = [String]()
        selectedTeamComp.endGame.forEach({ selectedEndGame.append($0.name) })
        let merged = Array(Set(selectedEndGame + selectedTeamComp.earlyGame + selectedTeamComp.midGame))
        
        var allChampObjs = [Champion]()
        for champ in allChampions where merged.contains(champ.name) {
            allChampObjs.append(champ)
        }
        teamCompDetailViewController.teamComp?.allChampObjs = allChampObjs.sorted(by: {$0.cost.rawValue > $1.cost.rawValue})
    }
    
    
    //MARK: Append All Classes & Origins to Team Comp
    fileprivate func appendClassesToTeamComp(_ indexPath: IndexPath, _ tcDetailVC: TCDetailViewController) {
        var traitObjs = [Trait]()
        for trait in allClasses where allTeamComps[indexPath.row].synergies.contains(where: {$0.name == trait.name}) {
            traitObjs.append(trait)
        }
        tcDetailVC.teamComp?.classObjs = traitObjs
    }
    
    fileprivate func appendOriginsToTeamComp(_ indexPath: IndexPath, _ tcDetailVC: TCDetailViewController) {
        var traitObjs = [Trait]()
        for trait in allOrigins where allTeamComps[indexPath.row].synergies.contains(where: {$0.name == trait.name}) {
            traitObjs.append(trait)
        }
        tcDetailVC.teamComp?.originObjs = traitObjs
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
        let tcDetailVC = TCDetailViewController()
        tcDetailVC.teamComp = teamComp
        
        appendAllChampObjsToTeamComp(indexPath, tcDetailVC)
        appendClassesToTeamComp(indexPath, tcDetailVC)
        appendOriginsToTeamComp(indexPath, tcDetailVC)
        
        self.navigationController?.pushViewController(tcDetailVC, animated: true)
        tcRootView.tableView.deselectRow(at: indexPath, animated: true)
    }
}
