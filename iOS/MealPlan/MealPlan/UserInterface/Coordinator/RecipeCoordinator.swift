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
   
    var detailRecipeCoordinator: DetailRecipeCoordinator? = nil
    var newRecipeEditModel: RecipeEditViewModel? = nil
    
    init(recipesDataSource: RecipesDataSource = RecipesDataSource()) {
        self.recipesDataSource = recipesDataSource
    }
    
    func start() {
        recipesDataSource.loadRecipes()
    }
    
    func didTapAddNewRecipe() {
        newRecipeEditModel = RecipeEditViewModel(recipesDataSource: recipesDataSource, recipeToEdit: RecipeModel())
    }
    
    func didTapCloseNewRecipe() {
        newRecipeEditModel = nil
    }
    
    func didTapSaveNewRecipe() async {
        await newRecipeEditModel?.save()
        newRecipeEditModel = nil
    }
    
    func didRecieveNavigationDestination(recipeModel: RecipeModel) -> DetailRecipeCoordinator {
        return DetailRecipeCoordinator(recipesDataSource: recipesDataSource, recipeModel: recipeModel)
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
        .sheet(item: $coordinator.newRecipeEditModel, content: { newRecipeEditModel in
            NavigationStack {
                addRecipeView(recipeEditViewModel: newRecipeEditModel)
                // TODO: Presentation height based on content?
                    .presentationDetents([.height(200)])
            }
        })
        .onAppear {
            coordinator.start()
        }
    }
        
    @ViewBuilder var recipeOverviewView: some View {
        RecipeListingView(recipes: $coordinator.recipesDataSource.recipes)
            .titleBar(title: "Meine Rezepte")
            .bottomToolbar {
                IconLabelFilledButtonView(title: "Hinzufügen") {
                    coordinator.didTapAddNewRecipe()
                }
            }
            .uiTestIdentifier("recipeOverviewPageView")
    }
        
    @ViewBuilder func addRecipeView(recipeEditViewModel: RecipeEditViewModel) -> some View {
        RecipeEditView(viewModel: recipeEditViewModel)
            .bottomToolbar {
                HStack {
                    IconFilledButtonView(icon: Image(systemName: "xmark")) {
                        coordinator.didTapCloseNewRecipe()
                    }
                    Spacer()
                }
                IconLabelFilledButtonView(title: "Speichern") {
                    Task {
                        await coordinator.didTapSaveNewRecipe()
                    }
                }
            }
            .uiTestIdentifier("addRecipePageView")
    }
}

#Preview {
    RecipeCoordinatorView(coordinator: RecipeCoordinator())
}
