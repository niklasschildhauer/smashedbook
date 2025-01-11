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
    func editRecipeIngredient(at index: Int)
    func addRecipeIngredient()
    func addImage()
    func addTitleImage()
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
  
    var recipeEditStepCoordinator: RecipeEditCoordinator<RecipeStepModel, RecipeEditStepCoordinatorView>? = nil
    var recipeEditIngredientCoordinator: RecipeEditCoordinator<RecipeIngredientModel, RecipeEditIngredientsCoordinatorView>? = nil
    var addImageCoordinator: AddImageCoordinator? = nil
    var attachmentDetailCoordinator: AttachmentDetailCoordinator? = nil
    var imagePickerCoordinator: ImagePickerCoordinator? = nil
    
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
        attachmentDetailCoordinator = AttachmentDetailCoordinator(imageResourceModel: attachment)
    }
    
    func editRecipeStep(at index: Int) {
        recipeEditStepCoordinator = RecipeEditCoordinator(editModel: recipeModel.steps[index]) { stepModel in
                self.recipeModel.steps[index] = stepModel
                self.saveRecipe()
                self.recipeEditStepCoordinator = nil
        }
    }
    
    func addRecipeStep() {
        recipeEditStepCoordinator = RecipeEditCoordinator(editModel: RecipeStepModel(description: "")) { stepModel in
            self.recipeModel.steps.append(stepModel)
            self.saveRecipe()
            self.recipeEditStepCoordinator = nil
        }
    }
    
    func editRecipeIngredient(at index: Int) {
        recipeEditIngredientCoordinator = RecipeEditCoordinator(editModel: recipeModel.ingredients[index]) { ingredientModel in
            self.recipeModel.ingredients[index] = ingredientModel
            self.saveRecipe()
            self.recipeEditIngredientCoordinator = nil
        }
    }
    
    func addRecipeIngredient() {
        recipeEditIngredientCoordinator = RecipeEditCoordinator(editModel: RecipeIngredientModel(name: "", value: "", unit: .gram)) { ingredientModel in
            self.recipeModel.ingredients.append(ingredientModel)
            self.saveRecipe()
            self.recipeEditIngredientCoordinator = nil
        }
    }

    func addImage() {
        imagePickerCoordinator = ImagePickerCoordinator(didSelectImages: { imageResourceModel in
            imageResourceModel.forEach { imageResourceModel in
                self.recipeModel.attachments.append(imageResourceModel)
            }

            self.imagePickerCoordinator = nil
        })
    }
    
    func addTitleImage() {
        imagePickerCoordinator = ImagePickerCoordinator(didSelectImages: { imageResourceModel in
            if let firsImageResourceModel = imageResourceModel.first {
                self.recipeModel.titleImage = firsImageResourceModel
            }
            self.imagePickerCoordinator = nil
        }, selectionLimit: 1)
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
        .sheet(item: $coordinator.imagePickerCoordinator) { coordinator in
            coordinator.rootView
        }
        .sheet(item: $coordinator.attachmentDetailCoordinator) { coordinator in  coordinator.rootView
        }
        .sheet(item: $coordinator.recipeEditStepCoordinator) { coordinator in  coordinator.rootView
                .presentationDetents([.height(200)])
        }
        .sheet(item: $coordinator.recipeEditIngredientCoordinator) { coordinator in  coordinator.rootView
                .presentationDetents([.height(150)])
        }
        .environment(coordinator)
    }
}

#Preview {
    RecipeDetailCoordinatorView(coordinator: RecipeDetailCoordinator(recipeModel: recipeModelMock))
}
