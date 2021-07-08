//
//  UIFont.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 07/07/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

extension UIFont {
    
    //MARK: Preferred Font + Weight
    static func preferredFont(for style: TextStyle, weight: Weight) -> UIFont {
        let metrics = UIFontMetrics(forTextStyle: style)
        let desc = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        let font = UIFont.systemFont(ofSize: desc.pointSize, weight: weight)
        return metrics.scaledFont(for: font)
    }
}
