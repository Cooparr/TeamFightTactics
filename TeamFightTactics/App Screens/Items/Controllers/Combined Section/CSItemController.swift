//
//  CSItemController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 19/05/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

#warning("Reloading snapshot with animatingDifferences: false, does display / layout the cells correctly?")
class CSItemController: UIViewController {
    
    //MARK:- Type Aliases
    private typealias CollectionViewDiffableDataSource = UICollectionViewDiffableDataSource<CSSection, Item>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<CSSection, Item>
    
    
    //MARK:- Section Enum
    enum CSSection: Int {
        case selector
        case main
    }
    
    
    //MARK:- Properties
    private let csView = CSView()
    private var dataSource: CollectionViewDiffableDataSource?
    
    private var showVariantItems = false
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
        updateDataSourceArrays()
        reloadSnapshot()
        csView.showShadowItemsView.configureVariantItemsSwitch()
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
    private func reloadSnapshot(animatingDifferences: Bool = false) {
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
        showVariantItems = sender.isOn
        updateDataSourceArrays()
        reloadSnapshot()
    }
    

    //MARK: Update Data Source Arrays
    private func updateDataSourceArrays() {
        mainItems.removeAll()
        switch SettingsManager.getDisplayedSet() {
        case .one, .two, .three, .four, .four_5:
            selectorItems = allItems
        case .five, .latest:
            selectorItems = showVariantItems ? allItems.filter { isVariantItem($0) } : allItems.filter { !isVariantItem($0) }
        }
    }
    
    
    //MARK: Is Variant Item
    private func isVariantItem(_ item: Item) -> Bool {
        return item.isShadow || (item.isRadiant ?? false)
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

        reloadSnapshot()
    }
}
