//
//  Extension+UIImage.swift
//  DocumentPhoto
//
//  Created by Viktor Berezhnytskyi on 03.11.2022.
//

import UIKit

extension UIImage {
    
    var cgImageWithCorrectOrientation: CGImage? {
        var result: CGImage?
        
        switch self.imageOrientation {
        case .up:            result = self.cgImage
        case .down:          result = self.cgImage?.rotating(to: .down)
        case .left:          result = self.cgImage?.rotating(to: .left)
        case .right:         result = self.cgImage?.rotating(to: .right)
        case .upMirrored:    result = self.cgImage?.rotating(to: .upMirrored)
        case .downMirrored:  result = self.cgImage?.rotating(to: .downMirrored)
        case .leftMirrored:  result = self.cgImage?.rotating(to: .leftMirrored)
        case .rightMirrored: result = self.cgImage?.rotating(to: .rightMirrored)
        @unknown default:
            Log("Error", state: .error)
        }
        
        return result
    }
}
