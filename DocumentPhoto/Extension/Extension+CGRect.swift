//
//  Extension+CGRect.swift
//  DocumentPhoto
//
//  Created by Viktor Berezhnytskyi on 04.11.2022.
//

import Foundation

extension CGRect {
    
    // Create CGRect with size and place this rectangle center on center coordinates.
    init(center: CGPoint, size: CGSize) {
        self.init(
            origin: CGPoint(
                x: center.x - size.width / 2,
                y: center.y - size.height / 2),
            size: size)
    }
    
    var center: CGPoint {
        CGPoint(x: origin.x + size.width / 2, y: origin.y + size.height / 2)
    }
    
    func padding(_ padding: CGFloat = 75) -> CGRect {
        let half: CGFloat = padding / 2
        
        return CGRect(
            x: self.origin.x - half,
            y: self.origin.y - half,
            width: self.width + padding,
            height: self.height + padding
        )
    }
}
