//
//  ImagePickerCoordinator.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 06.01.25.
//

import UIKit

class ImagePickerCoordinator: NSObject, UIKitCoordinator, Identifiable {
    var rootViewController: UIViewController {
        imagePickerController
    }
    
    private let imagePickerController = UIImagePickerController()
    private let resourcesDataSource: ResourcesDataSourceProtocol
    
    private let didSelectImage: (ImageResourceModel) -> Void

    init(didSelectImage: @escaping (ImageResourceModel) -> Void,
         resourcesDataSource: ResourcesDataSourceProtocol = ResourcesDataSource.getInstance()) {
        self.didSelectImage = didSelectImage
        self.resourcesDataSource = resourcesDataSource
        super.init()
        setupImagePicker()
    }
    
    private func setupImagePicker() {
        imagePickerController.allowsEditing = false
        imagePickerController.delegate = self
    }
    
}

extension ImagePickerCoordinator: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage,
            let imageData = image.pngData(),
            let imageResource = resourcesDataSource.save(attachmentData: imageData)
        else {
            // todo: error handling
            return
        }
    
        self.didSelectImage(imageResource)
    }
}
