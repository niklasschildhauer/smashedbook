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
    let recipeDataSource = RecipesDataSource()
    
    func start() {
        navigationController.viewControllers = [createRecipeHomeCoordinatorViewController()]
    }
    
    func createRecipeHomeCoordinatorViewController() -> UIViewController {
        let recipeHomeCoordinator = RecipeHomeCoordinator(recipesDataSource: recipeDataSource)
        recipeHomeCoordinator.delegate = self
        
        return recipeHomeCoordinator.rootViewController
    }
    
    func createRecipeDetailViewController(recipe: RecipeModel) -> UIViewController {
        let recipeDetailCoordinator = RecipeDetailCoordinator(recipesDataSource: recipeDataSource, recipeModel: recipe)
        return recipeDetailCoordinator.rootViewController
    }
}

extension RecipeNavigationCoordinator: RecipeHomeCoordinatorDelegate {
    func didTapShowRecipeDetail(recipe: RecipeModel, in coordinator: RecipeHomeCoordinator) {
//        let customBackBarButtonItem = UIBarButtonItem(image: UIImage(named: "BackButton"), style: .plain, target: nil, action: nil)
        navigationController.pushViewController(createRecipeDetailViewController(recipe: recipe), animated: true, transparentNavigationBar: true)
    }
}
