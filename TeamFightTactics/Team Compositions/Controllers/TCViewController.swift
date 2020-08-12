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
    var allTraits = [Trait]()
    var allTeamComps = [TeamComposition]() {
        didSet {
            handleSpinner(spin: tcRootView.activityIndicator, if: allTeamComps.isEmpty)
            addEndGameChampObjsToTeamComp()
            addAllChampObjsToTeamComp()
            addTraitObjsToTeamComp()
            tcRootView.tableView.reloadData()
        }
    }
    
    var useSetSkins: Bool? = nil {
        didSet {
            guard useSetSkins != oldValue else { return }
            updateVisibleCellChampImages()
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
    }
    
    
    //MARK:- View Did Appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
    
    
    //MARK: Update Visible Cell Champ Images
    fileprivate func updateVisibleCellChampImages() {
        for cell in tcRootView.tableView.visibleCells {
            guard let cell = cell as? TCCell else { return }
            cell.champStackUpdater.forceUpdate()
        }
    }
    
    
    //MARK: Append End Game Champions into Team Comp
    fileprivate func addEndGameChampObjsToTeamComp() {
        for teamComp in allTeamComps {
            for champ in allChampions where teamComp.endGame.contains(where: {$0.name == champ.name}) {
                teamComp.endGameChampObjs.append(champ)
            }
        }
    }
    
    
    //MARK: Append All Champions into Team Comp
    fileprivate func addAllChampObjsToTeamComp() {
        for teamComp in allTeamComps {
            var selectedEndGame = [String]()
            teamComp.endGame.forEach({ selectedEndGame.append($0.name) })
            let merged = Array(Set(selectedEndGame + teamComp.earlyGame + teamComp.midGame))
            
            for champ in allChampions where merged.contains(champ.name) {
                teamComp.allChampObjs.append(champ)
            }
            teamComp.allChampObjs.sort(by: { $0.cost.rawValue > $1.cost.rawValue })
        }
    }
    
    
    //MARK: Append All Classes & Origins to Team Comp
    fileprivate func addTraitObjsToTeamComp() {
        for teamComp in allTeamComps {
            for trait in allTraits where teamComp.synergies.contains(where: { $0.name == trait.name }) {
                teamComp.traitObjs.append(trait)
            }
        }
    }
}


//MARK:- TableView Data Source
extension TCViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTeamComps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TCCell.reuseId, for: indexPath) as! TCCell
        setupCellBackgroundView(cell)
        cell.configureCell(teamComp: allTeamComps[indexPath.row])
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
        tcDetailVC.configureTCDetailVC(with: teamComp)
        
        self.navigationController?.pushViewController(tcDetailVC, animated: true)
        tcRootView.tableView.deselectRow(at: indexPath, animated: true)
    }
}
