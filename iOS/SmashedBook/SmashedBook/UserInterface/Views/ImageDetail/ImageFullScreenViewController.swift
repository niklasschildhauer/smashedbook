//
//  ImageFullScreenViewController.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 28.12.23.
//

import UIKit

class ImageFullScreenViewController: UIViewController {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ExamplePicture")
        
        return imageView
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .close)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(close), for: .allTouchEvents)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
    
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        view.bottomAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        view.addSubview(closeButton)
        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: closeButton.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    @objc func close() {
        dismiss(animated: true)
    }
}
