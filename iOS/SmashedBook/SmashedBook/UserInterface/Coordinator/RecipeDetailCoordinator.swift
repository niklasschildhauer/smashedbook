//
//  DetailRecipeCoordinatorView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 02.10.23.
//

import SwiftUI

protocol RecipeDetailCoordinating: ObservableObject, RecipeDetailGeneralInfoDelegate {
    func addAttachment()
    func showAttachment(attachment: ImageResourceModel)
    func editRecipeStep(at index: Int)
    func addRecipeStep()
    func editRecipeIngredient(at index: Int)
    func addRecipeIngredient()
    func addImage()
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
  
    var recipeEditStepCoordinator: RecipeEditCoordinator< RecipeEditStepCoordinatorView>? = nil
    var recipeEditIngredientCoordinator: RecipeEditCoordinator< RecipeEditIngredientsCoordinatorView>? = nil
    var addImageCoordinator: AddImageCoordinator? = nil
    var attachmentDetailCoordinator: AttachmentDetailCoordinator? = nil
    var imagePickerCoordinator: ImagePickerCoordinator? = nil
    
    init(
        recipesDataSource: RecipesDataSource = RecipesDataSource(),
        recipeModel: RecipeModel
    ) {
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
        attachmentDetailCoordinator = AttachmentDetailCoordinator(
            imageResourceModel: attachment
        )
    }
    
    func editRecipeStep(at index: Int) {
        recipeEditStepCoordinator = RecipeEditCoordinator(
            editModel: recipeModel.steps[index]
        ) { stepModel in
            self.recipeModel.steps[index] = stepModel
            self.saveRecipe()
            self.recipeEditStepCoordinator = nil
        }
    }
    
    func addRecipeStep() {
        recipeEditStepCoordinator = RecipeEditCoordinator(
            editModel: RecipeStepModel(description: "")
        ) { stepModel in
            self.recipeModel.steps.append(stepModel)
            self.saveRecipe()
            self.recipeEditStepCoordinator = nil
        }
    }
    
    func editRecipeIngredient(at index: Int) {
        recipeEditIngredientCoordinator = RecipeEditCoordinator(
            editModel: recipeModel.ingredients[index]
        ) { ingredientModel in
            self.recipeModel.ingredients[index] = ingredientModel
            self.saveRecipe()
            self.recipeEditIngredientCoordinator = nil
        }
    }
    
    func addRecipeIngredient() {
        recipeEditIngredientCoordinator = RecipeEditCoordinator(
            editModel: RecipeIngredientModel(
                name: "",
                value: "",
                unit: .kilogram
            )
        ) { ingredientModel in
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
        RecipeDetailView<RecipeDetailCoordinator>(
            recipe: $coordinator.recipeModel
        )
        .toolbar {
            ToolbarItem(id: "editButton", placement: .primaryAction) {
                if editMode?.wrappedValue == .inactive {
                    Button(action: {
                        self.editMode?.animation().wrappedValue = .active
                    }, label: {
                        Text("Bearbeiten")
                    })
                    .buttonStyle(.bordered)
                } else {
                    Button(action: {
                        self.editMode?.animation().wrappedValue = .inactive
                        coordinator.saveRecipe()
                    }, label: {
                        Text("Fertig")
                    })
                }
            }
        }
        .toolbarBackground(.hidden, for: .navigationBar)
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
        .sheet(
            item: $coordinator.attachmentDetailCoordinator
        ) { coordinator in  coordinator.rootView
        }
        .sheet(
            item: $coordinator.recipeEditStepCoordinator
        ) { coordinator in  coordinator.rootView
        }
        .sheet(
            item: $coordinator.recipeEditIngredientCoordinator
        ) { coordinator in  coordinator.rootView
        }
        .environment(coordinator)
    }
}

#Preview {
    NavigationStack {
        RecipeDetailCoordinatorView(
            coordinator: RecipeDetailCoordinator(recipeModel: recipeModelMock)
        )
    }
}
