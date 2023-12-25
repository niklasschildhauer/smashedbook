//
//  AppCoordinator.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 24.12.23.
//

import Foundation
import SwiftUI

class AppCoordinator: UIKitCoordinator {
    var rootViewController: UIViewController {
        navigationController
    }
    
    let navigationController = UINavigationController()
    
    func start() {
        navigationController.viewControllers = [createRecipeCoordinatorViewController()]
    }
    
    func createRecipeCoordinatorViewController() -> UIViewController {
        let recipeCoordinator = RecipeCoordinator()
        recipeCoordinator.delegate = self
        
        return recipeCoordinator.rootViewController
    }
    
    func createRecipeDetailViewController(recipe: RecipeModel) -> UIViewController {
        let recipeDetailCoordinator = RecipeDetailCoordinator(recipeModel: recipe)
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

extension AppCoordinator: RecipeCoordinatorDelegate {
    func didTapShowRecipeDetail(recipe: RecipeModel, in coordinator: RecipeCoordinator) {
        navigationController.pushViewController(createRecipeDetailViewController(recipe: recipe), animated: true)
    }
}

extension AppCoordinator: RecipeDetailCoordinatorDelegate {
    func didTapShowAttachment(attachment: RecipeAttachmentModel, in coordinator: RecipeDetailCoordinator) {
        navigationController.pushViewController(createRecipeAttachmentDetailViewController(recipeAttachment: attachment), animated: true)
    }
}
