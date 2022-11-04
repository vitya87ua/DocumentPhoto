//
//  AutomaticEditView.swift
//  DocumentPhoto
//
//  Created by Viktor Berezhnytskyi on 03.11.2022.
//

import SwiftUI

struct AutomaticEditView: View {
    
    @StateObject var viewModel: AutomaticEditViewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Image(uiImage: viewModel.uiImage)
//                Image(uiImage: UIImage(cgImage: (UIImage(named: "port")!.cgImage?.overlayRects([.init(center: CGPoint(x: 100, y: 100), size: .init(width: 20, height: 30))]))!))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Button("PROCESS") {
                    viewModel.processFaceDetection()
                }
                .buttonStyle(.borderedProminent)
                .tint(.black)
                
                if let uiImage = viewModel.processedImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .border(Color.red, width: 1)
                }
            }
            .padding(.horizontal)
        }
    }
}

#if DEBUG
struct AutomaticEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AutomaticEditView(
                viewModel: AutomaticEditViewModel(
                    uiImage: UIImage(named: "port")!
                )
            )
        }
    }
}
#endif
