//
//  CSCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 16/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class CSCell: BaseColViewCell, ReusableCell{
    
    //MARK:- Properties
    typealias DataType = [Item]
    static var reuseId: String = "combinedSectionId"
    let combinedSectionController = CSItemController()
    
    
    //MARK:- Setup Cell
    override func setupCellViews() {
        addSubview(combinedSectionController.view)
        combinedSectionController.view.translatesAutoresizingMaskIntoConstraints = false
        combinedSectionController.view.pinSubview(to: self)
    }
    
    
    //MARK:- Configure Cell
    func configureCell(with items: [Item]) {
        self.combinedSectionController.selectorItems = items
        self.combinedSectionController.mainItems.removeAll()
    }
}
