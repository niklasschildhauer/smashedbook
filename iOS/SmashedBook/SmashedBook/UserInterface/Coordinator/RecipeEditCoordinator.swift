//
//  RecipeEditCoordinator.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 05.10.23.
//

import SwiftUI

@Observable class RecipeEditCoordinator: SwiftUICoordinator, Identifiable {
    typealias CoordinatorView = RecipeEditCoordinatorView
    
    var rootView: RecipeEditCoordinatorView {
        RecipeEditCoordinatorView(coordinator: self)
    }
    
    var recipeModel: RecipeModel {
        didSet {
            isRecipeEdited = true
        }
    }
    var addImageCoordinator: RecipeAddImageCoordinator? = nil
    // TODO: how to avoid this overhead of saving the recipe twice?
    var didEditRecipeModel: ((RecipeModel) -> Void)?
    var isRecipeEdited = false
    
    private var attachmentDataSource = FileSystemAttachmentDataSource()
    
    init(recipeModel: RecipeModel, onSaveRecipe: ((RecipeModel) -> Void)? = nil) {
        self._recipeModel = recipeModel
        self.didEditRecipeModel = onSaveRecipe
    }
    
    func start() { }
    
    func save() async {
        if recipeModel.isValid {
            // TODO: It does not reset the binded value!
            didEditRecipeModel?(recipeModel)
        } else {
            // TODO: Handle this!
            print("I am not gonna save it!")
        }
    }
}

struct RecipeEditCoordinatorView: View {
    @State var coordinator: RecipeEditCoordinator
    
    var body: some View {
        RecipeEditView(recipe: $coordinator.recipeModel, 
                       addAttachmentCoordinator: $coordinator.addImageCoordinator)
        .uiTestIdentifier("recipeEditCoordinator")
        .bottomToolbar {
            IconLabelFilledButtonView(title: "Speichern") {
                Task {
                    await coordinator.save()
                }
            }
        }
        .onAppear {
            coordinator.start()
        }
        .sheet(item: $coordinator.addImageCoordinator) { coordinator in
            coordinator.rootView
        }
        .interactiveDismissDisabled(coordinator.isRecipeEdited)
        .scrollDismissesKeyboard(.interactively)
    }
}

#Preview {
    RecipeEditCoordinatorView(coordinator: .init(recipeModel: recipeModelMock))
}
