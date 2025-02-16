//
//  DetailRecipeCoordinatorView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 02.10.23.
//

import SwiftUI

protocol RecipeDetailCoordinatorDelegate: AnyObject {
    func didCancelCreationOfRecipe(in coordinator: any RecipeDetailCoordinating)
}

protocol RecipeDetailCoordinating: ObservableObject,
                                    RecipeDetailGeneralInfoDelegate,
                                    RecipeDetailAttachmentDelegate,
                                    RecipeDetailStepsDelegate,
                                    RecipeDetailIngredientDelegate { }

@Observable class RecipeDetailCoordinator: SwiftUICoordinator, RecipeDetailCoordinating {
    typealias CoordinatorView = RecipeDetailCoordinatorView
    
    var rootView: RecipeDetailCoordinatorView {
        RecipeDetailCoordinatorView(coordinator: self)
    }
    
    let recipesDataSource: RecipesDataSource
    let recipeSnapshotService: RecipeSnapshotService
    let recipeValidatorService: RecipeValidatorService
    
    var recipeModel: RecipeModel {
        didSet {
            saveRecipe()
        }
    }
    
    var delegate: RecipeDetailCoordinatorDelegate?
  
    var recipeEditStepCoordinator: RecipeEditCoordinator< RecipeEditStepCoordinatorView>?
    var recipeEditIngredientCoordinator: RecipeEditCoordinator< RecipeEditIngredientsCoordinatorView>?
    var attachmentDetailCoordinator: AttachmentDetailCoordinator?
    var imagePickerCoordinator: ImagePickerCoordinator?
    
    var editMode = EditMode.inactive
    
    init(
        recipesDataSource: RecipesDataSource = RecipesDataSource(),
        recipeModel: RecipeModel,
        recipeSnapshotService: RecipeSnapshotService = RecipeSnapshotService(),
        recipeValidatorService: RecipeValidatorService = RecipeValidatorService()

    ) {
        self.recipesDataSource = recipesDataSource
        self.recipeModel = recipeModel
        self.recipeSnapshotService = recipeSnapshotService
        self.recipeValidatorService = recipeValidatorService
    }
            
    func editRecipe() {
        recipeSnapshotService.saveSnapshot(of: recipeModel)
        editMode = .active
    }
    
    func cancelEdit() {
        if let recipeSnapshot = recipeSnapshotService.getSnapshot() {
            recipeModel = recipeSnapshot
        }
        
        guard isRecipeValid else {
            delegate?.didCancelCreationOfRecipe(in: self)
            return
        }
        
        editMode = .inactive
    }
    
    func saveEdit() {
        saveRecipe()
        editMode = .inactive
    }
    
    func saveRecipe() {
        if isRecipeValid {
            recipesDataSource.save(recipe: recipeModel)
        }
    }
    
    var isRecipeValid: Bool {
        return recipeValidatorService.isRecipeValid(recipeModel)
    }
    
    func showAttachment(attachment: ImageResourceModel) {
        attachmentDetailCoordinator = AttachmentDetailCoordinator(
            imageResourceModel: attachment, didTapDone: {
                self.attachmentDetailCoordinator = nil
            }
        )
    }
    
    func editRecipeStep(at index: Int) {
        recipeEditStepCoordinator = RecipeEditCoordinator(
            editModel: recipeModel.steps[index]
        ) { stepModel in
            self.recipeModel.steps[index] = stepModel
            self.recipeEditStepCoordinator = nil
        }
    }
    
    func addRecipeStep() {
        recipeEditStepCoordinator = RecipeEditCoordinator(
            editModel: RecipeStepModel(description: "")
        ) { stepModel in
            self.recipeModel.steps.append(stepModel)
            self.recipeEditStepCoordinator = nil
        }
    }
    
    func editRecipeIngredient(at index: Int) {
        recipeEditIngredientCoordinator = RecipeEditCoordinator(
            editModel: recipeModel.ingredients[index]
        ) { ingredientModel in
            self.recipeModel.ingredients[index] = ingredientModel
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

    var body: some View {
        RecipeDetailView<RecipeDetailCoordinator>(
            recipe: $coordinator.recipeModel
        )
        .environment(coordinator)
        .environment(\.editMode, $coordinator.editMode)
        .toolbar {
            ToolbarItem(id: "editButton", placement: .primaryAction) {
                if coordinator.editMode == .inactive {
                    Button(action: {
                        withAnimation {
                            coordinator.editRecipe()
                        }
                    }, label: {
                        Image(systemName: "pencil")
                            .bold()
                    })
                    .buttonBorderShape(.circle)
                    .buttonStyle(.bordered)
                } else {
                    Button(action: {
                        withAnimation {
                            coordinator.saveEdit()
                        }
                    }, label: {
                        Text("Fertig")
                    })
                    .disabled(!coordinator.isRecipeValid)
                }
            }
            if coordinator.editMode == .active {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        withAnimation {
                            coordinator.cancelEdit()
                        }
                    }, label: {
                        Text("Abbrechen")
                    })
                }
            }
        }
        .navigationBarBackButtonHidden($coordinator.editMode.wrappedValue == .active)
        .sheet(item: $coordinator.imagePickerCoordinator) { coordinator in
            coordinator.rootView
        }
        .sheet(
            item: $coordinator.attachmentDetailCoordinator
        ) { coordinator in
            coordinator.rootView
        }
        .sheet(
            item: $coordinator.recipeEditStepCoordinator
        ) { coordinator in
            coordinator.rootView
                .presentationDetents([.height(400), .large])
        }
        .sheet(
            item: $coordinator.recipeEditIngredientCoordinator
        ) { coordinator in
            coordinator.rootView
                .presentationDetents([.height(400), .large])
        }
    }
}

#Preview {
    NavigationStack {
        RecipeDetailCoordinatorView(
            coordinator: RecipeDetailCoordinator(recipeModel: recipeModelMock)
        )
    }
}
