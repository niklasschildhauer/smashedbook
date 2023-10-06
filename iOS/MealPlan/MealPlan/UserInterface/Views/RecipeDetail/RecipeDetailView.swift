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
        VStack(alignment: .leading){
            Text(recipe.title)
            Text("Kalorien: \(recipe.metaInformation.energy ?? 0)")
            Text("Mahlzeit: \(recipe.metaInformation.meal.rawValue)")
            Text("Steps: \(recipe.steps.count)")
        }
    }
}

#Preview {
    RecipeDetailView(recipe: .constant(recipeModelMock))
}
