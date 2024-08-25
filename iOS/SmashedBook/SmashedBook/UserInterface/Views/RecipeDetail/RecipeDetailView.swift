//
//  RecipeView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 15.09.23.
//

import SwiftUI

struct RecipeDetailView: View {
    @Binding var recipe: RecipeModel
    @Binding var selectedRecipeStep: RecipeStepModel?
    
    var didTapShowAttachment: ((ImageResourceModel) -> Void)? = nil
    
    var body: some View {
        List {
            RecipeDetailHeaderView(title: $recipe.title)
            RecipeDetailStepsView(steps: $recipe.steps, selectedRecipeStep: $selectedRecipeStep)
            RecipeDetailAttachmentsView(attachments: $recipe.attachments) { attachment in
                didTapShowAttachment?(attachment)
            }
        }
        .ignoresSafeArea(.container, edges: .top)
        .listStyle(.plain)
        .coordinateSpace(.named("stack"))
    }
}

#Preview {
    RecipeDetailView(recipe: .constant(recipeModelMock), selectedRecipeStep: .constant(nil))
}

