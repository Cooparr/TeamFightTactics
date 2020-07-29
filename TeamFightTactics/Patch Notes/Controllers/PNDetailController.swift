//
//  PNDetailControllerAgain.swift
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
            let newSection = PNSectionStack()
            newSection.sectionName.text = note.title
            
            note.changes.forEach { change in
                let changeView = PNChangeView()
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


class PNDetailView: BaseView {

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = ThemeColor.richBlack
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    let scrollViewContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()


    override func setupView() {
        addSubview(scrollView)
        pinSubview(to: scrollView)
    }
    
    override func setupSubviews() {
        scrollView.addSubview(scrollViewContainer)
        NSLayoutConstraint.activate([
            scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15),
            scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -15)
        ])
    }
}
