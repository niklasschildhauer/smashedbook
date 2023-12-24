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
    
    init() {
        start()
    }
    
    func start() {
        navigationController.viewControllers = [createRecipeCoordinatorViewController()]
    }
    
    func createRecipeCoordinatorViewController() -> UIViewController {
        let recipeCoordinator = RecipeCoordinator()
        recipeCoordinator.delegate = self
        return recipeCoordinator.rootViewController
    }
}

extension AppCoordinator: RecipeCoordinatorDelegate {
    func didTapShowRecipeDetail(recipe: RecipeModel, in coordinator: RecipeCoordinator) {
        let recipeDetailCoordinator = RecipeDetailCoordinator(recipeModel: recipe)
        
        navigationController.pushViewController(recipeDetailCoordinator.rootViewController, animated: true)
    }
}
