//
//  Coordinator+Protocol.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 03.10.23.
//

import SwiftUI

protocol Coordinator {
    associatedtype CoordinatorView: View
    
    var rootView: CoordinatorView { get }
    var rootViewController: UIViewController { get }
}

protocol SwiftUICoordinator: Coordinator where CoordinatorView: View {
    func start()
}

extension SwiftUICoordinator {
    var rootViewController: UIViewController {
        UIHostingController(rootView: rootView)
    }
}

protocol UIKitCoordinator: Coordinator { }

extension UIKitCoordinator {
    var rootView: UIViewControllerView {
        UIViewControllerView(viewController: rootViewController)
    }
}

struct UIViewControllerView: UIViewControllerRepresentable {
    typealias UIViewType = UIViewController
    
    let viewController: UIViewController
  
    func makeUIViewController(context: Context) -> UIViewController {
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

