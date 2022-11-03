//
//  MainViewModel.swift
//  DocumentPhoto
//
//  Created by Viktor Berezhnytskyi on 03.11.2022.
//

import SwiftUI
import PhotosUI

final class MainViewModel: ObservableObject {
    
    @Published var uiImage: UIImage? = nil
    @Published var selectedItem: PhotosPickerItem? = nil {
        didSet {
            parsePhotosPickerItem(selectedItem)
        }
    }
    
    private func parsePhotosPickerItem(_ item: PhotosPickerItem?) {
        selectedItem?.loadTransferable(type: Data.self) { result in
            switch result {
            case .success(let imageData):
                if let imageData {
                    DispatchQueue.main.async {
                        self.uiImage = UIImage(data: imageData)
                    }
                }
            case .failure(let error):
                Log(error)
            }
        }
    }
}

