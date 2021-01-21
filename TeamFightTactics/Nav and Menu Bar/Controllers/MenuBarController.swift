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
    let menuTitles: [MenuBarTitle]
    var selectedView: UICollectionView?
    var scrollView: UIScrollView?
    let menuView = MenuView(tamic: false)

    
    //MARK:- Required Init
    required init(menuTitles: [MenuBarTitle]) {
        self.menuTitles = menuTitles
        super.init(nibName: nil, bundle: nil)
    }
    
    
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
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension MenuBarController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / CGFloat(menuTitles.count), height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedView?.scrollToMenuBarIndex(itemIndex: indexPath.section, sectionIndex: indexPath.item)
        
        guard let scrollView = scrollView else { return }
        let xValue = scrollView.frame.maxX * CGFloat(indexPath.section)
        let rectToScrollTo = CGRect(x: xValue, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        scrollView.scrollRectToVisible(rectToScrollTo, animated: true)
    }
}


extension MenuBarController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return menuTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.reuseId, for: indexPath) as! MenuCell
        cell.menuLabel.text = menuTitles[indexPath.section].rawValue
        return cell
    }
}


extension UICollectionView {
    func scrollToMenuBarIndex(itemIndex: Int, sectionIndex: Int) {
        let indexPath = IndexPath(item: sectionIndex, section: itemIndex)
        self.scrollToItem(at: indexPath, at: [], animated: true)
    }
}
