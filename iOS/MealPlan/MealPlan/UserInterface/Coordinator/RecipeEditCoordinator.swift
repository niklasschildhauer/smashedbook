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
    
    let recipesDataSource: RecipesDataSource
    
    var recipeModel: RecipeModel
    var validateErrorMessage: String?
    var addContentCoordinator: RecipeAddContentCoordinator? = nil
    
    init(recipesDataSource: RecipesDataSource, recipeModel: RecipeModel) {
        self.recipesDataSource = recipesDataSource
        self._recipeModel = recipeModel
    }
    
    func start() { }
    
    func save() async {
        if isRecipeValid() {
            // TODO: It does not reset the binded value!
            recipesDataSource.save(recipe: recipeModel)
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
            return false
        }
        
        validateErrorMessage = ""
        return true
    }
}

struct RecipeEditCoordinatorView: View {
    @State var coordinator: RecipeEditCoordinator
    
    var body: some View {
        RecipeEditView(recipe: $coordinator.recipeModel,
                       didTapAddIngredient: {
            coordinator.addContentCoordinator = RecipeAddContentCoordinator(didAddRecipeContent: {
                recipeContentModel in
                coordinator.recipeModel.ingredients.append(recipeContentModel)
                coordinator.addContentCoordinator = nil
                })
        },
                       didTapAddStep:  {
            coordinator.addContentCoordinator = RecipeAddContentCoordinator( didAddRecipeContent: { recipeContentModel in
                coordinator.recipeModel.steps.append(recipeContentModel)
                coordinator.addContentCoordinator = nil
            })
        })
        .onAppear {
            coordinator.start()
        }
        .sheet(item: $coordinator.addContentCoordinator) { coordinator in
            coordinator.rootView
        }
        // TODO: Does this work?
        if let validateErrorMessage = coordinator.validateErrorMessage {
            Text(validateErrorMessage)
        }
    }
}

#Preview {
    RecipeEditCoordinatorView(coordinator: .init(recipesDataSource: .init(), recipeModel: recipeModelMock))
}
