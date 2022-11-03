//
//  Extension+CGSize.swift
//  DocumentPhoto
//
//  Created by Viktor Berezhnytskyi on 03.11.2022.
//

import UIKit

extension CGSize {
    static func equalSize(_ size: CGFloat) -> CGSize {
        CGSize(width: size, height: size)
    }
}
