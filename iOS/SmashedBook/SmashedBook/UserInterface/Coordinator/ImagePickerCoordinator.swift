//
//  ImagePickerCoordinator.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 06.01.25.
//

import UIKit
import PhotosUI

class ImagePickerCoordinator: NSObject, UIKitCoordinator, Identifiable {
    var rootViewController: UIViewController {
        photoPicker
    }
    
    private lazy var photoPicker: PHPickerViewController! = {
        var photoPickerConfiguration = PHPickerConfiguration(photoLibrary: .shared())
        photoPickerConfiguration.selectionLimit = self.selectionLimit
        photoPickerConfiguration.filter = .images
        
        return PHPickerViewController(configuration: photoPickerConfiguration)
    }()
    
    private let resourcesDataSource: ResourcesDataSourceProtocol
    private let didSelectImages: ([ImageResourceModel]) -> Void
    private let selectionLimit: Int

    init(didSelectImages: @escaping ([ImageResourceModel]) -> Void,
         selectionLimit: Int = 10,
         resourcesDataSource: ResourcesDataSourceProtocol = ResourcesDataSource.getInstance()
    ) {
        self.didSelectImages = didSelectImages
        self.resourcesDataSource = resourcesDataSource
        self.selectionLimit = selectionLimit

        super.init()
        
        setupPhotoPicker()
    }
    
    private func setupPhotoPicker() {
        photoPicker.delegate = self
        photoPicker.modalPresentationStyle = .fullScreen
    }
    
}

extension ImagePickerCoordinator: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        let dispatchGroup: DispatchGroup = DispatchGroup()
        var selectedImageResources: [ImageResourceModel] = []

        //todo add loading spinner
        
        for (index, result) in results.enumerated() {
            dispatchGroup.enter()
            
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self]
                reading, error in
                if let image = reading as? UIImage,
                   error == nil,
                   let imageData = image.pngData(),
                   let resource = self?.resourcesDataSource.save(attachmentData: imageData) {
                    if selectedImageResources.count > index {
                        selectedImageResources.insert(resource, at: index)
                    } else {
                        selectedImageResources.append(resource)
                    }
                    dispatchGroup.leave()
                } else {
                    print("Something went wrong!")
                    // todo: error handling
                    dispatchGroup.leave()
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.didSelectImages(selectedImageResources)
        }
    }
    
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        DispatchQueue.main.async { [weak self] in
            self?.didSelectImages([])
        }
    }
}
