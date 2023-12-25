//
//  RecipeHomeCoordinator.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 02.10.23.
//

import SwiftUI

protocol RecipeHomeCoordinatorDelegate: AnyObject {
    func didTapShowRecipeDetail(recipe: RecipeModel, in coordinator: RecipeHomeCoordinator)
}

@Observable
class RecipeHomeCoordinator: Coordinator {
    typealias CoordinatorView = RecipeHomeCoordinatorView
    
    weak var delegate: RecipeHomeCoordinatorDelegate?
    var rootView: RecipeHomeCoordinatorView {
        RecipeHomeCoordinatorView(coordinator: self)
    }
    
    var navigationPath = NavigationPath()
    var recipesDataSource: RecipesDataSource
    
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
        }
    }
    
    func didRecieveNavigationDestination(recipeModel: RecipeModel) {
        delegate?.didTapShowRecipeDetail(recipe: recipeModel, in: self)
    }
}

struct RecipeHomeCoordinatorView: View {
    @State var coordinator: RecipeHomeCoordinator
    
    var body: some View {
        recipeOverviewView
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
        RecipeListingView(recipes: $coordinator.recipesDataSource.recipes, 
                          didTapOpenRecipe: coordinator.didRecieveNavigationDestination)
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
    RecipeHomeCoordinatorView(coordinator: RecipeHomeCoordinator())
}
