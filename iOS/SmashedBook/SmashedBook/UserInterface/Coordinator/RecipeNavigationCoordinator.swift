//
//  AppCoordinator.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 24.12.23.
//

import Foundation
import SwiftUI

class RecipeNavigationCoordinator: UIKitCoordinator {
    var rootViewController: UIViewController {
        navigationController
    }
    
    let navigationController = CustomNavigationController()
    
    func start() {
        navigationController.viewControllers = [createRecipeCoordinatorViewController()]
    }
    
    func createRecipeCoordinatorViewController() -> UIViewController {
        let recipeHomeCoordinator = RecipeHomeCoordinator()
        recipeHomeCoordinator.delegate = self
        
        return recipeHomeCoordinator.rootViewController
    }
    
    func createRecipeDetailViewController(recipe: RecipeModel) -> UIViewController {
        let recipeDetailCoordinator = RecipeDetailInformationCoordinator(recipe: recipe)
        let recipeDetailViewController = recipeDetailCoordinator.rootViewController
        recipeDetailCoordinator.delegate = self
        
        return recipeDetailViewController
    }
    
    func createRecipeAttachmentDetailViewController(recipeAttachment: RecipeAttachmentModel) -> UIViewController {
        let attachmentView = ImageDetailView(attachment: recipeAttachment)
        let uiHostingViewController = UIHostingController(rootView: attachmentView)
        
        return uiHostingViewController
    }
}

extension RecipeNavigationCoordinator: RecipeHomeCoordinatorDelegate {
    func didTapShowRecipeDetail(recipe: RecipeModel, in coordinator: RecipeHomeCoordinator) {
        navigationController.pushViewController(createRecipeDetailViewController(recipe: recipe), animated: true)
    }
}

extension RecipeNavigationCoordinator: RecipeDetailInformationCoordinatorDelegate {
    func didTapShowAttachment(attachment: RecipeAttachmentModel, in coordinator: RecipeDetailInformationCoordinator) {
        navigationController.pushViewController(createRecipeAttachmentDetailViewController(recipeAttachment: attachment), animated: true)
    }
}
