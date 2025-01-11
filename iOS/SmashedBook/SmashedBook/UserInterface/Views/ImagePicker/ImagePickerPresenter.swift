//
//  ImagePickerPresenter.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 06.01.25.
//

import UIKit

protocol ImagePickerViewing: AnyObject {
    var presenter: ImagePickerPresenter! { get set }
    
    func hideLoadingSpinner()
    func showLoadingSpinner()
    
    func presentImagePicker()
}

protocol ImagePickerPresenterDelegate: AnyObject {
    func didSelectImage(in presenter: ImagePickerPresenter, imageData: Data)
}

class ImagePickerPresenter: NSObject {
    
    weak var view: ImagePickerViewing?
    var delegate: ImagePickerPresenterDelegate?
    
    func viewDidLoad() {
        view?.presentImagePicker()
    }
}

extension ImagePickerPresenter: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage,
           let imageData = image.pngData() {
            delegate?.didSelectImage(in: self, imageData: imageData)
        } else {
            // todo: error handling
            return
        }        
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        print("didShow \(viewController)")
    }
}
