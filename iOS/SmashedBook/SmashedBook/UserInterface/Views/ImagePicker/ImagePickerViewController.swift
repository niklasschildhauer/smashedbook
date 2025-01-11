//
//  ImagePickerViewController.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 06.01.25.
//

import UIKit

class ImagePickerViewController: UIViewController {
    
    var presenter: ImagePickerPresenter! {
        didSet {
            presenter.view = self
            imagePickerController.delegate = presenter
        }
    }
    
    private let imagePickerController: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        
        return imagePicker
    }()
    
    private let loadingViewWrapper: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .red
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension ImagePickerViewController: ImagePickerViewing {
    func hideLoadingSpinner() {
        loadingViewWrapper.isHidden = true
    }
    
    func showLoadingSpinner() {
        loadingViewWrapper.isHidden = false
    }
    
    func presentImagePicker() {
        view.addSubview(imagePickerController.view)
        imagePickerController.view.translatesAutoresizingMaskIntoConstraints = false
        imagePickerController.view.anchorToAllEdgesOfSafeArea()
        imagePickerController.didMove(toParent: self)
    }
}
