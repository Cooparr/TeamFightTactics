//
//  CustomChampion.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 07/12/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import Foundation

//MARK:- Custom Champion
struct CustomChampion: Codable, Equatable {
    
    //MARK: Properties
    let name: String
    let key: String
    let imgURL: String
    var items = [String]()
    let cost: Cost
    let origins: [String]
    let classes: [String]
    
    
    //MARK: Add Item to Champ
    mutating func addToItemToChamp(_ itemName: String, index: Int) {
        items.indices.contains(index) ? items[index] = itemName : items.append(itemName)
    }
}
