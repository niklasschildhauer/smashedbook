//
//  DetailRecipeCoordinatorView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 02.10.23.
//

import SwiftUI

@Observable class RecipeDetailCoordinator: Coordinator {
    typealias CoordinatorView = RecipeDetailCoordinatorView
    
    var rootView: RecipeDetailCoordinatorView {
        RecipeDetailCoordinatorView(coordinator: self)
    }
    
    // TODO: this recipesDataSource is only pass through. Use DI to avoid overhead
    var recipesDataSource: RecipesDataSource
    var recipeModel: RecipeModel
    var recipeEditCoordinator: RecipeEditCoordinator? = nil
    
    var isEditing: Bool {
        recipeEditCoordinator != nil
    }
    
    init(recipesDataSource: RecipesDataSource = RecipesDataSource(), recipeModel: RecipeModel) {
        self.recipesDataSource = recipesDataSource
        self.recipeModel = recipeModel
    }
    
    func start() { }
    
    func reload() {
        recipeModel = recipesDataSource.recipes.first { $0.id == recipeModel.id } ?? recipeModel
    }
    
    func didTapEditButton() async {
        if let recipeEditCoordinator = recipeEditCoordinator {
            await recipeEditCoordinator.save()
            // TODO: Is this a suitable solution? Maybe we can use combine here
            recipeModel = recipeEditCoordinator.recipeModel
            self.recipeEditCoordinator = nil
        } else {
            recipeEditCoordinator = RecipeEditCoordinator(recipesDataSource: recipesDataSource, recipeModel: recipeModel)
        }
    }
}

struct RecipeDetailCoordinatorView: View {
    @State var coordinator: RecipeDetailCoordinator
    
    var editButtonTitle: String {
        !coordinator.isEditing ? "Bearbeiten" : "Speichern"
    }
    
    var body: some View {
        RecipeDetailView(recipe: $coordinator.recipeModel)
            .padding(.horizontal, LayoutConstants.safeAreaSpacing)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .bottomToolbar {
                HStack(spacing: LayoutConstants.horizontalSpacing){
                    IconLabelFilledButtonView(title: "Bearbeiten") {
                        Task {
                            await coordinator.didTapEditButton()
                        }
                    }
                    .uiTestIdentifier("editRecipeButton")
                }
            }
            .sheet(item: $coordinator.recipeEditCoordinator, 
                   onDismiss: {
                coordinator.reload()
            },
                   content: { coordinator in
                coordinator.rootView
            })
            .onAppear {
                coordinator.start()
            }
    }
}

#Preview {
    RecipeDetailCoordinatorView(coordinator: RecipeDetailCoordinator(recipeModel: recipeModelMock))
}
