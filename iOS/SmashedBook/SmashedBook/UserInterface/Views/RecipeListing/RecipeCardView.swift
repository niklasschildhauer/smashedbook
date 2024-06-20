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
        ZStack(alignment: .bottom ){
            Image("ExampleRecipe")
                .resizable()
                .scaledToFill()
                .frame(height: 200)
            RecipeDetailTitleView(title: recipe.title)
                .fill(.width, alignment: .bottom)
                .padding(.bottom, LayoutConstants.safeAreaSpacing)
                .background(
                    LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom)
                )
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .contentShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct RecipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCardView(recipe: recipeModelMock)
    }
}
