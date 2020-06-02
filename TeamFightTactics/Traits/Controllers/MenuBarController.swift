//
//  MenuBarController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 22/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class MenuBarController: UIViewController {

    //MARK: Properties
    let menuTitles = ["Classes", "Origins"]
    var traitView: TraitsView?
    let menuView = MenuView()

    
    //MARK:- Load View
    override func loadView() {
        super.loadView()
        self.view = menuView
    }
    

    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuView.menuCollectionView.dataSource = self
        menuView.menuCollectionView.delegate = self
        menuView.menuCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: [])
    }
}


extension MenuBarController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / CGFloat(menuTitles.count), height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        traitView?.scrollToMenuBarIndex(itemIndex: indexPath.item, sectionIndex: indexPath.section)
    }
}


extension MenuBarController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return menuTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuTitles.count / 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseId.menuCell, for: indexPath) as! MenuCell
        cell.menuLabel.text = menuTitles[indexPath.section]
        return cell
    }
}
