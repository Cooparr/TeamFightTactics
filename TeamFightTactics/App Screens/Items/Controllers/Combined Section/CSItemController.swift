//
//  CSItemController.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 27/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit


//MARK:- Section Enum
enum CSSection: Int, CaseIterable {
    case selector
    case main
}


//MARK:- Type Aliases
fileprivate typealias CollectionViewDiffableDataSource = UICollectionViewDiffableDataSource<CSSection, Item>
fileprivate typealias Snapshot = NSDiffableDataSourceSnapshot<CSSection, Item>


class CSItemController: UIViewController {
    
    //MARK:- Properties
    private let csView = CSView()
    fileprivate var dataSource: CollectionViewDiffableDataSource?
    
    var selectorItems = [Item]() {
        didSet {
            reloadSnapshot()
        }
    }
    
    var mainItems = [Item]() {
        didSet {
            csView.handlePlaceholderView(showPlaceholder: mainItems.isEmpty)
            reloadSnapshot()
        }
    }
    
    
    //MARK:- Load View
    override func loadView() {
        super.loadView()
        view = self.csView
    }
    
    
    //MARK:- View Did Appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        csView.collectionView.scrollToItem(at: IndexPath(item: 20, section: 0), at: [], animated: true)
    }
    
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        csView.collectionView.delegate = self
        createDataSource()
    }
    
    
    //MARK:- Create Data Source
    fileprivate func createDataSource() {
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
    func reloadSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections(CSSection.allCases)
        snapshot.appendItems(selectorItems, toSection: .selector)
        snapshot.appendItems(mainItems, toSection: .main)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}


//MARK:- CollectionView Delegate
extension CSItemController: UICollectionViewDelegate  {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section != CSSection.main.rawValue else { return }
        guard let selectedItem = dataSource?.itemIdentifier(for: indexPath) else { return }
        selectorItems.remove(at: indexPath.item)
        mainItems.insert(selectedItem, at: 0)
        
        if mainItems.count > 6 {
            guard let lastItem = mainItems.last else { return }
            mainItems.removeLast()
            selectorItems.append(lastItem)
            selectorItems.sort(by: { $0.name < $1.name })
        }
    }
}
