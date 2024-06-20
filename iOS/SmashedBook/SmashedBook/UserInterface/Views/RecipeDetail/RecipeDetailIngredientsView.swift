//
//  RecipeDetailIngredientsView.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 14.01.24.
//

import SwiftUI

struct RecipeDetailIngredientsView: View {
    var ingredient: RecipeIngredientModel
    
    var body: some View {
        HStack(alignment: .top) {
            Text(ingredient.name)
            Spacer()
            HStack(alignment: .firstTextBaseline, spacing: 5) {
                Text(ingredient.value)
                Text(ingredient.unit)
                    .fontWeight(.semibold)
                    .font(.footnote)
                    .foregroundStyle(.black)
            }
        }
    }
}

#Preview {
    RecipeDetailIngredientsView(ingredient: RecipeIngredientModel(name: "Ingwer", value: "1/2", unit: "Stück"))
}
