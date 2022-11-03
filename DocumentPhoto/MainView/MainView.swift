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
                VStack(spacing: 20) {
                    PhotosPicker(
                        selection: $viewModel.selectedItem,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        userImage
                    }
                    
                    if let uiImage = viewModel.uiImage {
                        NavigationLink {
                            AutomaticEditView(
                                viewModel: AutomaticEditViewModel(
                                    uiImage: uiImage
                                )
                            )
                        } label: {
                            Text("NEXT")
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .padding(.vertical, 4)
                                .background(Color.black)
                                .cornerRadius(5)
                        }
                    }
                }
            }
            .ignoresSafeArea()
            .toolbar(.hidden)
        }
    }
    
    @ViewBuilder
    var userImage: some View {
        if let uiImage = viewModel.uiImage {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
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
