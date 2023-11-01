//
//  RecipeEditCoordinator.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 05.10.23.
//

import SwiftUI

@Observable class RecipeEditCoordinator: Coordinator, Identifiable {
    typealias CoordinatorView = RecipeEditCoordinatorView
    
    var rootView: RecipeEditCoordinatorView {
        RecipeEditCoordinatorView(coordinator: self)
    }
        
    var recipeModel: RecipeModel {
        didSet {
            isRecipeEdited = true
        }
    }
    var validateErrorMessage: String?
    var addContentCoordinator: RecipeAddContentCoordinator? = nil
    // TODO: how to avoid this overhead of saving the recipe twice?
    var didEditRecipeModel: ((RecipeModel) -> Void)?
    var isRecipeEdited = false
    
    init(recipeModel: RecipeModel, onSaveRecipe: ((RecipeModel) -> Void)? = nil) {
        self._recipeModel = recipeModel
        self.didEditRecipeModel = onSaveRecipe
    }
    
    func start() { }
    
    func save() async {
        if isRecipeValid() {
            // TODO: It does not reset the binded value!
            didEditRecipeModel?(recipeModel)
        } else {
            // TODO: Handle this!
            print("I am not gonna save it!")
        }
    }
    
    // TODO: Outsource to recipeValidator
    func isRecipeValid() -> Bool {
        guard recipeModel.title != "" else {
            validateErrorMessage = "Rezeptname nicht ausgefüllt"
            return false
        }
        
        guard recipeModel.metaInformation.energy != nil else {
            validateErrorMessage = "Kalorien ausfüllen"
            return false
        }
        
        guard !recipeModel.steps.isEmpty else {
            validateErrorMessage = "Das Rezept ist leer"
            return true
        }
        
        validateErrorMessage = ""
        return true
    }
}

struct RecipeEditCoordinatorView: View {
    @State var coordinator: RecipeEditCoordinator
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        RecipeEditView(recipe: $coordinator.recipeModel,
                       didTapAddAttachment: {
            coordinator.addContentCoordinator = RecipeAddContentCoordinator(didAddRecipeContent: {
                recipeContentModel in
                coordinator.recipeModel.ingredients.append(recipeContentModel)
                coordinator.addContentCoordinator = nil
                })
        })
        .uiTestIdentifier("recipeEditCoordinator")
        .bottomToolbar {
            HStack {
                IconFilledButtonView(icon: Image(systemName: "xmark")) {
                    dismiss()
                }
                Spacer()
                IconLabelFilledButtonView(title: "Speichern") {
                    Task {
                        await coordinator.save()
                    }
                }
            }
        }
        .onAppear {
            coordinator.start()
        }
        .sheet(item: $coordinator.addContentCoordinator) { coordinator in
            coordinator.rootView
        }
        .interactiveDismissDisabled(coordinator.isRecipeEdited)
        .scrollDismissesKeyboard(.interactively)
        // TODO: Does this work?
        if let validateErrorMessage = coordinator.validateErrorMessage {
            Text(validateErrorMessage)
        }
    }
}

#Preview {
    RecipeEditCoordinatorView(coordinator: .init(recipeModel: recipeModelMock))
}
