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
            // TODO: delete the unselected values!
            selectedImageData = Array(loadedImageDataByIdentifier.filter { (key: String, value: Data) in
                selection.contains { $0.identifier == key }
            }.values)
        }
    }
    let selectionCount: Int
    
    @Binding var selectedImageData: [Data]
    
    var body: some View {
        PhotosPicker(
            selection: $selection,
            maxSelectionCount: selectionCount,
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
            
            // TODO: delete the unselected values!
            let deletedItems = newValue.difference(from: oldValue)
            
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
    ImagePicker(selectionCount: 3, selectedImageData: .constant([]))
}
