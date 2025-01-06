//
//  ImagePickerPresenter.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 06.01.25.
//

import UIKit

protocol ImagePickerViewing: AnyObject {
    var presenter: ImagePickerPresenter! { get set }
}

protocol ImagePickerPresenterDelegate: AnyObject {
    func didSelectImage(in presenter: ImagePickerPresenter, image: UIImage)
}

class ImagePickerPresenter {
    
    weak var view: ImagePickerViewing?
    var delegate: ImagePickerPresenterDelegate?
    
}
