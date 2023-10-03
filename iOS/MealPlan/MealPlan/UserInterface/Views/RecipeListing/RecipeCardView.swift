//
//  RecipeTeaserCardView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 27.08.23.
//

import SwiftUI
import Combine

struct RecipeCardView: View {
    var recipe: RecipeModel
    
    var body: some View {
        VStack(alignment: .leading ){
            Image("ExampleRecipe")
                .resizable()
                .scaledToFill()
                .frame(height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .contentShape(RoundedRectangle(cornerRadius: 10))
            Text(recipe.title)
                .font(.title3)
                .multilineTextAlignment(.leading)
        }.background(.green)
    }
}

struct RecipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCardView(recipe: recipeModelMock)
    }
}
