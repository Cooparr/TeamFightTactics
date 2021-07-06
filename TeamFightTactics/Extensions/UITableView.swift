//
//  TableViewExtension.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 28/08/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: ReusableCell>(_ cellType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: cellType.reuseId, for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell of Type: \(cellType)")
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
        emptyMessage.sizeToFit()
        
        let messageContainer = UIView()
        messageContainer.addSubview(emptyMessage)
        emptyMessage.pinSubview(to: messageContainer)
        
        self.backgroundView = messageContainer
    }
    
    
    //MARK: Reload Data On Main Thread
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
    
    
    //MARK: Remove Excess Cells
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
    
    
    //MARK: Remove Excess Cells
    func insertRowsWithUpdates(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation = .automatic) {
        self.beginUpdates()
        self.insertRows(at: indexPaths, with: animation)
        self.endUpdates()
    }
}
