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
        recipeDetailCoordinator.delegate = self
        
        return recipeDetailCoordinator.rootViewController
    }
    
    func createNewRecipeDetailViewController() -> UIViewController {
        let newRecipe = RecipeModel()
        let recipeDetailCoordinator = RecipeDetailCoordinator(recipesDataSource: recipeDataSource, recipeModel: newRecipe)
        recipeDetailCoordinator.editMode = .active
        recipeDetailCoordinator.delegate = self
        
        return recipeDetailCoordinator.rootViewController
    }
}

extension RecipeNavigationCoordinator: RecipeHomeCoordinatorDelegate {
    func didTapCreateRecipe(in coordinator: RecipeHomeCoordinator) {
        navigationController.pushViewController(createNewRecipeDetailViewController(), animated: true, transparentNavigationBar: true)
    }
    
    func didTapShowRecipeDetail(recipe: RecipeModel, in coordinator: RecipeHomeCoordinator) {
        navigationController.pushViewController(createRecipeDetailViewController(recipe: recipe), animated: true, transparentNavigationBar: true)
    }
}

extension RecipeNavigationCoordinator: RecipeDetailCoordinatorDelegate {
    func didCancelCreationOfRecipe(in coordinator: any RecipeDetailCoordinating) {
        print("we are here")
        navigationController.popViewController(animated: true)
    }
}
