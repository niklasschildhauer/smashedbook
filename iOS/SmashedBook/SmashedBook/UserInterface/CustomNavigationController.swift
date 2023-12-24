//
//  CustomNavigationController.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 23.12.23.
//

import Foundation
import UIKit
import SwiftUI

struct CustomNavigationControllerView: UIViewControllerRepresentable {
    typealias UIViewType = CustomNavigationController
    
    let customNavigationController: CustomNavigationController
  
    func makeUIViewController(context: Context) -> CustomNavigationController {
        return customNavigationController
    }
    
    func updateUIViewController(_ uiViewController: CustomNavigationController, context: Context) {
    }
}

class CustomNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        view.backgroundColor = .red
        
    }
    
}


