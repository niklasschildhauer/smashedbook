//
//  RecipeCoordinatorView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 02.10.23.
//

import SwiftUI

protocol RecipeCoordinatorDelegate: AnyObject {
    func didTapShowRecipeDetail(recipe: RecipeModel, in coordinator: RecipeCoordinator)
}

@Observable
class RecipeCoordinator: Coordinator {
    typealias CoordinatorView = RecipeCoordinatorView
    
    var rootView: RecipeCoordinatorView {
        RecipeCoordinatorView(coordinator: self)
    }
    
    var navigationPath = NavigationPath()
    var recipesDataSource: RecipesDataSource
    var delegate: RecipeCoordinatorDelegate?
    
    var detailRecipeCoordinator: RecipeDetailCoordinator? = nil
    var recipeEditCoordinator: RecipeEditCoordinator? = nil
    
    init(recipesDataSource: RecipesDataSource = RecipesDataSource()) {
        self.recipesDataSource = recipesDataSource
    }
    
    func start() {
        recipesDataSource.loadRecipes()
    }
    
    func didTapAddNewRecipe() {
        recipeEditCoordinator = RecipeEditCoordinator(recipeModel: RecipeModel()) { newRecipe in
            self.recipesDataSource.save(recipe: newRecipe)
            self.detailRecipeCoordinator = nil
        }
    }
    
    func didRecieveNavigationDestination(recipeModel: RecipeModel) -> RecipeDetailCoordinator {
        delegate?.didTapShowRecipeDetail(recipe: recipeModel, in: self)
        return RecipeDetailCoordinator(recipesDataSource: recipesDataSource, recipeModel: recipeModel)
    }
}

struct RecipeCoordinatorView: View {
    @State var coordinator: RecipeCoordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            recipeOverviewView
                .navigationDestination(for: RecipeModel.self) { recipe in
                    coordinator.didRecieveNavigationDestination(recipeModel: recipe).rootView
                }
        }
        .sheet(item: $coordinator.recipeEditCoordinator, content: { ediitRecipeCoordinator in
            NavigationStack {
                ediitRecipeCoordinator.rootView
            }
        })
        .onAppear {
            coordinator.start()
        }
        .uiTestIdentifier("recipeCoordinatorView")
    }
    
    @ViewBuilder var recipeOverviewView: some View {
        RecipeListingView(recipes: $coordinator.recipesDataSource.recipes)
            .titleBar(title: "Meine Rezepte")
            .bottomToolbar {
                IconLabelFilledButtonView(title: "Hinzufügen") {
                    coordinator.didTapAddNewRecipe()
                }
                .uiTestIdentifier("addRecipeButton")
            }
    }
}

#Preview {
    RecipeCoordinatorView(coordinator: RecipeCoordinator())
}
