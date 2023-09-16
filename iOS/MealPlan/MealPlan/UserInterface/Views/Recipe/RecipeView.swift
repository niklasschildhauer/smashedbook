//
//  RecipeView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 15.09.23.
//

import SwiftUI

struct RecipeView: View {
    @Binding var recipe: Recipe
    var body: some View {
        VStack {
            Text(recipe.title)
            ForEach($recipe.ingredients, id:  \.id) { ingredient in
                switch ingredient.type.wrappedValue {
                case .description(let descriptionText):
                   Text(descriptionText)
                case .image(let imageUrl):
                    EditRecipeImageListCellView(image: Image("ExampleRecipe"))
                    
                }
                Divider()            }
            
        }
        
            
    }
}

#Preview {
    RecipeView(recipe: .constant(recipeModelMock))
}
