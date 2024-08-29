//
//  DetailRecipeCoordinatorView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 02.10.23.
//

import SwiftUI

@Observable class RecipeDetailCoordinator: SwiftUICoordinator {
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
}

struct RecipeDetailCoordinatorView: View {
    @State var coordinator: RecipeDetailCoordinator
    @Environment(\.editMode) var editMode

    var body: some View {
        RecipeDetailView(recipe: $coordinator.recipeModel, addAttachment: coordinator.addAttachment)
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
        .sheet(item: $coordinator.addImageCoordinator) { coordinator in
            coordinator.rootView
        }
        .environment(coordinator)
    }
}

#Preview {
    RecipeDetailCoordinatorView(coordinator: RecipeDetailCoordinator(recipeModel: recipeModelMock))
}
