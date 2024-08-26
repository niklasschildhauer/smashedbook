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
    var originalRecipeModel: RecipeModel
    var recipeEditCoordinator: RecipeEditCoordinator? = nil
    var recipeAttachment: ImageResourceModel? = nil
    var recipeStepInFocus: RecipeStepModel? = nil
    
    init(recipesDataSource: RecipesDataSource = RecipesDataSource(), recipeModel: RecipeModel) {
        self.recipesDataSource = recipesDataSource
        self.recipeModel = recipeModel
        self.originalRecipeModel = recipeModel
    }
    
    func start() { }
    
    func saveRecipe() {
        originalRecipeModel = recipeModel
        recipesDataSource.save(recipe: originalRecipeModel)
    }
    
    func resetRecipe() {
        recipeModel = originalRecipeModel
    }
    
    func open(step: RecipeStepModel) {
        recipeStepInFocus = step
    }
    
    func saveRecipeStep(editedRecipeStep: RecipeStepModel) {
        if let editedRecipeStepIndex = recipeModel.steps.firstIndex(where: { recipeStep in
            recipeStep.id == editedRecipeStep.id
        }) {
            recipeModel.steps[editedRecipeStepIndex] = editedRecipeStep
        } else {
            recipeModel.steps.append(editedRecipeStep)
        }
        saveRecipe()
        recipeStepInFocus = nil
    }
}

struct RecipeDetailCoordinatorView: View {
    @State var coordinator: RecipeDetailCoordinator
    @Environment(\.editMode) var editMode
    
    var body: some View {
        RecipeDetailView(recipe: $coordinator.recipeModel, 
                         selectedRecipeStep: $coordinator.recipeStepInFocus){ attachment in
            coordinator.recipeAttachment = attachment
        }
            .bottomToolbar {
                HStack {
                    if editMode?.wrappedValue == .inactive {
                        IconLabelFilledButtonView(title: "Bearbeiten", iconSystemName: "trash.fill") {
                            self.editMode?.animation().wrappedValue = .active
                        }
                    } else {
                        IconLabelFilledButtonView(title: "Speichern", iconSystemName: "trash.fill") {
                            self.editMode?.animation().wrappedValue = .inactive
                            coordinator.saveRecipe()
                        }
                        IconLabelFilledButtonView(title: "Abbrechen", iconSystemName: "trash.fill") {
                            self.editMode?.animation().wrappedValue = .inactive
                            coordinator.resetRecipe()
                        }
                    }
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
            .sheet(item: $coordinator.recipeStepInFocus, content: { recipeStep in
                RecipeEditStepView(recipeStep: recipeStep) { editedRecipeStep in
                    coordinator.saveRecipeStep(editedRecipeStep: editedRecipeStep)
                }
                .presentationDetents([.medium, .large])
//                .presentationContentInteraction(.scrolls)
            })
            .environment(coordinator)
    }
}

#Preview {
    RecipeDetailCoordinatorView(coordinator: RecipeDetailCoordinator(recipeModel: recipeModelMock))
}
