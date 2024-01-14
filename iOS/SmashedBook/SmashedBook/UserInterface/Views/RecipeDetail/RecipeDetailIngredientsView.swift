//
//  RecipeDetailIngredientsView.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 14.01.24.
//

import SwiftUI

struct RecipeDetailIngredientsView: View {
    @Binding var ingredients: [RecipeIngredientModel]
    var body: some View {
        ListSectionView(title: "Zutaten") {
            ForEach($ingredients.indices, id: \.self) { ingredientIndex in
                HStack(alignment: .top) {
                    Text(ingredients[ingredientIndex].name)
                    Spacer()
                    HStack(alignment: .firstTextBaseline, spacing: 5) {
                        Text(ingredients[ingredientIndex].value)
                        Text(ingredients[ingredientIndex].unit)
                            .fontWeight(.semibold)
                            .font(.footnote)
                            .foregroundStyle(.black)
                    }
                }
                .listRowSeparator(.hidden)
            }
        }
    }
}

#Preview {
    RecipeDetailIngredientsView(ingredients: .constant([RecipeIngredientModel(name: "Ingwer", value: "1/2", unit: "Stück"), RecipeIngredientModel(name: "Mehr", value: "500", unit: "Gramm")]))
}
