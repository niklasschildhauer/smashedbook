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
class RecipeHomeCoordinator: SwiftUICoordinator {
    typealias CoordinatorView = RecipeHomeCoordinatorView
    
    weak var delegate: RecipeHomeCoordinatorDelegate?
    var rootView: RecipeHomeCoordinatorView {
        RecipeHomeCoordinatorView(coordinator: self)
    }
    
    var recipesDataSource: RecipesDataSource
    
    init(recipesDataSource: RecipesDataSource = RecipesDataSource()) {
        self.recipesDataSource = recipesDataSource
    }
    
    func start() {
        recipesDataSource.loadRecipes()
    }
    
    func addRecipe() {
        let newRecipe = RecipeModel()
        delegate?.didTapShowRecipeDetail(recipe: newRecipe, in: self)
    }
    
    func showDetails(of recipeModel: RecipeModel) {
        delegate?.didTapShowRecipeDetail(recipe: recipeModel, in: self)
    }
}

struct RecipeHomeCoordinatorView: View {
    @State var coordinator: RecipeHomeCoordinator
    
    var body: some View {
        recipeOverviewView
        .onAppear {
            coordinator.start()
        }
        .uiTestIdentifier("recipeCoordinatorView")
    }
    
    @ViewBuilder var recipeOverviewView: some View {
        RecipeListingView(recipes: $coordinator.recipesDataSource.recipes, 
                          showDetails: coordinator.showDetails)
            .titleBar(title: "Meine Rezepte")
            .bottomToolbar {
                IconLabelFilledButtonView(title: "Hinzufügen", iconSystemName: "trash.fill") {
                    coordinator.addRecipe()
                }
                .uiTestIdentifier("addRecipeButton")
            }
    }
}

#Preview {
    RecipeHomeCoordinatorView(coordinator: RecipeHomeCoordinator())
}
