//
//  AutomaticEditViewModel.swift
//  DocumentPhoto
//
//  Created by Viktor Berezhnytskyi on 03.11.2022.
//

import Vision
import UIKit

final class AutomaticEditViewModel: ObservableObject {
    
    @Published var processedImage: UIImage? = nil
    
    let uiImage: UIImage
    
    init(uiImage: UIImage) {
        self.uiImage = uiImage
    }
    
    private var cgImageWithCorrectOrientation: CGImage? {
        uiImage.cgImageWithCorrectOrientation
    }
    
    func processFaceDetection() {
        guard let cgImage = cgImageWithCorrectOrientation else { return }
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage)
//        let request = VNDetectFaceLandmarksRequest(completionHandler: faceLandmarksHandler)
        let requestRect = VNDetectFaceRectanglesRequest(completionHandler: faceRectanglesHandler)
        
        do {
            try requestHandler.perform([requestRect])
        } catch {
            Log("Unable to perform the request: \(error). LocalizedDescription - \(error.localizedDescription)", state: .error)
        }
    }
    
    private func faceLandmarksHandler(request: VNRequest, error: Error?) {
        guard
            let observations = request.results as? [VNFaceObservation],
            let cgImage = cgImageWithCorrectOrientation
        else { return }
        
        let points = observations
            .compactMap { $0.landmarks?.allPoints?.pointsInImage(imageSize: uiImage.size) }
            .flatMap { $0 }
        
        if let imageWithDots = cgImage.overlayDots(diameter: 15, at: points) {
            DispatchQueue.main.async {
                self.processedImage = UIImage(cgImage: imageWithDots)
//                self.processedImage = UIImage(cgImage: imageWithDots.cropping(to: <#T##CGRect#>))
            }
        } else {
            Log("Error: drawPoints == nil", state: .error)
        }
    }
    
    private func faceRectanglesHandler(request: VNRequest, error: Error?) {
        guard
            let observations = request.results as? [VNFaceObservation],
            let cgImage = cgImageWithCorrectOrientation
        else { return }
        
        let rects = observations
            .compactMap { $0.boundingBox }
            .map { VNImageRectForNormalizedRect($0, cgImage.width, cgImage.height) }
        
        if let imageWithDots = cgImage.overlayRects(rects) {
            DispatchQueue.main.async {
                self.processedImage = UIImage(cgImage: imageWithDots)
            }
        } else {
            Log("Error: drawPoints == nil", state: .error)
        }
    }
}
