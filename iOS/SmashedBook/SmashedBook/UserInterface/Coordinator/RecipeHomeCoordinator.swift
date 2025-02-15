//
//  RecipeHomeCoordinator.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 02.10.23.
//

import SwiftUI

protocol RecipeHomeCoordinatorDelegate: AnyObject {
    func didTapShowRecipeDetail(recipe: RecipeModel, in coordinator: RecipeHomeCoordinator)
    func didTapCreateRecipe(in coordinator: RecipeHomeCoordinator)
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
        delegate?.didTapCreateRecipe(in: self)
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
        .toolbar {
            ToolbarItem(id: "addButton", placement: .primaryAction) {
                Button(action: {
                    coordinator.addRecipe()
                }, label: {
                    Image(systemName: "square.and.pencil")
                })
                .buttonBorderShape(.circle)
                .buttonStyle(.bordered)
            }
        }
        .titleBar(title: "Meine Rezepte")
        
    }
}

#Preview {
    NavigationStack {
        RecipeHomeCoordinatorView(coordinator: RecipeHomeCoordinator())
    }
}
