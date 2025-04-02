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
    
    private var interactionController: UIPercentDrivenInteractiveTransition?
    private var edgeSwipeGestureRecognizer: UIScreenEdgePanGestureRecognizer?
        
    func pushViewController(_ viewController: UIViewController, animated: Bool, customBackButtonItem: UIBarButtonItem? = nil, transparentNavigationBar: Bool = false) {
        let appearance = UINavigationBarAppearance()

        if let customBackButtonItem {
            disableStandardBackButtonImage(for: appearance)
            setBackBarButtonItemForNextPushedViewController(customBackButtonItem: customBackButtonItem)
        }
        
        if transparentNavigationBar {
            //appearance.configureWithTransparentBackground()
        }

        pushViewController(viewController, animated: true)
    }
    
    private func disableStandardBackButtonImage(for appearance: UINavigationBarAppearance) {
        let backButtonBackgroundImage = UIImage(named: "EmptyImage")
        appearance.setBackIndicatorImage(backButtonBackgroundImage, transitionMaskImage: backButtonBackgroundImage)
    }
    
    private func setBackBarButtonItemForNextPushedViewController(customBackButtonItem: UIBarButtonItem) {
        viewControllers.last?.navigationItem.backBarButtonItem = customBackButtonItem
    }
}

extension CustomNavigationController: UINavigationControllerDelegate {    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return FadeAnimationController(presenting: true)
        } else {
            return FadeAnimationController(presenting: false)
        }
    }

    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionController
    }
}

protocol ZoomTransitionViewController {
    func frame() -> CGRect
    func imageView() -> UIImageView
}

class FadeAnimationController: NSObject, UIViewControllerAnimatedTransitioning {

    private let presenting: Bool

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        guard let toView = transitionContext.view(forKey: .to) else { return }

        let container = transitionContext.containerView
        if presenting {
            container.addSubview(toView)
            toView.alpha = 0.0
        } else {
            container.insertSubview(toView, belowSubview: fromView)
        }

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            if self.presenting {
                print(toView.frame)
                print(fromView.frame)
                toView.alpha = 1.0
            } else {
                fromView.alpha = 0.0
            }
        }) { _ in
            let success = !transitionContext.transitionWasCancelled
            if !success {
                toView.removeFromSuperview()
            }
            transitionContext.completeTransition(success)
        }
    }

    init(presenting: Bool) {
        self.presenting = presenting
    }
}

