//
//  TestCellExpand.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 01/08/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

//import UIKit
//
//protocol ExpandedCellDelegate:NSObjectProtocol{
//    func topButtonTouched(indexPath:IndexPath)
//}
//
//class ExpandableCell: UICollectionViewCell {
//    
//    weak var delegate:ExpandedCellDelegate?
//    
//    public var indexPath:IndexPath!
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupCellContent()
//    }
//    
//    
//    lazy var topButton: UIButton = {
//        let btn = UIButton(type: .system)
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.setTitle("Show More", for: .normal)
//        btn.addTarget(self, action: #selector(topButtonTouched), for: .touchUpInside)
//        return btn
//    }()
//    
//    
//    
//    @objc func topButtonTouched(_ sender: UIButton) {
//        print("Tapped")
//        if let delegate = self.delegate{
//            delegate.topButtonTouched(indexPath: indexPath)
//        }
//    }
//    
//    fileprivate func setupCellContent() {
//        contentView.addSubview(topButton)
//        topButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        topButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        
//    }
//    
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
