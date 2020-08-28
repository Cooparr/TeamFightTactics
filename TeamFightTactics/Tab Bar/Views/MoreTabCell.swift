//
//  MoreTabCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 13/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class MoreTabCell: BaseTableViewCell, ReusableCell {
    
    //MARK:- Properties
    typealias DataType = TabItem
    static var reuseId: String = "moreCellId"
    
    
    //MARK:- Configure Cell
    func configureCell(with tab: TabItem) {
        textLabel?.text = tab.title
        textLabel?.textColor = ThemeColor.platinum
        imageView?.image = tab.image
        imageView?.tintColor = ThemeColor.platinum
    }
    
    
    //MARK:- Setup Cell
    override func setupCell() {
        accessoryType = .disclosureIndicator
        backgroundColor = ThemeColor.richBlack
    }
}
