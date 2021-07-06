//
//  CollectionViewExtension.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 23/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

extension UICollectionView {
    func dequeueReusableCell<T: ReusableCell>(_ cellType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Collection View Cell of Type: \(cellType)")
        }
        return cell
    }
    
    
    //MARK: Should Display Empty Message If
    func shouldDisplayEmptyMessage(if isEmpty: Bool, message: String) {
        guard isEmpty else { return self.backgroundView = nil }
        self.setEmptyMessage(message)
    }
    
    
    //MARK: Set Empty Message
    private func setEmptyMessage(_ message: String) {
        let emptyMessage = BaseLabel(fontSize: 18, fontWeight: .medium, multiLine: true)
        emptyMessage.text = message
        emptyMessage.textAlignment = .center
        self.backgroundView = emptyMessage
    }
    
    
    //MARK: Reload Data On Main Thread
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
}
