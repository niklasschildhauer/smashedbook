//
//  CustomNavigationController.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 23.12.23.
//

import Foundation
import UIKit
import SwiftUI

class CustomNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        view.backgroundColor = .red
        UINavigationBar.appearance().backIndicatorImage = UIImage(systemName: "arrow.backward.circle.fill")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.backward.circle.fill")
    }
    
}


