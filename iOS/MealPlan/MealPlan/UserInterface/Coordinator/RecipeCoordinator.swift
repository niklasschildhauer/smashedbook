//
//  RecipeCoordinatorView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 02.10.23.
//

import SwiftUI

@Observable
class RecipeCoordinator: Coordinator {
    typealias CoordinatorView = RecipeCoordinatorView
    
    var rootView: RecipeCoordinatorView {
        RecipeCoordinatorView(coordinator: self)
    }
    
    var navigationPath = NavigationPath()
    var recipesDataSource: RecipesDataSource
    
    var detailRecipeCoordinator: RecipeDetailCoordinator? = nil
    var recipeEditCoordinator: RecipeEditCoordinator? = nil
    
    init(recipesDataSource: RecipesDataSource = RecipesDataSource()) {
        self.recipesDataSource = recipesDataSource
    }
    
    func start() {
        recipesDataSource.loadRecipes()
    }
    
    func didTapAddNewRecipe() {
        recipeEditCoordinator = RecipeEditCoordinator(recipesDataSource: recipesDataSource, recipeModel: RecipeModel())
    }
    
    func didTapCloseNewRecipe() {
        recipeEditCoordinator = nil
    }
    
    func didTapSaveNewRecipe() async {
        await recipeEditCoordinator?.save()
        recipeEditCoordinator = nil
    }
    
    func didRecieveNavigationDestination(recipeModel: RecipeModel) -> RecipeDetailCoordinator {
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
                    .uiTestIdentifier("addRecipePageView")
                // TODO: Presentation height based on content?
            }
        })
        .onAppear {
            coordinator.start()
        }
    }
    
    @ViewBuilder var recipeOverviewView: some View {
        RecipeListingView(recipes: $coordinator.recipesDataSource.recipes)
            .padding(.horizontal, LayoutConstants.safeAreaSpacing)
            .titleBar(title: "Meine Rezepte")
            .bottomToolbar {
                IconLabelFilledButtonView(title: "Hinzufügen") {
                    coordinator.didTapAddNewRecipe()
                }
            }
            .uiTestIdentifier("recipeOverviewPageView")
    }
}

#Preview {
    RecipeCoordinatorView(coordinator: RecipeCoordinator())
}
