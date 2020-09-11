//
//  PNController.swift
//  TeamFightTactics
//
//  Created by Alex Cooper on 24/07/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class PNController: UIViewController {
    
    //MARK:- Properties
    private let patchNotesView = PNView()
    var displayedSet: Int?
    var allPatchNotes = [PatchNote]() {
        didSet {
            patchNotesView.activityIndicator.stopAnimating()
            patchNotesView.patchNotesTableView.reloadData()
        }
    }
    
    
    //MARK:- Load View
    override func loadView() {
        super.loadView()
        self.view = patchNotesView
    }
    
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar(navTitle: TabTitle.teamComps)
        
        // Assign Delegates
        patchNotesView.patchNotesTableView.delegate = self
        patchNotesView.patchNotesTableView.dataSource = self
    }
    
    
    //MARK:- View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchPatchNotes()
    }
    
    
    //MARK:- Fetch Patch Notes
    fileprivate func fetchPatchNotes() {
        let fetchedSet = UserDefaults.standard.integer(forKey: UDKey.setKey)
        if displayedSet != fetchedSet {
            patchNotesView.activityIndicator.startAnimating()
            displayedSet = fetchedSet
            let firestore = FirestoreManager()
            firestore.fetchSetData(from: .patchNotes, updateKey: .patchNotes) { patchNotes in
                self.allPatchNotes = patchNotes.sorted(by: {$0.version > $1.version})
            }
        }
    }
    
    
    //MARK:- Setup Cell BackgroundView
    fileprivate func setupCellBackgroundView(_ cell: PNCell) {
        let backgroundView = UIView()
        backgroundView.backgroundColor = ThemeColor.charcoal
        cell.selectedBackgroundView = backgroundView
    }
}


//MARK:- TableView Data Source
extension PNController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPatchNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PNCell.reuseId, for: indexPath) as! PNCell
        cell.configureCell(with: allPatchNotes[indexPath.row])
        setupCellBackgroundView(cell)
        return cell
    }
}


//MARK:- TableView Delegate
extension PNController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let patchNote = allPatchNotes[indexPath.row]
        let patchNoteDetailVC = PNDetailController(patchNote: patchNote)
        
        self.navigationController?.pushViewController(patchNoteDetailVC, animated: true)
        patchNotesView.patchNotesTableView.deselectRow(at: indexPath, animated: true)
    }
}
