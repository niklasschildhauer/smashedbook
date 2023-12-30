//
//  FullScreenPresentationController.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 28.12.23.
//

import Foundation
import UIKit

final class FullScreenPresentationController: UIPresentationController {
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        guard let transitionCoordinator = presentingViewController.transitionCoordinator else { return }
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
   
        }
    }
    
    override func dismissalTransitionWillBegin() {
        guard let transitionCoordinator = presentingViewController.transitionCoordinator else { return }
        
        transitionCoordinator.animate(alongsideTransition: { context in
        
        })
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
 
        }
    }
}
