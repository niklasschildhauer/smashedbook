//
//  DetailRecipeCoordinatorView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 02.10.23.
//

import SwiftUI

protocol RecipeDetailCoordinatorDelegate: AnyObject {
    func didTapShowAttachment(attachment: RecipeAttachmentModel, in coordinator: RecipeDetailCoordinator)
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
    
    func didTapShowAttachment(recipeAttachment: RecipeAttachmentModel) {
        delegate?.didTapShowAttachment(attachment: recipeAttachment, in: self)
    }
}

struct RecipeDetailCoordinatorView: View {
    @State var coordinator: RecipeDetailCoordinator

    var body: some View {
        RecipeDetailContentView(recipe: $coordinator.recipeModel)
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
    }
}

#Preview {
    RecipeDetailCoordinatorView(coordinator: RecipeDetailCoordinator(recipeModel: recipeModelMock))
}
