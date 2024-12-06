//
//  RecipeView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 15.09.23.
//

import SwiftUI

struct RecipeDetailView<Coordinator>: View where Coordinator: RecipeDetailCoordinating {
    @Binding var recipe: RecipeModel
    
    var body: some View {
        List {
            RecipeDetailHeaderView(title: $recipe.title)
            RecipeDetailStepsView<Coordinator>(steps: $recipe.steps)
            RecipeDetailAttachmentsView<Coordinator>(attachments: $recipe.attachments)
        }
        .ignoresSafeArea(.container, edges: .top)
        .listStyle(.plain)
        .coordinateSpace(.named("stack"))
    }
}


