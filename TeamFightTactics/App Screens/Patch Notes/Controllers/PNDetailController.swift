//
//  PNDetailController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 10/07/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class PNDetailController: UIViewController, UIScrollViewDelegate {
    
    //MARK:- Properties
    var patchNote: PatchNote
    fileprivate let pnDetailView = PNDetailView()
    
    
    //MARK:- Init
    init(patchNote: PatchNote) {
        self.patchNote = patchNote
        super.init(nibName: nil, bundle: nil)
    }
    
    
    //MARK:- Load View
    override func loadView() {
        super.loadView()
        self.view = pnDetailView
    }
    
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Patch: \(patchNote.version)"
        configureSections(patchNote)
    }
    
    
    //MARK:- Configure Sections
    fileprivate func configureSections(_ patchNote: PatchNote) {
        patchNote.notes.forEach { note in
            let newSection = PNSectionStack(axis: .vertical, spacing: 6)
            newSection.configureSection(title: note.title, devNote: note.devNote)
            
            note.changes?.forEach { change in
                let changeView = PNChangeView(backgroundColor: ThemeColor.charcoal, cornerRadius: 4)
                changeView.configureChangeView(with: change)
                newSection.changesStack.addArrangedSubview(changeView)
            }
            
            pnDetailView.scrollViewContainer.addArrangedSubview(newSection)
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
