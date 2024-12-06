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
    var recipeStep: RecipeStepModel
    var onSave: (RecipeStepModel) -> Void
            
    init(recipeStep: RecipeStepModel,
         onSave: @escaping (RecipeStepModel) -> Void) {
        self.recipeStep = recipeStep
        self.onSave = onSave
    }
    
    func start() { }
    
    func save() {
        onSave(recipeStep)
    }
}

struct RecipeEditCoordinatorView: View {
    @State var coordinator: RecipeEditCoordinator
    
    var body: some View {
        NavigationStack {
            RecipeEditStepView(description: $coordinator.recipeStep.description)
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button("Save") {
                            coordinator.save()
                        }
                    }
                }
        }
    }
}

#Preview {
    RecipeEditCoordinatorView(coordinator: RecipeEditCoordinator(recipeStep: .init(description: "Test"), onSave: { _ in
        print("Did save")
    }))
}
