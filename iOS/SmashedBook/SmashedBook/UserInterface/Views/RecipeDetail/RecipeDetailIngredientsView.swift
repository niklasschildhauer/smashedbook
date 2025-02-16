//
//  RecipeDetailStepsView.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 14.01.24.
//

import SwiftUI

protocol RecipeDetailIngredientDelegate: ObservableObject {
    func editRecipeIngredient(at index: Int)
    func addRecipeIngredient()
}

struct RecipeDetailIngredientsView<Coordinator>: View where Coordinator: RecipeDetailIngredientDelegate {
    @EnvironmentObject var coordinator:  Coordinator
    @Binding var ingredients: [RecipeIngredientModel]

    var body: some View {
        ListSectionView(title: "Zutaten", content: {
            ForEach($ingredients.indices, id: \.self) { ingredientIndex in
                Button(action: {
                    coordinator.editRecipeIngredient(at: ingredientIndex)
                }, label: {
                    HStack(alignment: .firstTextBaseline, spacing: LayoutConstants.horizontalSpacing) {
                        Text(stepName(for: ingredientIndex))
                            .fontWeight(.semibold)
                            .font(.footnote)
                        RecipeDetailIngredientView(ingredient: $ingredients[ingredientIndex])
                    }
                })
                .listRowSeparator(.hidden)
            }
            .onDelete(perform: deleteStep)
        }, trailingAction: {
            Button {
                coordinator.addRecipeIngredient()
            } label: {
                Text("Hinzufügen").font(.footnote)
            }
        })
    }
    
    func stepName(for index: Int) -> String {
        return "\(index + 1)."
    }
    
    func deleteStep(atOffsets offsets: IndexSet) {
        ingredients.remove(atOffsets: offsets)
    }
}
