//
//  BaseCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 03/06/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

protocol ReusableCell {
    associatedtype DataType
    static var reuseId: String { get }
    func configureCell(with data: DataType)
}

class BaseCell: UICollectionViewCell {
    
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
