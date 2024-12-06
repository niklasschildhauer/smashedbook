//
//  RecipeEditCoordinator.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 05.10.23.
//

import SwiftUI

enum RecipeEditContentType {
    case step(stepModel: RecipeStepModel)
    case ingredient(ingredientModel: RecipeIngredientModel)
}

@Observable class RecipeEditStepCoordinator: SwiftUICoordinator, Identifiable {
    typealias CoordinatorView = RecipeEditStepCoordinatorView
    
    var rootView: RecipeEditStepCoordinatorView {
        RecipeEditStepCoordinatorView(coordinator: self)
    }
    var stepModel: RecipeStepModel
    var onSave: (RecipeStepModel) -> Void
            
    init(stepModel: RecipeStepModel,
         onSave: @escaping (RecipeStepModel) -> Void) {
        self.stepModel = stepModel
        self.onSave = onSave
    }
    
    func start() { }
    
    func save() {
        onSave(stepModel)
    }
}

struct RecipeEditStepCoordinatorView: View {
    @State var coordinator: RecipeEditStepCoordinator
    
    var body: some View {
        NavigationStack {
            RecipeEditStepView(description: $coordinator.stepModel.description)
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
    RecipeEditStepCoordinatorView(coordinator: RecipeEditStepCoordinator(stepModel: .init(description: "Test"), onSave: { _ in
        print("Did save")
    }))
}
