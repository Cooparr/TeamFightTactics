//
//  MoreTabCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 13/05/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class MoreTabCell: UITableViewCell {
    
    //MARK:- Properties
    var moreTab: TabItem? {
        didSet {
            guard
                let title: String = moreTab?.title,
                let image: UIImage = moreTab?.image
                else { return }

            updateCellContent(title, image)
        }
    }
    
    
    //MARK:- Override Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupTabCell()
    }
    
    
    //MARK:- Setup Tab Cell
    fileprivate func setupTabCell() {
        accessoryType = .disclosureIndicator
        backgroundColor = ThemeColor.richBlack
    }
    
    
    //MARK:- Update Cell Content
    fileprivate func updateCellContent(_ title: String, _ image: UIImage) {
        textLabel?.text = title
        textLabel?.textColor = ThemeColor.platinum
        
        imageView?.image = image
        imageView?.tintColor = ThemeColor.platinum
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
