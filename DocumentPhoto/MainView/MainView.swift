//
//  MainView.swift
//  DocumentPhoto
//
//  Created by Viktor Berezhnytskyi on 03.11.2022.
//

import SwiftUI
import PhotosUI

struct MainView: View {
    
    @StateObject var viewModel: MainViewModel = MainViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.yellow
                VStack {
                    PhotosPicker(
                        selection: $viewModel.selectedItem,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        userImage
                    }
                }
            }
            .ignoresSafeArea()
            .toolbar(.hidden)
        }
    }
    
    @ViewBuilder
    var userImage: some View {
        if let data = viewModel.selectedImageData,
           let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .equalFrame(300)
        } else {
            VStack {
                Text("Choose photo")
                Image(systemName: "plus.square.dashed")
                    .resizable()
                    .equalFrame(100)
                    .fontWeight(.ultraLight)
            }
            .foregroundColor(.black)
        }
    }
}

#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
#endif
