//
//  RecipeView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 15.09.23.
//

import SwiftUI

struct RecipeDetailPageView: View {
    @State var recipe: Recipe
    @State var isEditing = false
    
    @ViewBuilder var content: some View {
        if isEditing {
            EditRecipeView(recipe: $recipe)
        } else {
            RecipeView(recipe: $recipe)
        }
    }
    
    var body: some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    LabelButtonView(viewModel: .create(action: {
                        isEditing.toggle()
                    },
                                                       title: "Bearbeiten",
                                                       type: .primary))
                    .uiTestIdentifier("editrecipeButton")
                })
            }
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    RecipeDetailPageView(recipe: recipeModelMock)
}
