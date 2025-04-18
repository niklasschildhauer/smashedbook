//
//  RecipeView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 15.09.23.
//

import SwiftUI

struct RecipeDetailView<Coordinator>: View where Coordinator: RecipeDetailCoordinating {
    @Binding var recipe: RecipeModel
    @EnvironmentObject var coordinator:  Coordinator
    
    var body: some View {
        List {
            RecipeDetailGeneralInfoView<Coordinator>(generalInfo: $recipe.generalInformation)
            RecipeDetailIngredientsView<Coordinator>(ingredients: $recipe.ingredients)
            RecipeDetailStepsView<Coordinator>(steps: $recipe.steps)
            RecipeDetailAttachmentsView<Coordinator>(attachments: $recipe.attachments)
        }
        .scrollDismissesKeyboard(.interactively)
        .listStyle(.plain)
    }
}

#Preview {
    RecipeDetailView<RecipeDetailCoordinator>(recipe: .constant(recipeModelMock))
        .environment(RecipeDetailCoordinator(recipeModel: recipeModelMock))
        .environment(\.editMode, .constant(EditMode.inactive))
}

