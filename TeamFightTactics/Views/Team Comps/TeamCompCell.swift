//
//  TeamCompCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 17/10/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit

class TeamCompCell: UITableViewCell {
    
    var teamComp: TeamComposition? {
        didSet {
            guard
                let title = teamComp?.title
                else { return }
            
            testLabel.text = title
        }
    }
    
    //MARK:- Override Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        

        self.addSubview(testLabel)
        testLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        testLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        testLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        testLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    
    let testLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        return label
    }()
    
    
    // Required
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
