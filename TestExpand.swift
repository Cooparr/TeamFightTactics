//
//  TestExpand.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 01/08/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//
import UIKit

class CollectionTestController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var expandedCellIdentifier = "ExpandableCell"
    
    var cellWidth:CGFloat {
        return collectionView.frame.size.width
    }
    var expandedHeight : CGFloat = 200
    var notExpandedHeight : CGFloat = 50
    
    var dataSource = ["data0","data1","data2","data3","data4"]
    var isExpanded = [Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        isExpanded = Array(repeating: false, count: dataSource.count)
    }
    
    func setupCollectionView() {
        collectionView?.register(ExpandableCell.self, forCellWithReuseIdentifier: expandedCellIdentifier)
        let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.scrollDirection = .vertical
        layout?.minimumLineSpacing = 6
    }
    
}


extension CollectionTestController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: expandedCellIdentifier, for: indexPath) as! ExpandableCell
        cell.indexPath = indexPath
        cell.delegate = self
        
        //configure Cell
        cell.backgroundColor = .red
        
        return cell
        
    }
}

extension CollectionTestController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if isExpanded[indexPath.row] == true{
            return CGSize(width: cellWidth, height: expandedHeight)
        }else{
            return CGSize(width: cellWidth, height: notExpandedHeight)
        }
        
    }
    
}

extension CollectionTestController:ExpandedCellDelegate{
    func topButtonTouched(indexPath: IndexPath) {
        isExpanded[indexPath.row] = !isExpanded[indexPath.row]
        UIView.animate(withDuration: 0, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.collectionView.reloadItems(at: [indexPath])
        }, completion: { success in
            print("success")
        })
    }
}
