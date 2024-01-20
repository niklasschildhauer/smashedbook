//
//  RecipeEditIngredientSectionView.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 14.01.24.
//

import SwiftUI

struct RecipeEditIngredientSectionView: View {
    @Binding var ingredients: [RecipeIngredientModel]
    
    var body: some View {
        ListSectionView (content: {
            ForEach($ingredients.indices, id: \.self) { ingredientIndex in
                HStack(alignment: .top) {
                    TextField(text: $ingredients[ingredientIndex].name) {
                        Text("Paprika")
                    }
                    Spacer()
                    HStack(alignment: .firstTextBaseline, spacing: 5) {
                        TextField(text: $ingredients[ingredientIndex].value) {
                            Text("500")
                        }
                        TextField(text: $ingredients[ingredientIndex].unit) {
                            Text("kg")
                        }
                    }
                }
            }
        }, bottomAction: {
            Button(action: {
                ingredients.append(RecipeIngredientModel(name: "", value: "", unit: ""))
            }, label: {
                Text("Hinzufügen")
            })
        })
    }
}

#Preview {
    RecipeEditIngredientSectionView(ingredients: .constant([RecipeIngredientModel(name: "Ingwer", value: "1/2", unit: "Stück"), RecipeIngredientModel(name: "Mehr", value: "500", unit: "Gramm")]))
}
