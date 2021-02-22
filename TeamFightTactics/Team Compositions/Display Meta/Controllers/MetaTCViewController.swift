//
//  MetaTCViewController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 15/10/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit
import FirebaseFirestore

class MetaTCViewController: UIViewController {
    
    //MARK:- Properties
    private let metaTCView = MetaTCView()
    var displayedSet: Int?
    var allTeamComps = [TeamComposition]() {
        didSet {
            metaTCView.activityIndicator.stopAnimating()
        }
    }
    
    var useSetSkins: Bool? = nil {
        didSet {
            guard useSetSkins != oldValue else { return }
            updateChampImages()
        }
    }
    
    
    //MARK:- Load View
    override func loadView() {
        super.loadView()
        self.view = metaTCView
    }
    
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar(navTitle: TabTitle.teamComps)
        
        // Assign Delegates
        metaTCView.tableView.delegate = self
        metaTCView.tableView.dataSource = self
    }
    
    
    //MARK:- View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        useSetSkins = UserDefaults.standard.bool(forKey: UDKey.skinsKey)
        fetchTeamComps()
    }
    
    
    //MARK:- Fetch Team Comps
    fileprivate func fetchTeamComps() {
        let fetchedSet = UserDefaults.standard.integer(forKey: UDKey.setKey)
        if displayedSet != fetchedSet {
            metaTCView.activityIndicator.startAnimating()
            displayedSet = fetchedSet
            let firestore = FirestoreManager()
            firestore.fetchSetData(from: .teamComps, updateKey: .teamComps) { (teamComps: [TeamComposition]) in
                firestore.fetchSetData(from: .champions, updateKey: .champs) { (champions: [Champion]) in
                    firestore.fetchSetData(from: .classes, updateKey: .classes) { (classes: [Trait]) in
                        firestore.fetchSetData(from: .origins, updateKey: .origins) { (origins: [Trait]) in
                            let sortedChamps = champions.sorted(by: {$0.cost.rawValue < $1.cost.rawValue})
                            self.allTeamComps = teamComps.sorted(by: { $0.tier.rawValue < $1.tier.rawValue })
                            self.addEndGameChampObjsToTeamComp(with: sortedChamps)
                            self.addAllChampObjsToTeamComp(with: sortedChamps)
                            self.addTraitObjsToTeamComp(with: classes + origins)
                            self.metaTCView.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    
    //MARK: Update Visible Cell Champ Images
    fileprivate func updateChampImages() {
        for cell in metaTCView.tableView.visibleCells {
            guard let cell = cell as? TCCell else { return }
            cell.champStackUpdater.forceUpdate()
        }
    }
    
    
    //MARK: Append End Game Champions into Team Comp
    fileprivate func addEndGameChampObjsToTeamComp(with champions: [Champion]) {
        for teamComp in allTeamComps {
            teamComp.endGameChampObjs = champions.filter { champ in
                teamComp.endGame.contains(where: {$0.name == champ.name})
            }
        }
    }
    
    
    //MARK: Append All Champions into Team Comp
    fileprivate func addAllChampObjsToTeamComp(with champions: [Champion]) {
        for teamComp in allTeamComps {
            let merged = Array(Set(teamComp.endGame.map { $0.name } + teamComp.earlyGame + teamComp.midGame))
            teamComp.allChampObjs = champions.filter { champ in
                merged.contains(champ.name)
            }
        }
    }
    
    
    //MARK: Append All Classes & Origins to Team Comp
    fileprivate func addTraitObjsToTeamComp(with traits: [Trait]) {
        for teamComp in allTeamComps {
            teamComp.traitObjs = traits.filter { trait in
                teamComp.synergies.contains(where: { $0.name == trait.name })
            }
        }
    }
}


//MARK:- TableView Data Source
extension MetaTCViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTeamComps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TCCell.reuseId, for: indexPath) as! TCCell
        cell.configureCell(teamComp: allTeamComps[indexPath.row])
        return cell
    }
}


//MARK:- TableView Delegate
extension MetaTCViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let teamComp = allTeamComps[indexPath.row]
        let tcDetailVC = TCDetailViewController()
        tcDetailVC.configureTCDetailVC(with: teamComp)
        
        self.navigationController?.pushViewController(tcDetailVC, animated: true)
        metaTCView.tableView.deselectRow(at: indexPath, animated: true)
    }
}
