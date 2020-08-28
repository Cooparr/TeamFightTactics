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
}
