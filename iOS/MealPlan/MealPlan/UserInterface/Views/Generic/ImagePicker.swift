//
//  ImagePicker.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 05.11.23.
//

import SwiftUI
import PhotosUI

struct ImagePicker: View {
    @State private var selection = [PhotosPickerItem]()
    @State private var loadedImageDataByIdentifier = [String: Data]() {
        didSet {
            selectedImageData = Array(loadedImageDataByIdentifier.values)
        }
    }
    
    @Binding var selectedImageData: [Data]
    
    var body: some View {
        PhotosPicker(
            selection: $selection,
            selectionBehavior: .continuousAndOrdered,
            matching: .images,
            preferredItemEncoding: .current,
            photoLibrary: .shared()
        ) {
            Text("Select Photos")
        }
        .photosPickerStyle(.inline)
        .photosPickerDisabledCapabilities(.selectionActions)
        .photosPickerAccessoryVisibility(.hidden, edges: .bottom)
        .ignoresSafeArea()
        .onChange(of: selection) { oldValue, newValue in
            let newImages = selection.filter { pickerItem in
                loadedImageDataByIdentifier[pickerItem.identifier] == nil
            }
            Task {
                for pickerItem in newImages {
                    do {
                        if let data = try await pickerItem.loadTransferable(type: Data.self) {
                            loadedImageDataByIdentifier[pickerItem.identifier] = data
                        } else {
                            throw LoadingError.contentTypeNotSupported
                        }
                    } catch {
                        print("Do show Banner!")
                        selection.removeAll { item in
                            item.identifier == pickerItem.identifier
                        }
                    }
                }
            }
        }
    }
    
    enum LoadingError: Error {
        case contentTypeNotSupported
    }
}

/// A extension that handles the situation in which a picker item lacks a photo library.
private extension PhotosPickerItem {
    var identifier: String {
        guard let identifier = itemIdentifier else {
            fatalError("The photos picker lacks a photo library.")
        }
        return identifier
    }
}


#Preview {
    ImagePicker(selectedImageData: .constant([]))
}
