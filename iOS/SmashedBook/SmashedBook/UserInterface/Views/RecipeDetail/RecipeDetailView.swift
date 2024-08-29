//
//  RecipeView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 15.09.23.
//

import SwiftUI

struct RecipeDetailView: View {
    @Binding var recipe: RecipeModel
    
    var addAttachment: () -> Void
    
    var body: some View {
        List {
            RecipeDetailHeaderView(title: $recipe.title)
            RecipeDetailStepsView(steps: $recipe.steps)
            RecipeDetailAttachmentsView(attachments: $recipe.attachments, addAttachment: addAttachment)
        }
        .ignoresSafeArea(.container, edges: .top)
        .listStyle(.plain)
        .coordinateSpace(.named("stack"))
    }
}


