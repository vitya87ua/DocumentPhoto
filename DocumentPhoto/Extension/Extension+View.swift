//
//  Extension+View.swift
//  DocumentPhoto
//
//  Created by Viktor Berezhnytskyi on 03.11.2022.
//

import SwiftUI

extension View {
    
    /// .equalFrame(100) is the same as  .frame(width: 100, height: 100)
    func equalFrame(_ size: CGFloat) -> some View {
        self.frame(width: size, height: size, alignment: .center)
    }
}
