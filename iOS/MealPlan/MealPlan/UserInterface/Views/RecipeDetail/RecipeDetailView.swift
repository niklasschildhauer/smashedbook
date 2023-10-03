//
//  RecipeView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 15.09.23.
//

import SwiftUI

struct RecipeDetailView: View {
    @Binding var recipe: RecipeModel
    var body: some View {
        VStack {
            Text(recipe.title)
        }
    }
}

#Preview {
    RecipeDetailView(recipe: .constant(recipeModelMock))
}
