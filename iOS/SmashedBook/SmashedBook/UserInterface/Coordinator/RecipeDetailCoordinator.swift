//
//  DetailRecipeCoordinatorView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 02.10.23.
//

import SwiftUI

protocol RecipeDetailCoordinating: AnyObject, ObservableObject {
    func addAttachment()
    func showAttachment(attachment: ImageResourceModel)
    func editRecipeStep(at index: Int)
    func addRecipeStep()
}

@Observable class RecipeDetailCoordinator: SwiftUICoordinator, RecipeDetailCoordinating {
    typealias CoordinatorView = RecipeDetailCoordinatorView
    
    var rootView: RecipeDetailCoordinatorView {
        RecipeDetailCoordinatorView(coordinator: self)
    }
    
    // TODO: this recipesDataSource is only pass through. Use DI to avoid overhead
    var recipesDataSource: RecipesDataSource
    var recipeModel: RecipeModel {
        didSet {
            saveRecipe()
        }
    }
    var recipeEditCoordinator: RecipeEditCoordinator? = nil
    var addImageCoordinator: AddImageCoordinator? = nil
    var attachmentDetailCoordinator: AttachmentDetailCoordinator? = nil
    
    init(recipesDataSource: RecipesDataSource = RecipesDataSource(), recipeModel: RecipeModel) {
        self.recipesDataSource = recipesDataSource
        self.recipeModel = recipeModel
    }
        
    func saveRecipe() {
        recipesDataSource.save(recipe: recipeModel)
    }
    
    func addAttachment() {
        addImageCoordinator = AddImageCoordinator(didAddImageResources: { images in
            self.recipeModel.attachments.append(contentsOf: images)
            self.saveRecipe()
            self.addImageCoordinator = nil
        })
    }
    
    func showAttachment(attachment: ImageResourceModel) {
        attachmentDetailCoordinator = AttachmentDetailCoordinator()
    }
    
    func editRecipeStep(at index: Int) {
        recipeEditCoordinator = RecipeEditCoordinator(recipeStep:         recipeModel.steps[index]) { recipeStep in
            self.recipeModel.steps[index] = recipeStep
        }
    }
    
    func addRecipeStep() {
        recipeEditCoordinator = RecipeEditCoordinator(recipeStep: RecipeStepModel(description: "")) { recipeStep in
            self.recipeModel.steps.append(recipeStep)
        }
    }

}

struct RecipeDetailCoordinatorView: View {
    @State var coordinator: RecipeDetailCoordinator
    @Environment(\.editMode) var editMode

    var body: some View {
        RecipeDetailView<RecipeDetailCoordinator>(recipe: $coordinator.recipeModel)
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
                }
            }
        }
        .sheet(item: $coordinator.addImageCoordinator,
               onDismiss: {
            $coordinator.addImageCoordinator.wrappedValue = nil
        },
               content:{ coordinator in
            coordinator.rootView
        })
        .sheet(item: $coordinator.attachmentDetailCoordinator) { coordinator in  coordinator.rootView
        }
        .sheet(item: $coordinator.recipeEditCoordinator) { coordinator in  coordinator.rootView
                .presentationDetents([.medium])
        }
        .environment(coordinator)
    }
}

#Preview {
    RecipeDetailCoordinatorView(coordinator: RecipeDetailCoordinator(recipeModel: recipeModelMock))
}
