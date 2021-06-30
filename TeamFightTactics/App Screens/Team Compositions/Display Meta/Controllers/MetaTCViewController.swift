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
    private(set) var teamComps = [TeamComposition]()
    
    
    //MARK:- Firestore Listeners
    private(set) var teamCompsListener: ListenerRegistration?
    private(set) var champsListener: ListenerRegistration?
    private(set) var originsListener: ListenerRegistration?
    private(set) var classesListener: ListenerRegistration?
    
    
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
        fetchTeamComps()
        updateChampImages()
    }
    
    
    //MARK:- View Will Disappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        teamCompsListener?.remove()
        champsListener?.remove()
        originsListener?.remove()
        classesListener?.remove()
    }
    
    
    //MARK:- Fetch Team Comps
    private func fetchTeamComps() {
        metaTCView.activityIndicator.startAnimating()
        let firestore = SetDataManager()
        self.teamCompsListener = firestore.fetchData(from: .teamComps) { (teamCompsResult: Result<[TeamComposition], Error>) in
            self.champsListener = firestore.fetchData(from: .champions) { (champsResult: Result<[Champion], Error>) in
                self.originsListener = firestore.fetchData(from: .origins) { (originsResult: Result<[Trait], Error>) in
                    self.classesListener = firestore.fetchData(from: .classes) { (classesResult: Result<[Trait], Error>) in
                        do {
                            self.teamComps = try teamCompsResult.get().sorted(by: { $0.tier.rawValue < $1.tier.rawValue })
                            let champs = try champsResult.get().sorted(by: {$0.cost.rawValue < $1.cost.rawValue})
                            let origins = try originsResult.get()
                            let classes = try classesResult.get()
                            
                            self.addEndGameChampObjsToTeamComp(with: champs)
                            self.addAllChampObjsToTeamComp(with: champs)
                            self.addTraitObjsToTeamComp(with: classes + origins)
                            self.metaTCView.tableView.reloadDataOnMainThread()
                        } catch let error {
                            self.presentErrorAlertOnMainThread(title: "Error Fetching Team Comps", message: error.localizedDescription)
                        }
                        
                        self.metaTCView.activityIndicator.stopAnimating()
                    }
                }
            }
        }
    }
    
    
    //MARK: Update Visible Cell Champ Images
    private func updateChampImages() {
        for cell in metaTCView.tableView.visibleCells {
            guard let cell = cell as? TCCell else { return }
            cell.champStackUpdater.forceUpdate()
        }
    }
    
    
    //MARK: Append End Game Champions into Team Comp
    private func addEndGameChampObjsToTeamComp(with champions: [Champion]) {
        for teamComp in teamComps {
            teamComp.endGameChampObjs = champions.filter { champ in
                teamComp.endGame.contains(where: {$0.name == champ.name})
            }
        }
    }
    
    
    //MARK: Append All Champions into Team Comp
    private func addAllChampObjsToTeamComp(with champions: [Champion]) {
        for teamComp in teamComps {
            let merged = Array(Set(teamComp.endGame.map { $0.name } + teamComp.earlyGame + teamComp.midGame))
            teamComp.allChampObjs = champions.filter { champ in
                merged.contains(champ.name)
            }
        }
    }
    
    
    //MARK: Append All Classes & Origins to Team Comp
    private func addTraitObjsToTeamComp(with traits: [Trait]) {
        for teamComp in teamComps {
            teamComp.traitObjs = traits.filter { trait in
                teamComp.synergies.contains(where: { $0.name == trait.name })
            }
        }
    }
}


//MARK:- TableView Data Source
extension MetaTCViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamComps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TCCell.reuseId, for: indexPath) as! TCCell
        cell.configureCell(teamComp: teamComps[indexPath.row])
        return cell
    }
}


//MARK:- TableView Delegate
extension MetaTCViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let teamComp = teamComps[indexPath.row]
        let tcDetailVC = TCDetailViewController()
        tcDetailVC.configureTCDetailVC(with: teamComp)
        
        self.navigationController?.pushViewController(tcDetailVC, animated: true)
        metaTCView.tableView.deselectRow(at: indexPath, animated: true)
    }
}
