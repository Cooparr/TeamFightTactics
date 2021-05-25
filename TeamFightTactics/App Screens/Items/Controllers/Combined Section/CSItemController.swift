//
//  CSItemController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 19/05/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class CSItemController: UIViewController {
    
    //MARK:- Type Aliases
    fileprivate typealias CollectionViewDiffableDataSource = UICollectionViewDiffableDataSource<CSSection, Item>
    fileprivate typealias Snapshot = NSDiffableDataSourceSnapshot<CSSection, Item>
    
    
    //MARK:- Section Enum
    enum CSSection: Int {
        case selector
        case main
    }
    
    
    //MARK:- Array Actions
    enum UpdateAction {
        case filter
        case reset
    }
    
    
    //MARK:- Properties
    private let csView = CSView()
    private var dataSource: CollectionViewDiffableDataSource?
    
    private var showShadowItems = false
    private var allItems = [Item]()
    private var selectorItems = [Item]()
    private var mainItems = [Item]() {
        willSet {
            csView.placeholderView.hidePlaceholderView(if: newValue.isEmpty)
        }
    }
    
    
    //MARK:- Load View
    override func loadView() {
        super.loadView()
        view = self.csView
    }
    
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        csView.collectionView.delegate = self
        createDataSource()
    }
    
    
    //MARK:- Configure View Controller
    func configureViewController(with items: [Item]) {
        allItems = items
        updateDataSourceArrays(action: .reset)
        reloadSnapshot(animatingDifferences: false)
        csView.showShadowItemsView.displayShadowItemsSwitch()
    }
    
    
    //MARK:- Create Data Source
    private func createDataSource() {
        dataSource = CollectionViewDiffableDataSource(collectionView: csView.collectionView) { collectionView, indexPath, item in
            guard let section = CSSection(rawValue: indexPath.section) else { fatalError("Unknown section") }
            
            switch section {
            case .selector:
                let cell = collectionView.dequeueReusableCell(ItemSelectorCell.self, for: indexPath)
                cell.configureCell(with: item)
                cell.contentView.alpha = cell.selectedAlphaValue
                return cell
            case .main:
                let cell = collectionView.dequeueReusableCell(ItemCell.self, for: indexPath)
                cell.configureCell(with: item)
                return cell
            }
        }
    }
    
    
    //MARK:- Reload Snapshot
    private func reloadSnapshot(animatingDifferences: Bool = true) {
        selectorItems.sort { $0.name < $1.name }
        
        var snapshot = Snapshot()
        snapshot.appendSections([.selector])
        snapshot.appendItems(selectorItems, toSection: .selector)
        
        snapshot.appendSections([.main])
        snapshot.appendItems(mainItems, toSection: .main)
        dataSource?.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    
    //MARK: Show Shadow Item Switch Changed
    @objc func showShadowItemSwitchChanged(_ sender: UISwitch) {
        showShadowItems = sender.isOn
        updateDataSourceArrays(action: .filter)
        reloadSnapshot(animatingDifferences: false)
    }
    

    //MARK: Update Data Source Arrays
    private func updateDataSourceArrays(action: UpdateAction) {
        switch action {
        case .filter:
            selectorItems = allItems.filter { !mainItems.contains($0) }
            if !showShadowItems {
                mainItems.removeAll(where: { $0.isShadow })
                selectorItems.removeAll(where: { $0.isShadow })
            }

        case .reset:
            mainItems.removeAll()
            selectorItems.removeAll()
            selectorItems = showShadowItems ? allItems : allItems.filter { !$0.isShadow }
        }
    }
}


//MARK:- CollectionView Delegate
extension CSItemController: UICollectionViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section == CSSection.selector.rawValue else { return }
        let selectedItem = selectorItems[indexPath.item]
        selectorItems.remove(at: indexPath.item)
        mainItems.insert(selectedItem, at: 0)


        if mainItems.count > 6 {
            guard let lastItem = mainItems.last else { return }
            mainItems.removeLast()
            selectorItems.append(lastItem)
        }

        reloadSnapshot(animatingDifferences: false)
    }
}
