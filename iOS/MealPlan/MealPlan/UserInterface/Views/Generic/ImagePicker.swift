//
//  ImagePicker.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 05.11.23.
//

import SwiftUI
import PhotosUI

//@MainActor final class ImageAttachment: ObservableObject, Identifiable {
//    enum Status {
//        case loading
//        case finished(Image)
//        case failed(Error)
//        
//        var isFailed: Bool {
//            return switch self {
//            case .failed: true
//            default: false
//            }
//        }
//    }
//    
//    enum LoadingError: Error {
//        case contentTypeNotSupported
//    }
//    
//    private let pickerItem: PhotosPickerItem
//    var imageStatus: Status?
//    var imageDescription: String = ""
//    
//    nonisolated var id: String {
//        pickerItem.identifier
//    }
//    
//    init(pickerItem: PhotosPickerItem) {
//        self.pickerItem = pickerItem
//    }
//    
//    func loadImage() async {
//        guard imageStatus == nil || imageStatus?.isFailed == true else {
//            return
//        }
//        imageStatus = .loading
//        do {
//            if let data = try await pickerItem.loadTransferable(type: Data.self),
//               let uiImage = UIImage(data: data) {
//                imageStatus = .finished(Image(uiImage: uiImage))
//            } else {
//                throw LoadingError.contentTypeNotSupported
//            }
//        } catch {
//            imageStatus = .failed(error)
//        }
//    }
//}

struct ImagePicker: View {
//    @MainActor @State var selection = [PhotosPickerItem]() {
//        didSet {
//            let newAttachments = selection.map { item in
//                attachmentByIdentifier[item.identifier] ?? ImageAttachment(pickerItem: item)
//            }
//            let newAttachmentByIdentifier = newAttachments.reduce(into: [:]) { partialResult, attachment in
//                partialResult[attachment.id] = attachment
//            }
//            // To support asynchronous access, assign new arrays to the instance properties rather than updating the existing arrays.
//            attachments = newAttachments
//            attachmentByIdentifier = newAttachmentByIdentifier
//        }
//    }
//    
    @State var selection = [PhotosPickerItem]()
    
//    @State var attachments = [ImageAttachment]()
//    @State private var attachmentByIdentifier = [String: ImageAttachment]()
    @State private var loadedImagesByIdentifier = [String: Image]() {
        didSet {
            didSelectImages(Array(loadedImagesByIdentifier.values))
        }
    }
    var didSelectImages: (([Image]) -> Void)
    
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
                loadedImagesByIdentifier[pickerItem.identifier] == nil
            }
            Task {
                for pickerItem in newImages {
                    do {
                        if let data = try await pickerItem.loadTransferable(type: Data.self),
                           let uiImage = UIImage(data: data) {
                            loadedImagesByIdentifier[pickerItem.identifier] = Image(uiImage: uiImage)
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
    ImagePicker(didSelectImages: { images in
        print(images.count)
    })
}
