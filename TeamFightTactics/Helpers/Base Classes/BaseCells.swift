//
//  BaseCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 03/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

//MARK: Reusable Cell Protocol
protocol ReusableCell {
    associatedtype DataType
    static var reuseId: String { get }
    func configureCell(with data: DataType)
}


//MARK: Base Collection View Cell
class BaseColViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupCellViews()
    }
    
    func setupCell() {}
    func setupCellViews() {}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: Base Table View Cell
class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupCellViews()
    }
    
    func setupCell() {}
    func setupCellViews() {}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
