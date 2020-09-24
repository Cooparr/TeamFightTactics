//
//  StackViewContentUpdater.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 04/08/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class StackViewContentUpdater<Item, View> where Item : Equatable, View : UIView {
    
    //MARK: Properties
    let stackView: UIStackView
    private(set) var items = [Item]()
    private var itemViews = [View]()
    
    typealias MakeView = () -> View
    typealias UpdateView = (Item, View) -> Void
    private let makeView: MakeView
    private let updateForItem: UpdateView
    
    
    //MARK:- Init
    init(stackView: UIStackView, makeView: @escaping MakeView, updateForItem: @escaping UpdateView) {
        self.stackView = stackView
        
        self.makeView = makeView
        self.updateForItem = updateForItem
    }
    
    
    //MARK:- Set Items
    func setItems(_ newItems: [Item]) {
        guard newItems != self.items else { return }
        
        for (index, newItem) in newItems.enumerated() {
            if index >= self.items.endIndex {
                let newItemView = self.makeView()
                self.itemViews.append(newItemView)
                self.items.append(newItem)
                
                self.updateForItem(newItem, newItemView)
                
                self.stackView.addArrangedSubview(newItemView)
            } else {
                if self.items[index] != newItem {
                    self.items[index] = newItem
                    let currentItemView = self.itemViews[index]
                    self.updateForItem(newItem, currentItemView)
                }
            }
        }
        handleOverflow(newItems)
    }
    
    
    //MARK: Handle Overflow
    fileprivate func handleOverflow(_ newItems: [Item]) {
        let overflow = self.items.count - newItems.count
        if overflow > 0 {
            self.items.removeLast(overflow)
            let removedIndices: PartialRangeFrom<Int> = (self.itemViews.endIndex - overflow)...
            let removed = self.itemViews[removedIndices]
            self.itemViews[removedIndices] = []
            for rem in removed {
                rem.removeFromSuperview()
            }
        }
    }
    
    
    //MARK: Force Update
    func forceUpdate() {
        for (item, itemView) in zip(items, itemViews) {
            self.updateForItem(item, itemView)
        }
    }
}
