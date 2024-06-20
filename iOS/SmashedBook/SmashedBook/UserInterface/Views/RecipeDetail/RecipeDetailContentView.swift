//
//  RecipeView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 15.09.23.
//

import SwiftUI

struct RecipeDetailContentView: View {
    @Binding var recipe: RecipeModel
    @State var open = false
    
    var didTapShowAttachment: ((ImageResourceModel) -> Void)? = nil
    
    var body: some View {
        List {
            RecipeDetailHeaderView(title: $recipe.title)
            RecipeDetailIngredientsView(ingredients: $recipe.ingredients)
            RecipeDetailStepsView(steps: $recipe.steps)
            RecipeDetailAttachmentsView(attachments: $recipe.attachments) { attachment in
                didTapShowAttachment?(attachment)
            }
        }
        .ignoresSafeArea(.container, edges: .top)
        .listStyle(.plain)
        .coordinateSpace(.named("stack"))
        .sheet(isPresented: $open, content: {
            Text("Test")
        })
    }
}

#Preview {
    RecipeDetailContentView(recipe: .constant(recipeModelMock))
}

