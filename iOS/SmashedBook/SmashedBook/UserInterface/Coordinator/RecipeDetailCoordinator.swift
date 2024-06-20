//
//  DetailRecipeCoordinatorView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 02.10.23.
//

import SwiftUI

protocol RecipeDetailCoordinatorDelegate: AnyObject {
    func didTapShowAttachment(attachment: ImageResourceModel, in coordinator: RecipeDetailCoordinator)
}

@Observable class RecipeDetailCoordinator: SwiftUICoordinator {
    typealias CoordinatorView = RecipeDetailCoordinatorView
    
    weak var delegate: RecipeDetailCoordinatorDelegate?
    var rootView: RecipeDetailCoordinatorView {
        RecipeDetailCoordinatorView(coordinator: self)
    }
    
    // TODO: this recipesDataSource is only pass through. Use DI to avoid overhead
    var recipesDataSource: RecipesDataSource
    var recipeModel: RecipeModel
    var recipeEditCoordinator: RecipeEditCoordinator? = nil
    var recipeAttachment: ImageResourceModel? = nil
    
    init(recipesDataSource: RecipesDataSource = RecipesDataSource(), recipeModel: RecipeModel) {
        self.recipesDataSource = recipesDataSource
        self.recipeModel = recipeModel
    }
    
    func start() { }
        
    func didTapEditButton() {
        recipeEditCoordinator = RecipeEditCoordinator(recipeModel: recipeModel) { updatedRecipe in
            self.recipeModel = updatedRecipe
            self.recipesDataSource.save(recipe: updatedRecipe)
            self.recipeEditCoordinator = nil
        }
    }
}

struct RecipeDetailCoordinatorView: View {
    @State var coordinator: RecipeDetailCoordinator

    var body: some View {
        RecipeDetailView(recipe: $coordinator.recipeModel) { attachment in
            coordinator.recipeAttachment = attachment
        }
            .bottomToolbar {
                HStack {
                    IconLabelFilledButtonView(title: "Bearbeiten") {
                        coordinator.didTapEditButton()
                    }
                    .uiTestIdentifier("editRecipeButton")
                }
            }
            .sheet(item: $coordinator.recipeEditCoordinator, content: { coordinator in
                coordinator.rootView
            })
            .onAppear {
                coordinator.start()
            }
            .sheet(item: $coordinator.recipeAttachment, content: { attachment in
                ImageDetailView(attachment: attachment)
            })
            .environment(coordinator)
    }
}

#Preview {
    RecipeDetailCoordinatorView(coordinator: RecipeDetailCoordinator(recipeModel: recipeModelMock))
}
