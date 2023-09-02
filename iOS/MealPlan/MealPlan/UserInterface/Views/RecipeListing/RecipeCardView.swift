//
//  RecipeTeaserCardView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 27.08.23.
//

import SwiftUI

struct RecipeCardView: View {
    var body: some View {
        VStack(alignment: .leading ){
            Image("ExampleRecipe")
                .resizable()
                .scaledToFill()
                .frame(height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .contentShape(RoundedRectangle(cornerRadius: 10))
            Text("Recipe Name")
                .font(.title3)
                .multilineTextAlignment(.leading)
        }.background(.green)
    }
}

struct RecipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCardView()
    }
}
